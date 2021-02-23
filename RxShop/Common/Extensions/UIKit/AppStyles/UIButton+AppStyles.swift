//
//  UIButton+AppStyles.swift
//  RxShop
//
//  Created by Greg Price on 18/02/2021.
//

import UIKit

enum ButtonStyle {
    case red
    case green
}

enum ButtonSize {
    case small
    case big
}

extension UIButton {
    
    static var bigRed: UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.style(.red, size: .big)
        return button
    }
    
    static var bigGreen: UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.style(.green, size: .big)
        return button
    }
    
    func style(_ style: ButtonStyle, size: ButtonSize = .big) {
        let normalColor = colorFor(style)
        let darkerColor = normalColor.darker()
        let disabledColor = normalColor.withAlphaComponent(0.5)
        
        contentEdgeInsets = UIEdgeInsets(top: 12, left: 18, bottom: 12, right: 18)
        setBackgroundImage(UIImage(color: normalColor), for: .normal)
        setBackgroundImage(UIImage(color: darkerColor), for: .selected)
        setBackgroundImage(UIImage(color: disabledColor), for: .disabled)
        setTitleColor(.white, for: .normal)
        layer.borderColor = darkerColor.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 12
        layer.masksToBounds = true
        
        switch size {
        case .small:
            titleLabel?.font = .heavyFont(size: .small)
        case .big:
            heightAnchor.constraint(equalToConstant: 54).isActive = true
            titleLabel?.font = .heavyFont(size: .regular)
        }
    }
    
    func colorFor(_ style: ButtonStyle) -> UIColor {
        switch style {
        case .red: return .rxShopRed
        case .green: return .rxShopGreen
        }
    }
}
