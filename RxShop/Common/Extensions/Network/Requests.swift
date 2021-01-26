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
        var components = URLComponents(string: "http://127.0.0.1:8080")!
        components.path = path
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        return request
    }
}

func dataTask(with request: URLRequest) -> Observable<Data> {
    return URLSession.shared.rx.data(request: request)
}

func jsonEncoder() -> JSONEncoder {
    return JSONEncoder()
}

func jsonDecoder() -> JSONDecoder {
    return JSONDecoder()
}
