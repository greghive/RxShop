//
//  ProductsFlow.swift
//  RxShop
//
//  Created by Greg Price on 15/02/2021.
//

import RxSwift

func productsFlow(_ navigationController: UINavigationController, showProduct: @escaping (UINavigationController, Product) -> Observable<Product>, action: Observable<ProductsAction>) -> Observable<Product> {
    return action
        .compactMap { $0.success }
        .flatMap { showProduct(navigationController, $0) }
}
