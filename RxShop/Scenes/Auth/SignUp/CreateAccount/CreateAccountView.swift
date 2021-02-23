//
//  CreateAccountView.swift
//  RxShop
//
//  Created by Greg Price on 23/02/2021.
//

import UIKit

class CreateAccountView: AuthView {

    let firstName = UITextField.name(placeholder: "First name")
    let lastName = UITextField.name(placeholder: "Last name")
    let email = UITextField.email()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addInputs([firstName, lastName, email])
        button.setTitle("NEXT", for: .normal)
    }
}

extension CreateAccountView {
    var input: CreateAccountInput {
        CreateAccountInput(
            firstName: firstName.rxText(),
            lastName: lastName.rxText(),
            email: email.rxText(),
            next: button.rxTap())
    }
}
