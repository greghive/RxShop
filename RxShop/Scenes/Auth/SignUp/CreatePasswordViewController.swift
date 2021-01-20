//
//  CreatePasswordViewController.swift
//  RxShop
//
//  Created by Greg Price on 15/01/2021.
//

import UIKit

extension CreatePasswordViewController: Storyboarded {
    static var storyboard: Storyboard = .signup
}

class CreatePasswordViewController: UIViewController, HasViewModel {
    var viewModelFactory: (CreatePasswordInput) -> CreatePasswordOutput = { _ in fatalError("Missing view model factory.") }
}
