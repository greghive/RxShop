//
//  SignInView.swift
//  RxShop
//
//  Created by Greg Price on 23/02/2021.
//

import UIKit

class SignInView: AuthView {

    private(set) var email: UITextField = {
        return .email()
    }()
    
    private(set) var password: UITextField = {
        return .password()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        addInputs([email, password])
        button.setTitle("SIGN IN", for: .normal)
    }
}
