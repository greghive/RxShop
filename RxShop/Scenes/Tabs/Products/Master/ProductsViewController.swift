//
//  BrowseViewController.swift
//  RxShop
//
//  Created by Greg Price on 01/02/2021.
//

import UIKit
import RxSwift
import RxCocoa

class ProductsViewController: XiblessViewController<ProductsView>, HasViewModel {
    
    private let disposeBag = DisposeBag()
    var viewModelFactory: (ProductsInput) -> ProductsOutput = { _ in fatalError("Missing view model factory.") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Browse"
        
        contentView.tableView.register(ProductsCell.reuseIdentifier)
        let refreshControl = contentView.tableView.refreshControl!
        
        let input = ProductsInput(
            viewWillAppear: rxViewWillAppear(),
            refresh: contentView.tableView.refreshControl!.rx.controlEvent(.valueChanged).asObservable(),
            select: contentView.tableView.rx.itemSelected.asObservable())
        
        let viewModel = viewModelFactory(input)
        
        viewModel.refreshEnded
            .bind { refreshControl.endRefreshing() }
            .disposed(by: disposeBag)
        
        viewModel.runningFirstFetch
            .drive(contentView.activityView.rx.isAnimating)
            .disposed(by: disposeBag)

        viewModel.products
            .bind(to: contentView.tableView.rx.items(cellIdentifier: ProductsCell.reuseIdentifier, cellType: ProductsCell.self)) { _, product, cell in
                ProductsCellConfigurator.configure(cell, with: product)
            }.disposed(by: disposeBag)
    }
}
