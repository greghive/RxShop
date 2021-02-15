//
//  BasketCoordinator.swift
//  RxShop
//
//  Created by Greg Price on 15/02/2021.
//

import UIKit
import RxSwift

typealias BasketCoordinatorResult = (navigationController: UINavigationController, action: Observable<Product>)

func basketCoordinator(products: Observable<[Product]>) -> BasketCoordinatorResult {
    let basketViewController = BasketViewController()
    let basketAction = basketViewController.installOutputViewModel(outputFactory: basketViewModel(products: products)).share(replay: 1)
    let navigationController = UINavigationController(rootViewController: basketViewController)
    return (navigationController, basketAction)
}
