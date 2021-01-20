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
    let navigationController = UINavigationController(rootViewController: landingViewController)
    window.rootViewController = navigationController
   
    _ = landingAction.subscribe(onNext: { action in
        switch action {
        case .wantsSignUp:
            _ = showCreateAccount(navigationController)
            // nothing gonna happen here
        case .wantsSignIn:
            _ = showSignIn(navigationController)
            // nothing gonna happen here
        case .authenticated(_):
            showTabs(navigationController)
        }
    })
    
    // need a flow that goes
    // 1. already authed so into app
    // 2. create account -> pass details into create password -> auth and into app OR display an error
    // 3. sign in -> auth and into app OR display an error
}

func showCreateAccount(_ navController: UINavigationController) -> Observable<CreateAccountAction> {
    let viewController = CreateAccountViewController.fromStoryboard()
    navController.pushViewController(viewController, animated: true)
    return viewController.installOutputViewModel(outputFactory: createAccountViewModel())
}

func showCreatePassword(_ navController: UINavigationController, accountDetails: AccountDetails) -> Observable<SignUpAction> {
    let viewController = CreatePasswordViewController.fromStoryboard()
    navController.pushViewController(viewController, animated: true)
    return viewController.installOutputViewModel(outputFactory: createPasswordViewModel(accountDetails: accountDetails))
}

func showSignIn(_ navController: UINavigationController) -> Observable<SignInAction> {
    let viewController = SignInViewController.fromStoryboard()
    navController.pushViewController(viewController, animated: true)
    return viewController.installOutputViewModel(outputFactory: signInViewModel())
}

func showTabs(_ navController: UINavigationController) {
    //tabsCoordinator()
}
