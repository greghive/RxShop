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
    let landingAction = landingViewController.installOutputViewModel(outputFactory: landingViewModel()).share(replay: 1)
    let navigationController = UINavigationController(rootViewController: landingViewController)
    window.rootViewController = navigationController
       
    _ = landingAction
        .flow(navController: navigationController,
              showSignIn: showSignIn(navController:),
              showCreateAccount: showCreateAccount(navController:),
              showCreatePassword: showCreatePassword(navController:accountDetails:))
        
        .subscribe(onNext: { result in
            switch result {
            case .success(let user):
                cacheUser(user, to: .standard)
                showTabs(navigationController)
            case .error(let error):
                navigationController.showBasicError(message: error.localizedDescription)
            }
        })
}

func showCreateAccount(navController: UINavigationController) -> Observable<CreateAccountAction> {
    let viewController = CreateAccountViewController.fromStoryboard()
    let action = viewController.installOutputViewModel(outputFactory: createAccountViewModel())
    navController.pushViewController(viewController, animated: true)
    return action
}

func showCreatePassword(navController: UINavigationController, accountDetails: AccountDetails) -> Observable<SignUpAction> {
    let viewController = CreatePasswordViewController.fromStoryboard()
    let action = viewController.installOutputViewModel(outputFactory: createPasswordViewModel(accountDetails: accountDetails))
    navController.pushViewController(viewController, animated: true)
    return action
}

func showSignIn(navController: UINavigationController) -> Observable<SignInAction> {
    let viewController = SignInViewController()
    let action = viewController.installOutputViewModel(outputFactory: signInViewModel())
    navController.pushViewController(viewController, animated: true)
    return action
}

func showTabs(_ navController: UINavigationController) {
    navController.setNavigationBarHidden(true, animated: true)
    tabsCoordinator(navController)
}
