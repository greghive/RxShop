//
//  UITextField+AppStyles.swift
//  RxShop
//
//  Created by Greg Price on 18/02/2021.
//

import UIKit

enum TextFieldStyle {
    case name
    case email
    case password
}

extension UITextField {
    
    func style(_ inputStyle: TextFieldStyle, icon: String, placeholder: String) {
        switch inputStyle {
        case .name:
            autocapitalizationType = .words
        case .email:
            keyboardType = .emailAddress
        case .password:
            isSecureTextEntry = true
        }
        
        let image = UIImage(systemName: icon)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .rxShopRed
        leftView = imageView
        leftViewMode = UITextField.ViewMode.always
        
        borderStyle = .none
        backgroundColor = .textFieldBackground
        layer.borderColor = UIColor.textFieldBorder.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 12

        font = .boldFont(size: .regular)
        self.placeholder = placeholder
        textColor = .darkText
        tintColor = .rxShopRed
        
        heightAnchor.constraint(equalToConstant: 54).isActive = true
    }
}
