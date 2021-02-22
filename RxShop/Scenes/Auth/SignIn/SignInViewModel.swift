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
    let status: Driver<String?>
}

typealias SignInAction = Result<User>

func signInViewModel() -> (_ input: SignInInput) -> (output: SignInOutput, action: Observable<SignInAction>) {
    return { input in
        
        let credentials = Observable
            .combineLatest(input.email, input.password) { (email: $0, password: $1) }
            .share(replay: 1)
        
        let status = credentials
            .skip(1)
            .map { credentialsState(email: $0.email, password: $0.password) }
            .map { $0.description }
            .startWith(" ")
            .asDriver(onErrorJustReturn: nil)
        
        let signInEnabled = credentials
            .map { $0.0.count > 0 && $0.1.count > 0 }
            .asDriver(onErrorJustReturn: false)
        
        let output = SignInOutput(signInEnabled: signInEnabled, status: status)
        
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
