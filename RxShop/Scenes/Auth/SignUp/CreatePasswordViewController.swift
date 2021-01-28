//
//  CreatePasswordViewController.swift
//  RxShop
//
//  Created by Greg Price on 15/01/2021.
//

import UIKit
import RxSwift
import RxCocoa

extension CreatePasswordViewController: Storyboarded {
    static var storyboard: Storyboard = .signup
}

class CreatePasswordViewController: UIViewController, HasViewModel {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    private let disposeBag = DisposeBag()
    var viewModelFactory: (CreatePasswordInput) -> CreatePasswordOutput = { _ in fatalError("Missing view model factory.") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let password = passwordTextField.observableText()
        let confirm = confirmTextField.observableText()
        let signUp = signUpButton.observableTap()
        let viewModel = viewModelFactory(CreatePasswordInput(password: password, confirmation: confirm, signUp: signUp))
    
        viewModel.signUpEnabled
            .drive(signUpButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}
