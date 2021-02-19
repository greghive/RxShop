//
//  ProductsCell.swift
//  RxShop
//
//  Created by Greg Price on 16/02/2021.
//

import UIKit

class ProductsCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var thumbView: UIView!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        containerView.layer.cornerRadius = 12
        containerView.backgroundColor = .secondarySystemBackground
        thumbView.layer.cornerRadius = 12
        thumbView.layer.masksToBounds = true
        thumbView.contentMode = .scaleAspectFit
        priceLabel.style(.tag)
        priceLabel.textColor = .white
        nameLabel.style(.title)
        descriptionLabel.style(.body)
    }
}

struct ProductsCellConfigurator {
    
    static func configure(_ cell: ProductsCell, with product: Product) {
        cell.thumbImageView.image = UIImage(named: "burger")
        cell.nameLabel.text = product.title
        cell.descriptionLabel.text = product.description
        cell.priceLabel.text = product.price.decimalCurrencyString
    }
}
