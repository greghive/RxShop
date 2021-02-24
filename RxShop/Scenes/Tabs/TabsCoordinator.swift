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
    let productsNavigationController = productCoordinatorResult.navigationController
    productsNavigationController.tabBarItem = .chunky(title: "Browse", icon: "house.fill", tag: 0)
  
    // this may not be needed
    // issue around tapping into a product...could be related
    // ProductsViewController is not getting deallocated
    // (check other vc's?)
    let addProduct = productCoordinatorResult.action
        .take(until: tabBarController.rx.deallocating)
    
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
            clearUser(from: .standard)
            navigationController.popToRootViewController(animated: true)
        }
    
    // MARK: Tabs
    
    tabBarController.viewControllers = [productsNavigationController, basketNavigationController, profileNavigationController]
    navigationController.pushViewController(tabBarController, animated: true)
}

// Bugs

// push from master to detail in products only works once you nav to basket

// see if this effects the Vc's too? check that they all deinit

// TODOs

// dummy checkout screen (which clears the basket)


// upload before then....

// bonus, add setting location like in Choosie, some interesting work to do there

// ^ could link to this from profile

// toast alet when adding items (with rx throttle so don't post tons as once???)
