//
//  Appearences.swift
//  RxShop
//
//  Created by Greg Price on 18/02/2021.
//

import UIKit

func configureAppearences() {
    let navigationBar = UINavigationBar.appearance()
    navigationBar.tintColor = .rxShopRed
    navigationBar.titleTextAttributes = [
        NSAttributedString.Key.font: UIFont.heavyFont(size: .large),
        NSAttributedString.Key.foregroundColor: UIColor.rxShopRed
    ]
    UITabBar.appearance().tintColor = .rxShopRed
}

