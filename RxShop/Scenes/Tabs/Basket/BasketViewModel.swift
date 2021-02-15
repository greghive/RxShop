//
//  BasketViewModel.swift
//  RxShop
//
//  Created by Greg Price on 15/02/2021.
//

import RxSwift

struct BasketInput {
    let delete: Observable<IndexPath>
}

struct BasketOutput {
    let products: Observable<[Product]>
}

func basketViewModel(products: Observable<[Product]>) -> (_ input: BasketInput) -> (output: BasketOutput, action: Observable<Product>) {
    return { input in
        let delete = input.delete.withLatestFrom(products) { $1[$0.row] }
        let output = BasketOutput(products: products)
        return (output, delete)
        
        //TODO: need empty state for table (did something on this for Contact?)
    }
}
