//
//  LandingViewController.swift
//  RxShop
//
//  Created by Greg Price on 15/01/2021.
//

import UIKit
import RxSwift
import RxCocoa

extension LandingViewController: Storyboarded {
    static var storyboard: Storyboard = .landing
}

class LandingViewController: UIViewController, HasViewModel {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    private let disposeBag = DisposeBag()
    var viewModelFactory: (LandingInput) -> LandingOutput = { _ in fatalError("Missing view model factory.") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewWillAppear = rx.methodInvoked(#selector(viewWillAppear(_:))).asVoid()
        let signUpTap = signUpButton.observableTap()
        let signInTap = signInButton.observableTap()
        let input = LandingInput(viewWillAppear: viewWillAppear, signUpTap: signUpTap, signInTap: signInTap)
        let viewModel = viewModelFactory(input)
        
        viewModel.buttonsHidden
            .drive(signUpButton.rx.isHidden, signInButton.rx.isHidden)
            .disposed(by: disposeBag)
    }
}
