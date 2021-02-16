//
//  BasketProductCell.swift
//  RxShop
//
//  Created by Greg Price on 16/02/2021.
//

import UIKit

class BasketProductCell: UITableViewCell {

    // outlets
}

struct BasketProductCellConfigurator {
    
    static func cellFrom(_ tableView: UITableView, at indexPath: IndexPath, configuredWith basketProduct: BasketProduct) -> BasketProductCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasketProductCell.reuseIdentifier, for: indexPath) as? BasketProductCell else { fatalError() }
        return configure(cell, with: basketProduct)
    }
    
    private static func configure(_ cell: BasketProductCell, with basketProduct: BasketProduct) -> BasketProductCell {
        cell.textLabel?.text = "Item: \(basketProduct.product.title)"
        return cell
    }
}
