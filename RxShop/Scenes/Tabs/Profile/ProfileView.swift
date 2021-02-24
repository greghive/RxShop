//
//  ProfileView.swift
//  RxShop
//
//  Created by Greg Price on 23/02/2021.
//

import UIKit

class ProfileView: XiblessView {
    
    let userLabel = UILabel.body
    
    private(set) var signOut: UIButton = {
        let button = UIButton.bigRed
        button.setTitle("SIGN OUT", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        layoutUI()
    }
    
    private func layoutUI() {
        addSubview(userLabel)
        addSubview(signOut)
        NSLayoutConstraint.activate([
            userLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            userLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            signOut.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 72),
            signOut.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -72),
            signOut.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -42)
        ])
    }
}
