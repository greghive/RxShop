//
//  AuthFlow.swift
//  RxShop
//
//  Created by Greg Price on 20/01/2021.
//

import UIKit
import RxSwift

extension ObservableType where Element == LandingAction {
        
    func int() -> Observable<Int> {
        let signUp = self
            .filter { $0.wantsSignUp }
            .asVoid()
            .map { 1 }
        let signIn = self
            .filter { $0.wantsSignIn }
            .asVoid()
            .map { 2 }
        return Observable.merge(signUp.debug("🟢 signUp"), signIn.debug("🟢 signIn")).debug("🟢 merge")
    }
    
    func flow(navController: UINavigationController,
              showSignIn: @escaping (UINavigationController) -> Observable<SignInAction>,
              showCreateAccount: @escaping (UINavigationController) -> Observable<CreateAccountAction>,
              showCreatePassword: @escaping (UINavigationController, AccountDetails) -> Observable<SignInAction>) -> Observable<Result<User>> {
        
        let signIn = self
            .filter { $0.wantsSignIn }
            .asVoid()
            .flatMapLatest { showSignIn(navController) }
            
        let signUp = self
            .filter { $0.wantsSignUp }
            .asVoid()
            .flatMapLatest { showCreateAccount(navController) }
            .flatMapLatest { showCreatePassword(navController, $0) }
        
        let authenticated = self
            .compactMap { $0.authenticated }
            .map { SignInAction.success($0) }
        
        return Observable
            .merge(signIn, signUp, authenticated)
            .observe(on: MainScheduler.instance)
    }
}

extension LandingAction {
    
    var wantsSignUp: Bool {
        if case .wantsSignUp = self { return true }
        else { return false }
    }
    
    var wantsSignIn: Bool {
        if case .wantsSignIn = self { return true }
        else { return false }
    }
    
    var isCheckAuthentication: Bool {
        if case .authenticated(_) = self { return true }
        else { return false }
    }

    var authenticated: User? {
        if case .authenticated(let user) = self { return user }
        else { return nil }
    }
}
