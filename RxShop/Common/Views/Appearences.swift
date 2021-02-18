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
        navigationBar.tintColor = .rxSwiftPink
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.heavyFont(size: .large),
            NSAttributedString.Key.foregroundColor: UIColor.rxSwiftPink
        ]
        UITabBar.appearance().tintColor = .rxSwiftPink
    }
}

