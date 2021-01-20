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

typealias SignInAction = Result<User, Error>

func signInViewModel() -> (_ input: SignInInput) -> (output: SignInOutput, action: Observable<SignInAction>) {
    return { input in
        
        let credentials = Observable
            .combineLatest(input.email, input.password)
            .share()
        
        let signInEnabled = credentials
            .map { $0.0.count > 0 && $0.1.count > 0 }
            .asDriver(onErrorJustReturn: false)
        
        let output = SignInOutput(signInEnabled: signInEnabled)
        
        let response = input.signIn
            .withLatestFrom(credentials)
            .map { SignInBody(email: $0.0, password: $0.1) }
            .flatMap { dataTask(with: URLRequest.signIn($0)) }
        
        let user = response
            .map { try JSONDecoder().decode(User.self, from: $0) }
            .map { SignInAction.success($0) }
        
        return (output: output, action: user)
    }
}
