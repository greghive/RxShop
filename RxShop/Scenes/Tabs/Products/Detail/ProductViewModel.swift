//
//  ProductViewModel.swift
//  RxShop
//
//  Created by Greg Price on 01/02/2021.
//

import RxSwift
import RxCocoa

struct ProductInput {
    let buy: Observable<Void>
}

struct ProductOutput {
    let title: Driver<String>
}


typealias ProductAction = Product

func productViewModel(product: Product) -> (_ input: ProductInput) -> (output: ProductOutput, action: Observable<ProductAction>) {
    return { input in
       
        let title = Observable
            .just(product.title)
            .asDriver(onErrorJustReturn: "")
        
        let output = ProductOutput(title: title)
        
        let action = input
            .buy
            .map { product }
        
        return (output, action)
    }
}
