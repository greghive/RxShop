//
//  UIViewController+NavBar.swift
//  RxShop
//
//  Created by Greg Price on 18/02/2021.
//

import UIKit

extension UIViewController {
    
    func configureNavBar(title: String? = nil) {
        self.title = title
        let backImage = UIImage(systemName: "chevron.left")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .done, target: self, action: #selector(pop))
    }
    
    @objc func pop() {
        navigationController?.popViewController(animated: true)
    }
}
