//
//  SignInViewController.swift
//  RxShop
//
//  Created by Greg Price on 15/01/2021.
//

import UIKit
import RxSwift
import RxCocoa

class SignInViewController: XiblessViewController<SignInView>, HasViewModel {
    
    var viewModelFactory: (SignInInput) -> SignInOutput = { _ in fatalError("Missing view model factory.") }
    private var disposeBag: DisposeBag!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar(title: "Let's Shop!")

        let input = SignInInput(email: contentView.email.observableText(),
                                password: contentView.password.observableText(),
                                signIn: contentView.button.observableTap())
        
        disposeBag = DisposeBag {
            let viewModel = viewModelFactory(input)
            viewModel.signInEnabled.drive(contentView.button.rx.isEnabled)
            viewModel.stateString.drive(contentView.statusLabel.rx.text)
        }
    }
}
