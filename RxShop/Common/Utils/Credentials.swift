//
//  Credentials.swift
//  RxShop
//
//  Created by Greg Price on 22/02/2021.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}

extension String {
    var isValidName: Bool { count > 0 }
}

func credentialsState(email: String, password: String) -> CredentialsState {
    if email.isEmpty || password.isEmpty {
        return CredentialsState.missingInputs
    } else if !email.isValidEmail {
        return CredentialsState.emailIsInvalid
    } else {
        return CredentialsState.allInputsValid
    }
}

enum CredentialsState {
    case missingInputs
    case emailIsInvalid
    case passwordsDoNotMatch
    case allInputsValid
    
    var description: String? {
        switch self {
        case .missingInputs:
            return "Please complete all details"
        case .emailIsInvalid:
            return "Your email is invalid"
        case .passwordsDoNotMatch:
            return "Your passwords do not match"
        case .allInputsValid:
            return nil
        }
    }
}
