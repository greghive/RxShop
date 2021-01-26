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
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!

    private var disposeBag: DisposeBag!
    var viewModelFactory: (SignInInput) -> SignInOutput = { _ in fatalError("Missing view model factory.") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let email = emailTextField.observableText()
        let password = passwordTextField.observableText()
        let signIn = signInButton.observableTap()
        let viewModel = viewModelFactory(SignInInput(email: email, password: password, signIn: signIn))
        
        disposeBag = DisposeBag {
            viewModel.signInEnabled
                .drive(signInButton.rx.isEnabled)
        }
    }
}
