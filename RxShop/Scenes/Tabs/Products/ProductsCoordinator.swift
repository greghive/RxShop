//
//  BrowseCoordinator.swift
//  RxShop
//
//  Created by Greg Price on 01/02/2021.
//

import RxSwift

func productsCoordinator() -> (navigationController: UINavigationController, action: Observable<Product>) {
    let productsViewController = ProductsViewController()
    let productsAction = productsViewController.installOutputViewModel(outputFactory: productsViewModel()).share(replay: 1)
    let navigationController = UINavigationController()
    
//    _ = productsAction.subscribe(onNext: { result in
//        if let error = result.error {
//            navigationController.showBasicError(message: error.localizedDescription)
//        }
//    })
    
    //let buyAction = productsFlow(navigationController, showProduct: showProductViewController(_:product:), action: productsAction)
    
    // don't need the flow
    
    _ = productsAction
        .compactMap { $0.error }
        .subscribe(onNext: { navigationController.showBasicError(message: $0.localizedDescription) })
    
    let buyAction = productsAction
        .compactMap { $0.success }
        .flatMap { showProductViewController(navigationController, product: $0) }
    
    navigationController.setViewControllers([productsViewController], animated: false)
    return (navigationController, buyAction)
}

func showProductViewController(_ navigationController: UINavigationController, product: Product) -> Observable<Product> {
    let productViewController = ProductViewController.fromStoryboard()
    let action = productViewController.installOutputViewModel(outputFactory: productViewModel(product: product))
    navigationController.pushViewController(productViewController, animated: true)
    return action
}
