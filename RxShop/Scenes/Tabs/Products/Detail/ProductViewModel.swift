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
    let price: Driver<String>
    let description: Driver<String>
}

func productViewModel(product: Product) -> (_ input: ProductInput) -> (output: ProductOutput, action: Observable<Product>) {
    return { input in
       
        let title = Driver.just(product.title)
        let price = Driver.just(product.price.decimalCurrencyString)
        let description = Driver.just(product.description)
        let output = ProductOutput(title: title, price: price , description: description)
        
        let action = input
            .buy
            .map { product }
        
        return (output, action)
    }
}
