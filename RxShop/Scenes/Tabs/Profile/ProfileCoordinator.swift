//
//  ProfileCoordinator.swift
//  RxShop
//
//  Created by Greg Price on 24/02/2021.
//

import RxSwift

typealias ProfileCoordinatorResult = (navigationController: UINavigationController, action: Observable<ProfileAction>)

func profileCoordinator(user: User) -> ProfileCoordinatorResult {
    let profileViewController = ProfileViewController()
    let profileAction = profileViewController.installOutputViewModel(outputFactory: profileViewModel(user: user)).share(replay: 1)
    let navigationController = UINavigationController(rootViewController: profileViewController)
    return (navigationController, profileAction)
}
