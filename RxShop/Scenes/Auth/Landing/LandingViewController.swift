//
//  LandingViewController.swift
//  RxShop
//
//  Created by Greg Price on 15/01/2021.
//

import UIKit
import RxSwift
import RxCocoa

//extension LandingViewController: Storyboarded {
//    static var storyboard: Storyboard = .landing
//}

class LandingViewController: XiblessViewController<LandingView>, HasViewModel {
    
    //@IBOutlet weak var signUpButton: UIButton!
    //@IBOutlet weak var signInButton: UIButton!
    
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
                contentView.signIn.rx.isHidden)
        }
        
        
//        signUpButton.style(.red)
//        signInButton.style(.green)
//        
//        let input = LandingInput(viewWillAppear: rx.methodInvoked(#selector(viewWillAppear(_:))).asVoid(),
//                                 signUpTap: signUpButton.rxTap(),
//                                 signInTap: signInButton.rxTap())
//       
//        let viewModel = viewModelFactory(input)
//        
//        viewModel.buttonsHidden
//            .drive(signUpButton.rx.isHidden, signInButton.rx.isHidden)
//            .disposed(by: disposeBag)
    }
}
