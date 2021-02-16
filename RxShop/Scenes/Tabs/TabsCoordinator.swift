//
//  TabsCoordinator.swift
//  RxShop
//
//  Created by Greg Price on 12/01/2021.
//

import UIKit
import RxSwift

func tabsCoordinator(_ navigationController: UINavigationController) {
    
    // MARK: Browse
    
    let productCoordinatorResult = productsCoordinator()
    let productsNavigationController = productCoordinatorResult.navigationController
    productsNavigationController.tabBarItem = .chunky(title: "Browse", icon: "house.fill", tag: 0)
  
    // MARK: Basket
    
    let basketCoordinatorResult = basketCoordinator(addProduct: productCoordinatorResult.action)
    let basketNavigationController = basketCoordinatorResult.navigationController
    basketNavigationController.tabBarItem = .chunky(title: "Basket", icon: "cart.fill", tag: 1)
    
    _ = basketCoordinatorResult.basketCount
        .map { $0 > 0 ? String($0) : nil }
        .bind { basketNavigationController.tabBarItem.badgeValue = $0 }

    // MARK: Profile
    
    let profileViewController = ProfileViewController()
    profileViewController.tabBarItem = .chunky(title: "Profile", icon: "person.fill", tag: 2)
    
    // MARK: Tabs
    
    let tabBarController = UITabBarController()
    tabBarController.viewControllers = [productsNavigationController, basketNavigationController, profileViewController]
    navigationController.pushViewController(tabBarController, animated: true)
}
