//
//  AuthFlow.swift
//  RxShop
//
//  Created by Greg Price on 20/01/2021.
//

import RxSwift

extension ObservableType where Element == LandingAction {
    
    func flow(showCreateAccount: @escaping () -> Observable<CreateAccountAction>,
              showCreatePassword: @escaping (AccountDetails) -> Observable<SignUpAction>,
              showSignIn: @escaping () -> Observable<SignInAction>) -> Observable<Result<User, Error>> {
        
        let signUp = self
            .filter { $0.wantsSignUp }
            .asVoid()
            .flatMap(showCreateAccount)
            .flatMap {showCreatePassword($0)}
        
        let signIn = self
            .filter { $0.wantsSignIn }
            .asVoid()
            .flatMap(showSignIn)
            
        let authenticated = self
            .filter { $0.authenticated != nil }
            .compactMap { $0.authenticated }
            .map { SignInAction.success($0) }
        
        return Observable.merge(signUp, signIn, authenticated)
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
    
    var authenticated: User? {
        if case .authenticated(let user) = self { return user }
        else { return nil }
    }
}
