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
