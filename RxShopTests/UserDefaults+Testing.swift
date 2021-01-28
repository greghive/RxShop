//
//  UserDefaults+Testing.swift
//  RxShopTests
//
//  Created by Greg Price on 28/01/2021.
//

import Foundation

extension UserDefaults {
    
    static var nonPersistent: UserDefaults {
        let defaults = UserDefaults(suiteName: #file)
        defaults?.removePersistentDomain(forName: #file)
        return defaults!
    }
}
