//
//  CreatePasswordViewController.swift
//  RxShop
//
//  Created by Greg Price on 15/01/2021.
//

import UIKit
import RxSwift
import RxCocoa

class CreatePasswordViewController: XiblessViewController<CreatePasswordView>, HasViewModel {
    
    private var disposeBag: DisposeBag!
    var viewModelFactory: (CreatePasswordInput) -> CreatePasswordOutput = { _ in fatalError("Missing view model factory.") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar(title: "Set your password")
        disposeBag = DisposeBag {
            let viewModel = viewModelFactory(contentView.input)
            viewModel.signUpEnabled.drive(contentView.button.rx.isEnabled)
            viewModel.stateString.drive(contentView.statusLabel.rx.text)
            viewModel.signUpRunning.drive(contentView.activityView.rx.isAnimating)
            viewModel.signUpRunning.drive(contentView.statusLabel.rx.isHidden)
        }
    }
}
