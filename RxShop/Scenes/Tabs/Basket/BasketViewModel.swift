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
    let basket: Observable<[BasketProductSection]>
}

enum BasketAction {
    case add(BasketProduct)
    case remove(IndexPath)
}

typealias BasketCount = Int

func basketViewModel(addProduct: Observable<Product>) -> (_ input: BasketInput) -> (output: BasketOutput, basketCount: Observable<BasketCount>) {
    return { input in
                
        let addToBasket = addProduct
            .map { BasketProduct($0) }
            .map { BasketAction.add($0) }
        
        let removeFromBasket = input
            .delete
            .map { BasketAction.remove($0) }
        
        let basket = Observable
            .merge(addToBasket, removeFromBasket)
            .scan(into: [BasketProduct]()) { current, action in
                
                // create as an extension??? operator???
                switch action {
                case .add(let product):
                    current.append(product)
                case .remove(let indexPath):
                    current.remove(at: indexPath.row)
                }
            }
            .share(replay: 1)
        
        let basketCount = basket
            .map { $0.count }
        
        let basketSection = basket
            .map { [BasketProductSection($0)] }
        
        return(output: BasketOutput(basket: basketSection), basketCount: basketCount)        
    }
}

