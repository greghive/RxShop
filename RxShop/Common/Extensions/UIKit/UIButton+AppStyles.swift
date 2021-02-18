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

extension UIButton {
    
    func style(_ style: ButtonStyle) {
        let normalColor = colorFor(style)
        let darkerColor = normalColor.darker()
        let disabledColor = normalColor.withAlphaComponent(0.5)
        
        heightAnchor.constraint(equalToConstant: 54).isActive = true
        setBackgroundImage(UIImage(color: normalColor), for: .normal)
        setBackgroundImage(UIImage(color: normalColor), for: .highlighted)
        setBackgroundImage(UIImage(color: normalColor), for: .selected)
        setBackgroundImage(UIImage(color: disabledColor), for: .disabled)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .heavyFont(size: .regular)
        layer.borderColor = darkerColor.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }
    
    private func colorFor(_ style: ButtonStyle) -> UIColor {
        switch style {
        case .pink: return .rxSwiftPink
        case .orange: return .rxSwiftOrange
        }
    }
}
