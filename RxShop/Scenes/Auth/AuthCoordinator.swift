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
   
    _ = landingAction.flow(showCreateAccount: showCreateAccount,
                           showCreatePassword: showCreatePassword(accountDetails:),
                           showSignIn: showSignIn)
        .subscribe(onNext: { result in
            switch result {
            case .success(let user):
                print("user: \(user)") // nav to main app / tabsCoordinator()
            case .failure(let error):
                print("error: \(error)") // display error to user
            }
        })
}

func showCreateAccount() -> Observable<CreateAccountAction> {
    let viewController = CreateAccountViewController.fromStoryboard()
    //navController.pushViewController(viewController, animated: true)
    return viewController.installOutputViewModel(outputFactory: createAccountViewModel())
}

func showCreatePassword(accountDetails: AccountDetails) -> Observable<SignUpAction> {
    let viewController = CreatePasswordViewController.fromStoryboard()
    //navController.pushViewController(viewController, animated: true)
    return viewController.installOutputViewModel(outputFactory: createPasswordViewModel(accountDetails: accountDetails))
}

func showSignIn() -> Observable<SignInAction> {
    let viewController = SignInViewController.fromStoryboard()
    //navController.pushViewController(viewController, animated: true)
    return viewController.installOutputViewModel(outputFactory: signInViewModel())
}

func showTabs(_ navController: UINavigationController) {
    //tabsCoordinator()
}
