//
//  TabsCoordinator.swift
//  RxShop
//
//  Created by Greg Price on 12/01/2021.
//

import UIKit

// -> may need to return sign out action from this coordinator?
// does browse / basket / profile each need coordinator? guess they do?

func tabsCoordinator(_ navigationController: UINavigationController) {
    
    let browseController = browseCoordinator()
    browseController.tabBarItem = UITabBarItem.chunky(title: "Browse", icon: "house.fill", tag: 0)
    
    let basketViewController = BasketViewController()
    basketViewController.tabBarItem = UITabBarItem.chunky(title: "Basket", icon: "cart.fill", tag: 0)
    
    let profileViewController = ProfileViewController()
    profileViewController.tabBarItem = UITabBarItem.chunky(title: "Profile", icon: "person.fill", tag: 0)
    
    let tabBarController = UITabBarController()
    tabBarController.viewControllers = [browseController, basketViewController, profileViewController]
    navigationController.pushViewController(tabBarController, animated: true)
}
