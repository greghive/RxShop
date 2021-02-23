//
//  ProductsView.swift
//  RxShop
//
//  Created by Greg Price on 23/02/2021.
//

import UIKit

class ProductsView: XiblessView {
    
    let tableView = UITableView.standard
    let activityView = UIActivityIndicatorView.style(.large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        layoutUI()
    }
    
    private func layoutUI() {
        addSubview(tableView)
        addSubview(activityView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            activityView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
