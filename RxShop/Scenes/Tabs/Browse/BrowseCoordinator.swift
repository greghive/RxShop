//
//  BrowseCoordinator.swift
//  RxShop
//
//  Created by Greg Price on 01/02/2021.
//

import RxSwift

func browseCoordinator() -> UINavigationController {
    let browseViewController = BrowseViewController()
    let browseAction = browseViewController.installOutputViewModel(outputFactory: browseViewModel())
    _ = browseAction.subscribe(onNext: { result in
        switch result {
        case .success(let product):
            showProductViewController(browseViewController.navigationController!, product: product)
        case .error(let error):
            browseViewController.showBasicError(message: error.localizedDescription)
        }
    })
    
    let navigationController = UINavigationController(rootViewController: browseViewController)
    return navigationController
}

func showProductViewController(_ navigationController: UINavigationController, product: Product) {
    let productViewController = ProductViewController(viewModel: product)
    navigationController.pushViewController(productViewController, animated: true)
}
