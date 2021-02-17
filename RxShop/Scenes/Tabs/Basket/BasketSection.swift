//
//  BasketProductSection.swift
//  RxShop
//
//  Created by Greg Price on 16/02/2021.
//

import Foundation
import RxDataSources

struct BasketSection {
    let uuid: UUID
    var basketProducts: [BasketProduct]
    
    init(_ basketProducts: [BasketProduct]) {
        self.uuid = UUID()
        self.basketProducts = basketProducts
    }
}

extension BasketSection: Equatable { }

func ==(lhs: BasketSection, rhs: BasketSection) -> Bool {
    return lhs.uuid == rhs.uuid
}

extension BasketSection: AnimatableSectionModelType {
    typealias Item = BasketProduct
    typealias Identity = UUID
    
    var identity: UUID {
        return uuid
    }
    
    var items: [BasketProduct] {
        return basketProducts
    }
    
    init(original: BasketSection, items: [Item]) {
        self = original
        self.basketProducts = items
    }
}
