//
//  SignUpFlow.swift
//  RxShop
//
//  Created by Greg Price on 23/01/2021.
//

import RxSwift
import UIKit

enum SignUpStep {
 
    case createAccount(CreateAccountAction)
    case setPassword(SignUpAction)
}

extension SignUpStep {
    
    var wantsCreateAccount: Bool {
        if case .createAccount = self { return true }
        else { return false }
    }
    
    var wantsSetPassword: Bool {
        if case .setPassword = self { return true }
        else { return false }
    }
    
    var signUpAction: SignUpAction? {
        if case .setPassword(let action) = self { return action }
        else { return nil }
    }
}

extension ObservableType where Element == SignUpStep {
    
    func signUp(navController: UINavigationController,
                showCreateAccount: @escaping (UINavigationController) -> Observable<CreateAccountAction>,
                showCreatePassword: @escaping (UINavigationController, AccountDetails) -> Observable<SignUpAction>) -> Observable<SignUpStep> {
        
        let createAccount = self
            .filter { $0.wantsCreateAccount}
            .asVoid()
            .flatMap { showCreateAccount(navController) }
            .map { SignUpStep.createAccount($0) }
        
        let setPassword = self
            .filter { $0.wantsSetPassword }
        
        return Observable.merge(createAccount, setPassword)
    }
}
