//
//  ProductRequests.swift
//  RxShop
//
//  Created by Greg Price on 01/02/2021.
//

import Foundation

extension URLRequest {
    
    static func products() -> URLRequest {
        return baseRequest(method: .get, path: "/products")
    }
}
