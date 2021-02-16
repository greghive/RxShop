//
//  BasketProduct.swift
//  RxShop
//
//  Created by Greg Price on 16/02/2021.
//

import Foundation
import RxDataSources

struct BasketProduct {
    let uuid: UUID
    let product: Product
    
    init(_ product: Product) {
        self.uuid = UUID()
        self.product = product
    }
}

extension BasketProduct: IdentifiableType, Equatable {
    typealias Identity = UUID
    var identity: UUID {
        return uuid
    }
}

func ==(lhs: BasketProduct, rhs: BasketProduct) -> Bool {
    return lhs.uuid == rhs.uuid
}
