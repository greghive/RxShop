//
//  BrowseCoordinator.swift
//  RxShop
//
//  Created by Greg Price on 01/02/2021.
//

import RxSwift

func productsCoordinator() -> (navigationController: UINavigationController, action: Observable<Product>) {
    let productsViewController = ProductsViewController()
    let productsAction = productsViewController.installOutputViewModel(outputFactory: productsViewModel()).share()
    let navigationController = UINavigationController()
    
    _ = productsAction
        .compactMap { $0.error }
        .withUnretained(productsViewController)
        .bind(onNext: { vc, error in
            vc.showBasicAlert(message: error.localizedDescription)
        })
    
    let buyAction = productsAction
        .compactMap { $0.success }
        .flatMapLatest { showProductViewController(navigationController, product: $0) }
    
    navigationController.setViewControllers([productsViewController], animated: false)
    return (navigationController, buyAction)
}

func showProductViewController(_ navigationController: UINavigationController, product: Product) -> Observable<Product> {
    let productViewController = ProductViewController.fromStoryboard()
    let action = productViewController.installOutputViewModel(outputFactory: productViewModel(product: product))
    navigationController.pushViewController(productViewController, animated: true)
    return action
}



