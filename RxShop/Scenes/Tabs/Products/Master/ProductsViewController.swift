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
        tableView.dataSource = nil
        tableView.delegate = nil
        tableView.refreshControl = UIRefreshControl()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { _, product, cell in
                cell.textLabel!.text = product.title
            }.disposed(by: disposeBag)
    }
}
