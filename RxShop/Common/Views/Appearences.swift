//
//  Appearences.swift
//  RxShop
//
//  Created by Greg Price on 18/02/2021.
//

import UIKit

struct Appearences {
    static func configure() {
        let navigationBar = UINavigationBar.appearance()
        navigationBar.tintColor = .rxShopRed
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.heavyFont(size: .large),
            NSAttributedString.Key.foregroundColor: UIColor.rxShopRed
        ]
        UITabBar.appearance().tintColor = .rxShopRed
    }
}

