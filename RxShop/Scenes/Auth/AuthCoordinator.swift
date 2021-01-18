//
//  AuthCoordinator.swift
//  RxShop
//
//  Created by Greg Price on 18/01/2021.
//

import UIKit
import RxSwift

func authCoordinator(_ window: UIWindow) {
    let landingViewController = LandingViewController.fromStoryboard()
    let landingAction = landingViewController.installOutputViewModel(outputFactory: landingViewModel())
    _ = landingAction.subscribe(onNext: { action in
        switch action {
        case .wantsSignUp:
            showCreateAccount()
        case .wantsSignIn:
            showSignIn()
        case .authenticated(_):
            showShop()
        }
    })
    let navigationController = UINavigationController(rootViewController: landingViewController)
    window.rootViewController = navigationController
}

func showCreateAccount() {
    let createAccountViewController = CreateAccountViewController.fromStoryboard()
    // need a reference to a view controller / navigation controlleer, to push this next vc
    // would then return from here the result of installOutputViewModel
}

func showCreatePassword() {
    
}

func showSignIn() {
    
}

func showShop() {
    
}
