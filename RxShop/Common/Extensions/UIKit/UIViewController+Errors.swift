//
//  UIViewController+Errors.swift
//  RxShop
//
//  Created by Greg Price on 28/01/2021.
//

import UIKit

extension UIViewController {
    
    func showBasicAlert(title: String? = nil, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
