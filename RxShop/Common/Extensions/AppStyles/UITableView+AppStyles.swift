//
//  UITableView+AppStyles.swift
//  RxShop
//
//  Created by Greg Price on 23/02/2021.
//

import UIKit

extension UITableView {
    
    static var standard: UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = nil
        tableView.delegate = nil
        tableView.refreshControl = UIRefreshControl()
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
        return tableView
    }
}
