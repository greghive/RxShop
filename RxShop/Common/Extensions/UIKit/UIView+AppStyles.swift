//
//  UIView+AppStyles.swift
//  RxShop
//
//  Created by Greg Price on 19/02/2021.
//

import UIKit

enum ViewStyle {
    case infoCard
}

extension UIView {
    
    func style(_ viewStyle: ViewStyle) {
        switch viewStyle {
        case .infoCard:
            layer.cornerRadius = 12
            backgroundColor = .secondarySystemBackground
        }
    }
}
