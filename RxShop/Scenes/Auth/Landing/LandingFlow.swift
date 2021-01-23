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
    
    func flow(navController: UINavigationController, showSignIn: @escaping (UINavigationController) -> Observable<SignInAction>) -> Observable<Result<User, Error>> {
        let signIn = self
            .filter { $0.wantsSignIn }
            .asVoid()
            .flatMapLatest {showSignIn(navController)}
            
        let authenticated = self
            .filter { $0.isCheckAuthentication }
            .compactMap { $0.authenticated }
            .map { SignInAction.success($0) }
        
        return Observable.merge(signIn.debug("🟢 signIn"), authenticated.debug("🟢 authenticated"))
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
