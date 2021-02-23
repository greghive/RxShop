//
//  AuthView.swift
//  RxShop
//
//  Created by Greg Price on 22/02/2021.
//

import UIKit

class AuthView: UIView {
    
    private var inputs = [UITextField]()
    
    private(set) var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    private(set) var statusLabel: UILabel = {
        let label = UILabel.body
        label.textColor = .rxShopRed
        label.textAlignment = .center
        return label
    }()
    
    private(set) var button: UIButton = {
        return UIButton.bigRed
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        self.backgroundColor = .systemBackground
        addSubview(stackView)
        addSubview(statusLabel)
        addSubview(button)
        
        let stackGap: CGFloat = 32
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: stackGap),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: stackGap),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -stackGap)
        ])
        
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            statusLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 60),
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            button.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -60)
        ])
    }
    
    func addInputs(_ inputs: [UITextField]) {
        for (index, input) in inputs.enumerated() {
            self.inputs.append(input)
            self.stackView.addArrangedSubview(input)
            input.delegate = self
            if index < inputs.count - 1 {
                input.returnKeyType = .next
            } else {
                input.returnKeyType = .go
            }
        }
    }
}

extension AuthView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        for (index, input) in inputs.enumerated() {
            if input === textField {
                if index < inputs.count - 1 {
                    inputs[index + 1].becomeFirstResponder()
                    break
                } else {
                    input.resignFirstResponder()
                    break
                }
            }
        }
        return true
    }
}
