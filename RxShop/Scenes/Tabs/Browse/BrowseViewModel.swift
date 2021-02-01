//
//  BrowseViewModel.swift
//  RxShop
//
//  Created by Greg Price on 01/02/2021.
//

import RxSwift

struct BrowseInput {
    let viewWillAppear: Observable<Void>
    let refresh: Observable<Void>
    let select: Observable<IndexPath>
}

struct BrowseOutput {
    let products: Observable<[Product]>
}

typealias BrowseAction = Result<Product>

func browseViewModel() -> (_ input: BrowseInput) -> (output: BrowseOutput, action: Observable<BrowseAction>) {
    return { input in
        
        let response = Observable
            .merge(input.viewWillAppear.take(1), input.refresh)
            .flatMapLatest { dataTask(with: URLRequest.products()) }
            .share(replay: 1)
        
        let products = response
            .compactMap { $0.success }
            .map { try jsonDecoder().decode([Product].self, from: $0) }
            .share(replay: 1)

        let output = BrowseOutput(products: products)
        
        let selected = input.select
            .withLatestFrom(products) { $1[$0.row] }
            .map { BrowseAction.success($0) }
        
        let error = response
            .compactMap { $0.error }
            .map { BrowseAction.error($0) }
        
        let action = Observable
            .merge(selected, error)
        
        return (output: output, action: action)
    }
}
