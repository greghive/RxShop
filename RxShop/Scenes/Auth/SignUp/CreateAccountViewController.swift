//
//  SignUpViewController.swift
//  RxShop
//
//  Created by Greg Price on 15/01/2021.
//

import UIKit

extension CreateAccountViewController: Storyboarded {
    static var storyboard: Storyboard = .signup
}

class CreateAccountViewController: UIViewController, HasViewModel {
    var viewModelFactory: (CreateAccountInput) -> CreateAccountOutput = { _ in fatalError("Missing view model factory.") }
}
