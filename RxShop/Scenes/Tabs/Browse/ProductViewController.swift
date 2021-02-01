//
//  ProductViewController.swift
//  RxShop
//
//  Created by Greg Price on 01/02/2021.
//

import UIKit

class ProductViewController: UIViewController {
    
    private var viewModel: ProductViewModel
    
    init(viewModel: ProductViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
