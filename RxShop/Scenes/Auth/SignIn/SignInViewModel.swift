//
//  SignInViewModel.swift
//  RxShop
//
//  Created by Greg Price on 15/01/2021.
//

import Foundation
import RxSwift
import RxCocoa

struct SignInInput {
    let email: Observable<String>
    let password: Observable<String>
    let signIn: Observable<Void>
}

struct SignInOutput {
    let signInEnabled: Driver<Bool>
}

typealias SignInAction = Result<User>

func signInViewModel() -> (_ input: SignInInput) -> (output: SignInOutput, action: Observable<SignInAction>) {
    return { input in
        
        let credentials = Observable
            .combineLatest(input.email, input.password)
            .share(replay: 1)
        
        let signInEnabled = credentials
            .map { $0.0.count > 0 && $0.1.count > 0 }
            .asDriver(onErrorJustReturn: false)
        
        let output = SignInOutput(signInEnabled: signInEnabled)
        
        let response = input.signIn
            .withLatestFrom(credentials)
            .map { SignInBody(email: $0.0, password: $0.1) }
            .flatMapLatest { dataTask(with: URLRequest.signIn($0)) }
            .share(replay: 1)
        
        let user = response
            .map { $0.map { try JSONDecoder().decode(User.self, from: $0) } }
            .map { $0.map { SignInAction.success($0) } }
            .compactMap { $0.success }
        
        let error = response
            .compactMap { $0.error }
            .map { SignInAction.error($0) }
        
        let action = Observable
            .merge(user, error)
        
        return (output: output, action: action)
    }
}
