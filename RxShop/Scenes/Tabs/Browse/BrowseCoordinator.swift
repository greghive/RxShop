//
//  BrowseCoordinator.swift
//  RxShop
//
//  Created by Greg Price on 01/02/2021.
//

import RxSwift

func browseCoordinator() -> UINavigationController {
    let browseViewController = BrowseViewController()
    let navigationController = UINavigationController(rootViewController: browseViewController)
    return navigationController
}
