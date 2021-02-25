//
//  AuthCache.swift
//  RxShop
//
//  Created by Greg Price on 18/01/2021.
//

import Foundation

// ❌ this is for demo purposes only! (don't store user credentials in user defaults!) ❌

func cachedUser(from defaults: UserDefaults = .standard) -> User? {
    guard let data = defaults.data(forKey: "user") else { return nil }
    guard let user = try? jsonDecoder().decode(User.self, from: data) else { return nil }
    return user
}

@discardableResult
func cacheUser(_ user: User, to defaults: UserDefaults = .standard) -> Bool {
    guard let data = try? jsonEncoder().encode(user) else { return false }
    defaults.set(data, forKey: "user")
    return true
}

func clearUser(from defaults: UserDefaults = .standard) {
    defaults.set(nil, forKey: "user")
}
