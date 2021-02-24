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
    
    static func name(placeholder: String) -> UITextField {
        let textField = PaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.style(.name, icon: "signature", placeholder: placeholder)
        return textField
    }
    
    static func email(placeholder: String = "Email") -> UITextField {
        let textField = PaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.style(.email, icon: "signature", placeholder: "Email")
        return textField
    }
    
    static func password(placeholder: String = "Password") -> UITextField {
        let textField = PaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.style(.password, icon: "signature", placeholder: placeholder)
        return textField
    }
    
    func style(_ inputStyle: TextFieldStyle, icon: String, placeholder: String) {
        switch inputStyle {
        case .name:
            autocapitalizationType = .words
        case .email:
            autocapitalizationType = .none
            keyboardType = .emailAddress
        case .password:
            autocapitalizationType = .none
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
        textColor = .label
        tintColor = .rxShopRed
        
        heightAnchor.constraint(equalToConstant: 54).isActive = true
    }
}
