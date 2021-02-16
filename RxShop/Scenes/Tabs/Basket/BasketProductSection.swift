//
//  BasketProductSection.swift
//  RxShop
//
//  Created by Greg Price on 16/02/2021.
//

import Foundation
import RxDataSources

struct BasketProductSection {
    let uuid: UUID
    var basketProducts: [BasketProduct]
    
    init(_ basketProducts: [BasketProduct]) {
        self.uuid = UUID()
        self.basketProducts = basketProducts
    }
}

extension BasketProductSection: Equatable { }

func ==(lhs: BasketProductSection, rhs: BasketProductSection) -> Bool {
    return lhs.uuid == rhs.uuid
}

extension BasketProductSection: AnimatableSectionModelType {
    typealias Item = BasketProduct
    typealias Identity = UUID
    
    var identity: UUID {
        return uuid
    }
    
    var items: [BasketProduct] {
        return basketProducts
    }
    
    init(original: BasketProductSection, items: [Item]) {
        self = original
        self.basketProducts = items
    }
}
