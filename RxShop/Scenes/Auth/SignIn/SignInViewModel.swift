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
    let signInRunning: Driver<Bool>
    let stateString: Driver<String?>
}

typealias SignInAction = Result<User>

func signInViewModel() -> (_ input: SignInInput) -> (output: SignInOutput, action: Observable<SignInAction>) {
    return { input in
        
        let credentials = Observable
            .combineLatest(input.email, input.password) { (email: $0, password: $1) }
            .share(replay: 1)
        
        let state = credentials
            .map { credentialsState(email: $0.email, password: $0.password) }
            .share(replay: 1)
        
        let stateString = state
            .skip(1)
            .map { $0.description }
            .startWith(" ")
            .asDriver(onErrorJustReturn: nil)
                
        let signIn = input.signIn
            .share(replay: 1)
        
        let response = signIn
            .withLatestFrom(credentials)
            .map { SignInBody(email: $0.email, password: $0.password) }
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
            .share(replay: 1)
        
        let running = Observable.merge(
            signIn.map { _ in true },
            action.map { _ in false })
            .share(replay: 1)

        let signInRunning = running
            .asDriver(onErrorJustReturn: false)
        
        let signInEnabled = Observable.merge(
            state.map { $0 == .allInputsValid },
            running.map { !$0 })
            .asDriver(onErrorJustReturn: false)
        
        let output = SignInOutput(signInEnabled: signInEnabled, signInRunning: signInRunning, stateString: stateString)
        
        return (output: output, action: action)
    }
}
