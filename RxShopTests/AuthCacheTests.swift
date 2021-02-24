//
//  AuthCacheTests.swift
//  RxShopTests
//
//  Created by Greg Price on 28/01/2021.
//

import XCTest
@testable import RxShop

class AuthCacheTests: XCTestCase {

    func test_cacheUser() {
        let user = User(id: "1", firstName: "John", lastName: "Doe")
        let cached = cacheUser(user, to: .nonPersistent)
        XCTAssertTrue(cached)
    }
    
    func test_cachedUser() {
        let user = User(id: "2", firstName: "Taylor", lastName: "Swift")
        let defaults = UserDefaults.nonPersistent
        cacheUser(user, to: defaults)
        let cached = cachedUser(from: defaults)
        XCTAssertEqual(user, cached)
    }
    
    func test_clearUser() {
        let user = User(id: "3", firstName: "Jane", lastName: "Doe")
        _ = cacheUser(user, to: .nonPersistent)
        clearUser(from: .nonPersistent)
        let nilUser = cachedUser(from: .standard)
        XCTAssertNil(nilUser)
    }
}
