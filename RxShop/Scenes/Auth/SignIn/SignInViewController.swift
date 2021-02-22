//
//  SignInViewController.swift
//  RxShop
//
//  Created by Greg Price on 15/01/2021.
//

import UIKit
import RxSwift
import RxCocoa

extension SignInViewController: Storyboarded {
    static var storyboard: Storyboard = .signin
}

class SignInViewController: UIViewController, HasViewModel {
    
    @IBOutlet weak var emailTextField: PaddedTextField!
    @IBOutlet weak var passwordTextField: PaddedTextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    var inputs: [UITextField]!

    private var disposeBag: DisposeBag!
    var viewModelFactory: (SignInInput) -> SignInOutput = { _ in fatalError("Missing view model factory.") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar(title: "Let's Shop!")
        emailTextField.style(.email, icon: "envelope", placeholder: "Email")
        passwordTextField.style(.password, icon: "lock.fill", placeholder: "Password")
        inputs = [emailTextField, passwordTextField]
        configureInputs(delegate: self)
        signInButton.style(.pink)
        statusLabel.style(.body)
        statusLabel.textColor = .rxShopRed
        
        let email = emailTextField.observableText()
        let password = passwordTextField.observableText()
        let signIn = signInButton.observableTap()
        let viewModel = viewModelFactory(SignInInput(email: email, password: password, signIn: signIn))
        
        disposeBag = DisposeBag {
            viewModel.signInEnabled.drive(signInButton.rx.isEnabled)
            viewModel.status.drive(statusLabel.rx.text)
        }
    }
}

extension SignInViewController: TextFieldResponding, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return handleTextFieldShouldReturn(textField)
    }
}
