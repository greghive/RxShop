//
//  TextFieldResponding.swift
//  RxShop
//
//  Created by Greg Price on 18/02/2021.
//

import UIKit

protocol TextFieldResponding {
    
    var inputs: [UITextField]! { get set }
    func configureInputs(delegate: UITextFieldDelegate)
    func handleTextFieldShouldReturn(_ textField: UITextField) -> Bool
    func handleFinalTextFieldResigned()
    func getNextInputReturnKeyType() -> UIReturnKeyType
    func getFinalInputReturnKeyType() -> UIReturnKeyType
    func resignFirstInputResponder()
}

extension TextFieldResponding where Self: UIViewController & UITextFieldDelegate {
    
    func configureInputs(delegate: UITextFieldDelegate) {
        for (index, input) in inputs.enumerated() {
            input.delegate = delegate
            if index < inputs.count - 1 {
                input.returnKeyType = getNextInputReturnKeyType()
            } else {
                input.returnKeyType = getFinalInputReturnKeyType()
            }
        }
    }
    
    func handleTextFieldShouldReturn(_ textField: UITextField) -> Bool {
        for (index, input) in inputs.enumerated() {
            if input === textField {
                if index < inputs.count - 1 {
                    inputs[index + 1].becomeFirstResponder()
                    break
                } else {
                    handleFinalTextFieldResigned()
                    input.resignFirstResponder()
                    break
                }
            }
        }
        return true
    }
    
    func handleFinalTextFieldResigned() {}
    
    func getNextInputReturnKeyType() -> UIReturnKeyType {
        return .next
    }
    
    func getFinalInputReturnKeyType() -> UIReturnKeyType {
        return .go
    }
    
    func resignFirstInputResponder() {
        inputs.filter { $0.isFirstResponder }.first?.resignFirstResponder()
    }
}

