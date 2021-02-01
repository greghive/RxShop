//
//  TabsCoordinator.swift
//  RxShop
//
//  Created by Greg Price on 12/01/2021.
//

import UIKit

// -> may need to return sign out action from this coordinator?
func tabsCoordinator(_ navigationController: UINavigationController) {
    
    let browseController = browseCoordinator()
    // TODO: assign view model
    browseController.tabBarItem = .chunky(title: "Browse", icon: "house.fill", tag: 0)
    
    let basketViewController = BasketViewController()
    // TODO: assign view model
    basketViewController.tabBarItem = .chunky(title: "Basket", icon: "cart.fill", tag: 1)
    
    let profileViewController = ProfileViewController()
    // TODO: assign view model
    profileViewController.tabBarItem = .chunky(title: "Profile", icon: "person.fill", tag: 2)
    
    let tabBarController = UITabBarController()
    tabBarController.viewControllers = [browseController, basketViewController, profileViewController]
    navigationController.pushViewController(tabBarController, animated: true)
}
