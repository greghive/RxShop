//
//  LandingViewController.swift
//  RxShop
//
//  Created by Greg Price on 15/01/2021.
//

import UIKit
import RxSwift
import RxCocoa

class LandingViewController: XiblessViewController<LandingView>, HasViewModel {
    
    private var disposeBag: DisposeBag!
    var viewModelFactory: (LandingInput) -> LandingOutput = { _ in fatalError("Missing view model factory.") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let input = LandingInput(
            viewWillAppear: rxViewWillAppear(),
            signUpTap: contentView.signUp.rxTap(),
            signInTap: contentView.signIn.rxTap())
        
        let viewModel = viewModelFactory(input)
        disposeBag = DisposeBag {
            viewModel.buttonsHidden.drive(
                contentView.signUp.rx.isHidden,
                contentView.signIn.rx.isHidden
            )
        }
    }
}
