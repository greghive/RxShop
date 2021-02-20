//
//  UIButton+AppStyles.swift
//  RxShop
//
//  Created by Greg Price on 18/02/2021.
//

import UIKit

enum ButtonStyle {
    case pink
    case orange
}

enum ButtonSize {
    case small
    case regular
}

extension UIButton {
    
    func style(_ style: ButtonStyle, size: ButtonSize = .regular) {
        let normalColor = colorFor(style)
        let darkerColor = normalColor.darker()
        let disabledColor = normalColor.withAlphaComponent(0.5)
        
        contentEdgeInsets = UIEdgeInsets(top: 12, left: 18, bottom: 12, right: 18)
        setBackgroundImage(UIImage(color: normalColor), for: .normal)
        setBackgroundImage(UIImage(color: normalColor), for: .highlighted)
        setBackgroundImage(UIImage(color: normalColor), for: .selected)
        setBackgroundImage(UIImage(color: disabledColor), for: .disabled)
        setTitleColor(.white, for: .normal)
        layer.borderColor = darkerColor.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 12
        layer.masksToBounds = true
        
        switch size {
        
        case .small:
            titleLabel?.font = .heavyFont(size: .small)
        case .regular:
            heightAnchor.constraint(equalToConstant: 54).isActive = true
            titleLabel?.font = .heavyFont(size: .regular)
        }
    }
    
    private func colorFor(_ style: ButtonStyle) -> UIColor {
        switch style {
        case .pink: return .rxSwiftPink
        case .orange: return .rxSwiftOrange
        }
    }
}
