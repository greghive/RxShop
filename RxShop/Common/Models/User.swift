//
//  User.swift
//  RxShop
//
//  Created by Greg Price on 18/01/2021.
//

struct User: Codable, Equatable {
    let id: String
    let firstName: String
    let lastName: String
}

extension User {
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}
