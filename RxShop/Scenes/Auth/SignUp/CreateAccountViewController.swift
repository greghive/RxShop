//
//  SignUpViewController.swift
//  RxShop
//
//  Created by Greg Price on 15/01/2021.
//

import UIKit
import RxSwift
import RxCocoa

extension CreateAccountViewController: Storyboarded {
    static var storyboard: Storyboard = .signup
}

class CreateAccountViewController: UIViewController, HasViewModel {
    
    @IBOutlet weak var firstNameTextField: PaddedTextField!
    @IBOutlet weak var lastNameTextField: PaddedTextField!
    @IBOutlet weak var emailTextField: PaddedTextField!
    @IBOutlet weak var nextButton: UIButton!
    var inputs: [UITextField]!

    private let disposeBag = DisposeBag()
    var viewModelFactory: (CreateAccountInput) -> CreateAccountOutput = { _ in fatalError("Missing view model factory.") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar(title: "Create your account")
        firstNameTextField.style(.name, icon: "signature", placeholder: "First name")
        lastNameTextField.style(.name, icon: "signature", placeholder: "Last name")
        emailTextField.style(.email, icon: "envelope", placeholder: "Email")
        inputs = [firstNameTextField, lastNameTextField, emailTextField]
        configureInputs(delegate: self)
        nextButton.style(.red)
        
        let input = CreateAccountInput(firstName: firstNameTextField.observableText(),
                                       lastName: lastNameTextField.observableText(),
                                       email: emailTextField.observableText(),
                                       next: nextButton.observableTap())
        
        let viewModel = viewModelFactory(input)
        
        viewModel.nextEnabled
            .drive(nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}

extension CreateAccountViewController: TextFieldResponding, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return handleTextFieldShouldReturn(textField)
    }
}
