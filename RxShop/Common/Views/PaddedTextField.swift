//
//  PaddedTextField.swift
//  RxShop
//
//  Created by Greg Price on 18/02/2021.
//

import UIKit

final class PaddedTextField: UITextField {
    
    let imagePaddingLeft: CGFloat = 10
    let imagePaddingRight: CGFloat = 0
    let textPaddingLeft: CGFloat = 44
    let textPaddingRight: CGFloat = 0
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += imagePaddingLeft
        return rect
    }

    private var textInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: textPaddingLeft, bottom: 0, right: textPaddingRight)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
}
