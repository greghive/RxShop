//
//  TabsCoordinator.swift
//  RxShop
//
//  Created by Greg Price on 12/01/2021.
//

import UIKit
import RxSwift

func tabsCoordinator(_ navigationController: UINavigationController, user: User) {
    
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
        //.take(until: basketNavigationController.rx.deallocating) // check these out 🤔 (test with sign out)
        .bind { basketNavigationController.tabBarItem.badgeValue = $0 }

    // MARK: Profile
    
    let profileCoordinatorResult = profileCoordinator(user: user)
    let profileNavigationController = profileCoordinatorResult.navigationController
    profileNavigationController.tabBarItem = .chunky(title: "Profile", icon: "person.fill", tag: 2)
    
    _ = profileCoordinatorResult.action
        .filter { $0 == .signOut }
        //.take(until: basketNavigationController.rx.deallocating) // check these out 🤔 (test with sign out)
        .bind { _ in
            clearUser(from: .standard)
            navigationController.popToRootViewController(animated: true)
        }
    
    // MARK: Tabs
    
    let tabBarController = UITabBarController()
    tabBarController.viewControllers = [productsNavigationController, basketNavigationController, profileNavigationController]
    navigationController.pushViewController(tabBarController, animated: true)
}

// Bugs

// push from master to detail in products only works once you nav to basket

// TODOs

// some kind of toast ir alert for adding an item ???

// dummy checkout screen (which clears the basket)

// slide checkout off more

// check binds in ALL coordinators, like above, when the tab bar gets popped on logot, do the subscriptions remain? may need takeUntil(vc.dellocating)


// upload before then....

// bonus, add setting location like in Choosie, some interesting work to do there

// ^ could link to this from profile
