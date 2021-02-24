//
//  BrowseViewModel.swift
//  RxShop
//
//  Created by Greg Price on 01/02/2021.
//

import RxSwift
import RxCocoa

struct ProductsInput {
    let viewWillAppear: Observable<Void>
    let refresh: Observable<Void>
    let select: Observable<IndexPath>
}

struct ProductsOutput {
    let products: Observable<[Product]>
    let runningFirstFetch: Driver<Bool>
    let refreshEnded: Observable<Void>
}

typealias ProductsAction = Result<Product>

func productsViewModel() -> (_ input: ProductsInput) -> (output: ProductsOutput, action: Observable<ProductsAction>) {
    return { input in
        
        let firstAppear = input.viewWillAppear
            .take(1)
            .share(replay: 1)
        
        let response = Observable
            .merge(firstAppear, input.refresh)
            .flatMapLatest { dataTask(with: URLRequest.products()) }
            .share(replay: 1)
        
        let products = response
            .compactMap { $0.success }
            .map { try jsonDecoder().decode([Product].self, from: $0) }
            .share(replay: 1)

        let refreshEnded = response
            .delay(.milliseconds(500), scheduler: MainScheduler.instance)
            .asVoid()
        
        let selected = input.select
            .withLatestFrom(products) { $1[$0.row] }
            .map { ProductsAction.success($0) }
        
        let error = response
            .compactMap { $0.error }
            .map { ProductsAction.error($0) }
            .share(replay: 1)
        
        let action = Observable
            .merge(selected, error)
            .observe(on: MainScheduler.instance)
            .share(replay: 1)
        
        let runningFirstFetch = Observable.merge(
            firstAppear.map { _ in true },
            products.map { _ in false },
            error.map { _ in false })
            .asDriver(onErrorJustReturn: false)
        
        let output = ProductsOutput(products: products, runningFirstFetch: runningFirstFetch, refreshEnded: refreshEnded)
        
        return (output: output, action: action)
    }
}
