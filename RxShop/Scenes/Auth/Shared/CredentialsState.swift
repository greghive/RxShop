//
//  CredentialsState.swift
//  RxShop
//
//  Created by Greg Price on 22/02/2021.
//

import Foundation

enum CredentialsState {
    case missingInputs
    case emailIsInvalid
    case passwordsDoNotMatch
    case allInputsValid
    
    var description: String {
        switch self {
        case .missingInputs:
            return "Please complete all details"
        case .emailIsInvalid:
            return "Your email is invalid"
        case .passwordsDoNotMatch:
            return "Your passwords do not match"
        case .allInputsValid:
            return " "
        }
    }
}

func credentialsState(email: String, password: String) -> CredentialsState {
    if email.isEmpty || password.isEmpty {
        return .missingInputs
    } else if !email.isValidEmail {
        return .emailIsInvalid
    } else {
        return .allInputsValid
    }
}

func credentialsState(firstName: String, lastName: String, email: String) -> CredentialsState {
    return .missingInputs
}

func credentialsState(password: String, confirmPassword: String) -> CredentialsState {
    return .missingInputs
}


