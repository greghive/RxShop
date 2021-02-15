//
//  BasketViewController.swift
//  RxShop
//
//  Created by Greg Price on 01/02/2021.
//

import UIKit
import RxSwift

class BasketViewController: UITableViewController, HasViewModel {
  
    private let disposeBag = DisposeBag()
    var viewModelFactory: (BasketInput) -> BasketOutput = { _ in fatalError("Missing view model factory.") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let input = BasketInput(delete: tableView.rx.itemDeleted.asObservable())
        let viewModel = viewModelFactory(input)
        viewModel.products
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { _, product, cell in
                cell.textLabel!.text = product.title
            }.disposed(by: disposeBag)
    }
}
