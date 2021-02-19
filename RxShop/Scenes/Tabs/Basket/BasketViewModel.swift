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
    let basket: Observable<[BasketSection]>
    let checkoutVisible: Observable<(visible: Bool, animated: Bool)>
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
        
        let section = BasketSection([])
        let seed = BasketState([section])
        
        let basket = Observable
            .merge(addToBasket, removeFromBasket)
            .scan(seed) { (state, action) in
                state.execute(action)
            }
            .map { $0.sections }
            .share(replay: 1)
        
        let basketCount = basket
            .map { $0[0] }
            .map { $0.basketProducts.count }
            .share(replay: 1)
        
        let checkoutVisible = basketCount
            .map { $0 == 0 ? (visible: false, animated: true) : (visible: true, animated: true) }
            .startWith((visible: false, animated: false))

        let output = BasketOutput(basket: basket, checkoutVisible: checkoutVisible)
        
        return(output: output, basketCount: basketCount)
    }
}

struct BasketState {
    
    fileprivate var sections: [BasketSection]
    init(_ sections: [BasketSection]) {
        self.sections = sections
    }
    
    func execute(_ action: BasketAction) -> BasketState {
        switch action {
        
        case .add(let product):
            var sections = self.sections
            let items = sections[0].basketProducts + [product]
            sections[0] = BasketSection(original: sections[0], items: items)
            return BasketState(sections)
        
        case .remove(let indexPath):
            var sections = self.sections
            var items = sections[0].basketProducts
            items.remove(at: indexPath.row)
            sections[0] = BasketSection(original: sections[0], items: items)
            return BasketState(sections)
        }
    }

}

