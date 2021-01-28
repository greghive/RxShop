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
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!

    private var disposeBag: DisposeBag!
    var viewModelFactory: (CreateAccountInput) -> CreateAccountOutput = { _ in fatalError("Missing view model factory.") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstName = firstNameTextField.observableText()
        let lastName = lastNameTextField.observableText()
        let email = emailTextField.observableText()
        let next = nextButton.observableTap()
        let viewModel = viewModelFactory(CreateAccountInput(firstName: firstName, lastName: lastName, email: email, next: next))
        
        disposeBag = DisposeBag {
            viewModel.nextEnabled
                .drive(nextButton.rx.isEnabled)
        }
    }
}
