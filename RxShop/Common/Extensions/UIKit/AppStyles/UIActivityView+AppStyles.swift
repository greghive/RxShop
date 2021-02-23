//
//  UIActivityView+AppStyles.swift
//  RxShop
//
//  Created by Greg Price on 23/02/2021.
//

import UIKit

extension UIActivityIndicatorView {
    
    static func style(_ style: UIActivityIndicatorView.Style) -> UIActivityIndicatorView {
        let activityView = UIActivityIndicatorView(style: style)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.color = .rxShopRed
        activityView.hidesWhenStopped = true
        activityView.stopAnimating()
        return activityView
    }
}
