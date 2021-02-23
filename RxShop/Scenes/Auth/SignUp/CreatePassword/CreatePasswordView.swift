//
//  CreatePasswordView.swift
//  RxShop
//
//  Created by Greg Price on 23/02/2021.
//

import UIKit

class CreatePasswordView: AuthView {
    
    let password = UITextField.password()
    let confirm = UITextField.password(placeholder: "Confirm password")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addInputs([password, confirm])
        button.setTitle("SIGN UP", for: .normal)
    }
}

extension CreatePasswordView {
    var input: CreatePasswordInput {
        CreatePasswordInput(
            password: password.rxText(),
            confirmation: confirm.rxText(),
            signUp: button.rxTap())
    }
}
