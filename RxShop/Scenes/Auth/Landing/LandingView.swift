//
//  LandingView.swift
//  RxShop
//
//  Created by Greg Price on 23/02/2021.
//

import UIKit

class LandingView: XiblessView {
    
    private(set) var signUp: UIButton = {
        let button = UIButton.bigRed
        button.setTitle("SIGN UP", for: .normal)
        return button
    }()
    
    private(set) var signIn: UIButton = {
        let button = UIButton.bigGreen
        button.setTitle("SIGN IN", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        layoutUI()
    }
    
    private func layoutUI() {
        let logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.image = UIImage(named: "rxshop_logo")
        logo.contentMode = .scaleAspectFit
        addSubview(logo)
        
        NSLayoutConstraint.activate([
            logo.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            logo.heightAnchor.constraint(equalTo: logo.widthAnchor),
            logo.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            NSLayoutConstraint(item: logo, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 0.7, constant: 1)
        ])
                
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        
        addSubview(stackView)
        stackView.addArrangedSubview(signUp)
        stackView.addArrangedSubview(signIn)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60),
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -32)
        ])
    }
}
