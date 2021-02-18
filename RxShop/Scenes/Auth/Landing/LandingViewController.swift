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
        signUpButton.style(.pink)
        signInButton.style(.orange)
        
        let input = LandingInput(viewWillAppear: rx.methodInvoked(#selector(viewWillAppear(_:))).asVoid(),
                                 signUpTap: signUpButton.observableTap(),
                                 signInTap: signInButton.observableTap())
       
        let viewModel = viewModelFactory(input)
        
        viewModel.buttonsHidden
            .drive(signUpButton.rx.isHidden, signInButton.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: true)
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: true)
//    }
}
