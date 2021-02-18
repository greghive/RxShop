//
//  UILabel+AppStyles.swift
//  RxShop
//
//  Created by Greg Price on 18/02/2021.
//

import UIKit

enum LabelStyle {
    case title
    case body
    case tag
}

extension UILabel {
    
    func style(_ labelStyle: LabelStyle) {
        switch labelStyle {
        
        case .title:
            font = .heavyFont(size: .regular)
            textColor = .label
        case .body:
            font = .regularFont(size: .small)
            textColor = .secondaryLabel
        case .tag:
            font = .heavyFont(size: .small)
        }
    }
}
