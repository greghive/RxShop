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
    
    @IBOutlet weak var passwordTextField: PaddedTextField!
    @IBOutlet weak var confirmTextField: PaddedTextField!
    @IBOutlet weak var signUpButton: UIButton!
    var inputs: [UITextField]!
    
    private let disposeBag = DisposeBag()
    var viewModelFactory: (CreatePasswordInput) -> CreatePasswordOutput = { _ in fatalError("Missing view model factory.") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar(title: "Set your password")
        passwordTextField.style(.name, icon: "lock", placeholder: "Password")
        confirmTextField.style(.name, icon: "lock.fill", placeholder: "Confirm password")
        inputs = [passwordTextField, confirmTextField]
        configureInputs(delegate: self)
        signUpButton.style(.red)
        
        let input = CreatePasswordInput(password: passwordTextField.observableText(),
                                        confirmation: confirmTextField.observableText(),
                                        signUp: signUpButton.observableTap())
        
        let viewModel = viewModelFactory(input)
    
        viewModel.signUpEnabled
            .drive(signUpButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}

extension CreatePasswordViewController: TextFieldResponding, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return handleTextFieldShouldReturn(textField)
    }
}
