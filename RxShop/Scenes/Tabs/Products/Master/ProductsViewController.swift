//
//  BrowseViewController.swift
//  RxShop
//
//  Created by Greg Price on 01/02/2021.
//

import UIKit
import RxSwift
import RxCocoa

class ProductsViewController: UITableViewController, HasViewModel {
    
    private let disposeBag = DisposeBag()
    var viewModelFactory: (ProductsInput) -> ProductsOutput = { _ in fatalError("Missing view model factory.") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Browse"
        tableView.dataSource = nil
        tableView.delegate = nil
        tableView.refreshControl = UIRefreshControl()
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
        tableView.register(ProductsCell.reuseIdentifier)
        let refreshControl = tableView.refreshControl!
        
        let input = ProductsInput(viewWillAppear: rx.sentMessage(#selector(UIViewController.viewWillAppear(_:))).asVoid(),
                                refresh: tableView.refreshControl!.rx.controlEvent(.valueChanged).asObservable(),
                                select: tableView.rx.itemSelected.asObservable())
        
        let viewModel = viewModelFactory(input)
        
        viewModel.refreshEnded
            .bind { refreshControl.endRefreshing() }
            .disposed(by: disposeBag)
        
        viewModel
            .products
            .bind(to: tableView.rx.items(cellIdentifier: ProductsCell.reuseIdentifier, cellType: ProductsCell.self)) { _, product, cell in
                ProductsCellConfigurator.configure(cell, with: product)
            }.disposed(by: disposeBag)
    }
}
