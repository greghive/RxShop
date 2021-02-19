//
//  BasketCoordinator.swift
//  RxShop
//
//  Created by Greg Price on 15/02/2021.
//

import UIKit
import RxSwift

typealias BasketCoordinatorResult = (navigationController: UINavigationController, basketCount: Observable<BasketCount>)

func basketCoordinator(addProduct: Observable<Product>) -> BasketCoordinatorResult {
    let basketViewController = BasketViewController.fromStoryboard()
    let basketAction = basketViewController.installOutputViewModel(outputFactory: basketViewModel(addProduct: addProduct)).share(replay: 1)
    let navigationController = UINavigationController(rootViewController: basketViewController)
    return (navigationController, basketAction)
}
