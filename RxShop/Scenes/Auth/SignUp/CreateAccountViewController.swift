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

    private let disposeBag = DisposeBag()
    var viewModelFactory: (CreateAccountInput) -> CreateAccountOutput = { _ in fatalError("Missing view model factory.") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
