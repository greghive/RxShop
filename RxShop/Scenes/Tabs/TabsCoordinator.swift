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

// Bugs

// push from master to detail in products only works once you nav to basket

// TODOs

// setup server on heroku

// create UI for landing / auth form screen (use choosie / alpacr etc)

// mockup cells for browse + build it

// mock up cells for basket + build it

// profile (simple you are logged in as + logout button) - handle logout

// bonus, add setting location like in Choosie, some interesting work to do there

// ^ could link to this from profile

// icon (use SF Symbols with colors of RxSwift)
