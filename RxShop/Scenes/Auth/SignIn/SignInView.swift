//
//  SignInView.swift
//  RxShop
//
//  Created by Greg Price on 23/02/2021.
//

import UIKit

class SignInView: AuthView {

    let email = UITextField.email()
    let password = UITextField.password()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        addInputs([email, password])
        button.setTitle("SIGN IN", for: .normal)
    }
}

extension SignInView {
    var input: SignInInput {
        SignInInput(
            email: email.rxText(),
            password: password.rxText(),
            signIn: button.rxTap())
    }
}
