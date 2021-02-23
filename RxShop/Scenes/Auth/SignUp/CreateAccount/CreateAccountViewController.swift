//
//  SignUpViewController.swift
//  RxShop
//
//  Created by Greg Price on 15/01/2021.
//

import UIKit
import RxSwift
import RxCocoa

class CreateAccountViewController: XiblessViewController<CreateAccountView>, HasViewModel {
    
    private var disposeBag: DisposeBag!
    var viewModelFactory: (CreateAccountInput) -> CreateAccountOutput = { _ in fatalError("Missing view model factory.") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar(title: "Create your account")
        disposeBag = DisposeBag {
            let viewModel = viewModelFactory(contentView.input)
            viewModel.nextEnabled.drive(contentView.button.rx.isEnabled)
            viewModel.stateString.drive(contentView.statusLabel.rx.text)
        }
    }
}

