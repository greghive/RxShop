//
//  AuthCoordinator.swift
//  RxShop
//
//  Created by Greg Price on 18/01/2021.
//

import UIKit
import RxSwift

func landingCoordinator(_ window: UIWindow) {
    let landingViewController = LandingViewController.fromStoryboard()
    let landingAction = landingViewController.installOutputViewModel(outputFactory: landingViewModel()).share(replay: 1)
    let navigationController = UINavigationController(rootViewController: landingViewController)
    window.rootViewController = navigationController
       
    _ = landingAction
        .flow(navController: navigationController, showSignIn: showSignIn(navController:))
        .subscribe(onNext: { result in
            switch result {
            case .success(let user):
                print("*** user: \(user)")
                // cache the user here ????
            case .error(let error):
                print("*** error: \(error.localizedDescription)")
            }
        })
}

func showCreateAccount(navController: UINavigationController) -> Observable<CreateAccountAction> {
    let viewController = CreateAccountViewController.fromStoryboard()
    navController.pushViewController(viewController, animated: true)
    return viewController.installOutputViewModel(outputFactory: createAccountViewModel())
}

func showCreatePassword(navController: UINavigationController, accountDetails: AccountDetails) -> Observable<SignUpAction> {
    let viewController = CreatePasswordViewController.fromStoryboard()
    navController.pushViewController(viewController, animated: true)
    return viewController.installOutputViewModel(outputFactory: createPasswordViewModel(accountDetails: accountDetails))
}

func showSignIn(navController: UINavigationController) -> Observable<SignInAction> {
    let viewController = SignInViewController.fromStoryboard()
    navController.pushViewController(viewController, animated: true)
    return viewController.installOutputViewModel(outputFactory: signInViewModel())
}

func showTabs(_ navController: UINavigationController) {
    //tabsCoordinator()
}
