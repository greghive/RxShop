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

// profile (simple you are logged in as + logout button) - handle logout

// label underneath set password (your passwords do not match...i.e. why is button disabled...)

// some kind of toast ir alert for adding an item ???

// login (etc) disable button whilst network call is made

// dummy checkout screen (which clears the basket)

// slide checkout off more


// upload before then....

// bonus, add setting location like in Choosie, some interesting work to do there

// ^ could link to this from profile
