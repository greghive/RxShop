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
    let basket: Observable<[Product]>
}

enum BasketAction {
    case add(Product)
    case remove(IndexPath)
}

typealias BasketCount = Int

func basketViewModel(addProduct: Observable<Product>) -> (_ input: BasketInput) -> (output: BasketOutput, basketCount: Observable<BasketCount>) {
    return { input in
                
        let addToBasket = addProduct
            .map { BasketAction.add($0) }
        
        let removeFromBasket = input
            .delete
            .map { BasketAction.remove($0) }
        
        let basket = Observable
            .merge(addToBasket, removeFromBasket)
            .scan(into: [Product]()) { current, action in
                
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
        
        return(BasketOutput(basket: basket), basketCount)
    }
}

