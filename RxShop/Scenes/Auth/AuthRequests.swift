//
//  AuthRequests.swift
//  RxShop
//
//  Created by Greg Price on 20/01/2021.
//

import Foundation

struct SignUpBody: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}

struct SignInBody: Encodable {
    let email: String
    let password: String
}

extension URLRequest {
    
    static func signUp(_ params: SignUpBody) -> URLRequest {
        var request = baseRequest(method: .post, path: "/users/signup")
        request.httpBody = try? jsonEncoder().encode(params)
        return request
    }
    
    static func signIn(_ params: SignInBody) -> URLRequest {
        var request = baseRequest(method: .post, path: "/users/signin")
        request.httpBody = try? jsonEncoder().encode(params)
        return request
    }
}
