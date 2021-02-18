//
//  UIFont+AppFonts.swift
//  RxShop
//
//  Created by Greg Price on 18/02/2021.
//

import UIKit

enum FontSize: CGFloat {
    case smaller = 12.0
    case small = 14.0
    case regular = 16.0
    case large = 20.0
}

extension UIFont {
    
    static func regularFont(size: FontSize) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue)
    }
    
    static func boldFont(size: FontSize) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size.rawValue)
    }
    
    static func heavyFont(size: FontSize) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue, weight: .heavy)
    }    
}
