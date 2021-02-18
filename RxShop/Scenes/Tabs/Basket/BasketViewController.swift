//
//  BasketViewController.swift
//  RxShop
//
//  Created by Greg Price on 01/02/2021.
//

import UIKit
import RxSwift
import RxDataSources

class BasketViewController: UITableViewController, HasViewModel {
  
    private let disposeBag = DisposeBag()
    var viewModelFactory: (BasketInput) -> BasketOutput = { _ in fatalError("Missing view model factory.") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.register(BasketCell.reuseIdentifier)

        let input = BasketInput(delete: tableView.rx.itemDeleted.asObservable())
        let viewModel = viewModelFactory(input)
        viewModel.basket
            .bind(to: tableView.rx.items(dataSource: BasketViewController.dataSource()))
            .disposed(by: disposeBag)
    }
}

extension BasketViewController {
        
    static func dataSource() -> RxTableViewSectionedAnimatedDataSource<BasketSection> {
        let animationConfiguration = AnimationConfiguration(insertAnimation: .left, reloadAnimation: .fade, deleteAnimation: .right)
        return RxTableViewSectionedAnimatedDataSource(animationConfiguration: animationConfiguration,
              
          configureCell: { _, tableView, indexPath, item in
            return BasketCellConfigurator.cellFrom(tableView, at: indexPath, configuredWith: item)
          },
              
          canEditRowAtIndexPath: { _, _ in
            return true
          })
    }
}
