//
//  BasketProductCell.swift
//  RxShop
//
//  Created by Greg Price on 16/02/2021.
//

import UIKit

class BasketCell: UITableViewCell {

    // outlets
}

struct BasketCellConfigurator {
    
    static func cellFrom(_ tableView: UITableView, at indexPath: IndexPath, configuredWith basketProduct: BasketProduct) -> BasketCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasketCell.reuseIdentifier, for: indexPath) as? BasketCell else { fatalError() }
        return configure(cell, with: basketProduct)
    }
    
    static func configure(_ cell: BasketCell, with basketProduct: BasketProduct) -> BasketCell {
        cell.textLabel?.text = "Item: \(basketProduct.product.title)"
        return cell
    }
}
