//
//  Requests.swift
//  RxShop
//
//  Created by Greg Price on 19/01/2021.
//

import Foundation
import RxSwift

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

extension URLRequest {
    
    static func baseRequest(method: HTTPMethod, path: String) -> URLRequest {
        // TODO: switch this to a simple vapor app running on heroku
        var components = URLComponents(string: "https://my-json-server.typicode.com/greghive/rxshop")!
        components.path = path
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        return request
    }
}

func dataTask(with request: URLRequest) -> Observable<Data> {
    return URLSession.shared.rx.data(request: request)
}

func jsonEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    return encoder
}
