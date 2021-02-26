//
//  TabsCoordinator.swift
//  RxShop
//
//  Created by Greg Price on 12/01/2021.
//

import UIKit
import RxSwift

func tabsCoordinator(_ navigationController: UINavigationController, user: User) {
    
    let tabBarController = UITabBarController()
    
    // MARK: Browse
    
    let productCoordinatorResult = productsCoordinator()
    let addProduct = productCoordinatorResult.action
    let productsNavigationController = productCoordinatorResult.navigationController
    productsNavigationController.tabBarItem = .chunky(title: "Browse", icon: "house.fill", tag: 0)
    
    // MARK: Basket
    
    let basketCoordinatorResult = basketCoordinator(addProduct: addProduct)
    let basketNavigationController = basketCoordinatorResult.navigationController
    basketNavigationController.tabBarItem = .chunky(title: "Basket", icon: "cart.fill", tag: 1)
    
    _ = basketCoordinatorResult.basketCount
        .map { $0 > 0 ? String($0) : nil }
        .take(until: tabBarController.rx.deallocating)
        .bind { basketNavigationController.tabBarItem.badgeValue = $0 }

    // MARK: Profile
    
    let profileCoordinatorResult = profileCoordinator(user: user)
    let profileNavigationController = profileCoordinatorResult.navigationController
    profileNavigationController.tabBarItem = .chunky(title: "Profile", icon: "person.fill", tag: 2)
    
    _ = profileCoordinatorResult.action
        .filter { $0 == .signOut }
        .take(until: tabBarController.rx.deallocating)
        .bind { _ in
            clearUser()
            navigationController.popToRootViewController(animated: true)
            navigationController.setNavigationBarHidden(false, animated: true)
        }
    
    // MARK: Tabs
    
    tabBarController.viewControllers = [productsNavigationController, basketNavigationController, profileNavigationController]
    navigationController.pushViewController(tabBarController, animated: true)
    _ = basketNavigationController.viewControllers[0].view
}
