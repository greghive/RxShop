//
//  SignInViewController.swift
//  RxShop
//
//  Created by Greg Price on 15/01/2021.
//

import UIKit

extension SignInViewController: Storyboarded {
    static var storyboard: Storyboard = .signin
}

class SignInViewController: UIViewController, HasViewModel {
    var viewModelFactory: (SignInInput) -> SignInOutput = { _ in fatalError("Missing view model factory.") }
}
