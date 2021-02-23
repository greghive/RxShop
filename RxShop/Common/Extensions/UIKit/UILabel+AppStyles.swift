//
//  UILabel+AppStyles.swift
//  RxShop
//
//  Created by Greg Price on 18/02/2021.
//

import UIKit

//remove
enum LabelStyle {
    case title
    case body
    case tag
}

extension UILabel {
    
    static var title: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .heavyFont(size: .regular)
        label.textColor = .label
        return label
    }
    
    static var body: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regularFont(size: .small)
        label.textColor = .secondaryLabel
        return label
    }
    
    static var tag: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .heavyFont(size: .small) // do we use multiple sizes here? smallTag / largeTag ???
        return label // if we use different sizes and colors, just bin this????
    }
    
    // remove
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
