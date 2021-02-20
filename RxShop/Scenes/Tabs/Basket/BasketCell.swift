//
//  BasketProductCell.swift
//  RxShop
//
//  Created by Greg Price on 16/02/2021.
//

import UIKit

class BasketCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        thumbImageView.contentMode = .scaleAspectFit
        priceLabel.style(.tag)
        priceLabel.textColor = .rxShopRed
        nameLabel.style(.title)
    }
}

struct BasketCellConfigurator {
    
    static func cellFrom(_ tableView: UITableView, at indexPath: IndexPath, configuredWith basketProduct: BasketProduct) -> BasketCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasketCell.reuseIdentifier, for: indexPath) as? BasketCell else { fatalError() }
        return configure(cell, with: basketProduct)
    }
    
    static func configure(_ cell: BasketCell, with basketProduct: BasketProduct) -> BasketCell {
        cell.thumbImageView.image = basketProduct.product.productImage
        cell.nameLabel.text = basketProduct.product.title
        cell.priceLabel.text = basketProduct.product.price.decimalCurrencyString
        return cell
    }
}
