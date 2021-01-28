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
            case .error(let error):
                navigationController.showBasicError(message: error.localizedDescription)
            }
        })
}

// FIXME: install the view model BEFORE showing the controller!!!! this could be the issue with the share of the action in the coordinator above!!!!

//func showPostList(root: UIViewController, with channel: Channel) -> Observable<PostListAction> {
//    let vc = MessagePostListViewController()
//    let action = vc.installOutputViewModel(outputFactory: postListViewModel(channel: channel))
//    root.showDetailViewController(vc, sender: nil)
//    return action
//}

// Generic function for this????

func show(navController: UINavigationController) {
    
}

func showCreateAccount(navController: UINavigationController) -> Observable<CreateAccountAction> {
    let viewController = CreateAccountViewController.fromStoryboard()
    let action = viewController.installOutputViewModel(outputFactory: createAccountViewModel())
    navController.pushViewController(viewController, animated: true)
    return action
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
    //TODO: ready to show TABS!!
    //tabsCoordinator()
}
