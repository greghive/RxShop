//
//  UITableView+Cells.swift
//  RxShop
//
//  Created by Greg Price on 18/02/2021.
//

import UIKit

extension UITableView {
    
    func register(_ identifier: String) {
        register(identifiers: [identifier])
    }
    
    func register(identifiers : [String]) {
        for identifier in identifiers {
            self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        }
    }
}
