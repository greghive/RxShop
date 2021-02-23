//
//  CreateAccountViewModel.swift
//  RxShop
//
//  Created by Greg Price on 15/01/2021.
//

import RxSwift
import RxCocoa

struct CreateAccountInput {
    let firstName: Observable<String>
    let lastName: Observable<String>
    let email: Observable<String>
    let next: Observable<Void>
}

struct CreateAccountOutput {
    let nextEnabled: Driver<Bool>
    let stateString: Driver<String?>
}

typealias AccountDetails = (firstName: String, lastName: String, email: String)
typealias CreateAccountAction = AccountDetails

func createAccountViewModel() -> (_ input: CreateAccountInput) -> (output: CreateAccountOutput, action: Observable<CreateAccountAction>) {
    return { input in
        
        let credentials = Observable
            .combineLatest(input.firstName, input.lastName, input.email) { (firstName: $0, lastName: $1, email: $2) }
            .share(replay: 1)
        
        let state = credentials
            .map { credentialsState(firstName: $0.firstName, lastName: $0.lastName, email: $0.email) }
            .share(replay: 1)
        
        let stateString = state
            .skip(1)
            .map { $0.description }
            .startWith(" ")
            .asDriver(onErrorJustReturn: nil)
        
        let nextEnabled = state
            .map { $0 == .allInputsValid }
            .asDriver(onErrorJustReturn: false)

        let output = CreateAccountOutput(nextEnabled: nextEnabled, stateString: stateString)
        
        let action = input.next
            .withLatestFrom(credentials)
        
        return (output: output, action: action)
    }
}
