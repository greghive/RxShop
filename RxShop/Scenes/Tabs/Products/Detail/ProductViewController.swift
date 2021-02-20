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
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    private var disposeBag: DisposeBag!
    var viewModelFactory: (ProductInput) -> ProductOutput = { _ in fatalError("Missing view model factory.") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar(title: "Item")
        containerView.style(.infoCard)
        titleLabel.style(.title)
        priceLabel.style(.title)
        priceLabel.textColor = .rxShopRed
        descriptionLabel.style(.body)
        descriptionLabel.numberOfLines = 0
        buyButton.style(.pink, size: .small)
        
        let input = ProductInput(buy: buyButton.observableTap())
        let viewModel = viewModelFactory(input)
        disposeBag = DisposeBag {
            viewModel.image.drive(imageView.rx.image)
            viewModel.title.drive(titleLabel.rx.text)
            viewModel.price.drive(priceLabel.rx.text)
            viewModel.description.drive(descriptionLabel.rx.text)
        }
    }
}
