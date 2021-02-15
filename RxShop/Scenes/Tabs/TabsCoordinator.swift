//
//  TabsCoordinator.swift
//  RxShop
//
//  Created by Greg Price on 12/01/2021.
//

import UIKit

// -> may need to return sign out action from this coordinator?
func tabsCoordinator(_ navigationController: UINavigationController) {
    
    let products = productsCoordinator()
    let productsNavigationController = products.navigationController
    productsNavigationController.tabBarItem = .chunky(title: "Browse", icon: "house.fill", tag: 0)
     
    
    // use an enum for state of ProductAction / BasketAction .added and .deleted
    // products cootdinator would send added, and basket cooridnator would send deleted
    // could then sink this up here, with a merge, to get
    // 1. the correct basket of item and 2. the correct total numver of items
    let boughtProducts = products.action
        .map { [$0] }
        .scan([]) { current, latest in
            return current + latest
        }
        .share()
    
    
    //let basket = basketCoordinator() -> this would take an observable
    let basketViewController = BasketViewController()
    basketViewController.tabBarItem = .chunky(title: "Basket", icon: "cart.fill", tag: 1)
    
    let profileViewController = ProfileViewController()
    profileViewController.tabBarItem = .chunky(title: "Profile", icon: "person.fill", tag: 2)
    
    let tabBarController = UITabBarController()
    tabBarController.viewControllers = [productsNavigationController, basketViewController, profileViewController]
    navigationController.pushViewController(tabBarController, animated: true)
    
    _ = boughtProducts.subscribe(onNext: {
        print($0)
    })
    
    _  = boughtProducts
        .map { "\($0.count)" } // could do the price here???
        .subscribe(onNext: { count in
            basketViewController.tabBarItem.badgeValue = count
        })
}
