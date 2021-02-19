//
//  ProductViewController.swift
//  RxShop
//
//  Created by Greg Price on 01/02/2021.
//

import UIKit
import RxCocoa
import RxSwift

extension ProductViewController: Storyboarded {
    static var storyboard: Storyboard = .products
}

class ProductViewController: UIViewController, HasViewModel {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    private let disposeBag = DisposeBag()
    var viewModelFactory: (ProductInput) -> ProductOutput = { _ in fatalError("Missing view model factory.") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar(title: "Item")
        
        let input = ProductInput(buy: buyButton.observableTap())
        let viewModel = viewModelFactory(input)
        viewModel.title
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
