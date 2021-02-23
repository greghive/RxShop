//
//  CreatePasswordViewModel.swift
//  RxShop
//
//  Created by Greg Price on 15/01/2021.
//

import Foundation
import RxSwift
import RxCocoa

struct CreatePasswordInput {
    let password: Observable<String>
    let confirmation: Observable<String>
    let signUp: Observable<Void>
}

struct CreatePasswordOutput {
    let signUpEnabled: Driver<Bool>
    let stateString: Driver<String?>
}

typealias SignUpAction = Result<User>

func createPasswordViewModel(accountDetails: AccountDetails) -> (_ input: CreatePasswordInput) -> (output: CreatePasswordOutput, action: Observable<SignUpAction>) {
    return { input in
        
        let passwords = Observable
            .combineLatest(input.password, input.confirmation) { (password: $0, confirmation: $1) }
            .share(replay: 1)
          
        let state = passwords
            .map { credentialsState(password: $0.password, confirmation: $0.confirmation) }
            .share(replay: 1)
        
        let stateString = state
            .skip(1)
            .map { $0.description }
            .startWith(" ")
            .asDriver(onErrorJustReturn: nil)
        
        let signUpEnabled = state
            .map { $0 == .allInputsValid }
            .asDriver(onErrorJustReturn: false)
        
//        let signUpEnabled = passwords
//            .map { $0.0.count > 0 && $0.0 == $0.1 }
//            .asDriver(onErrorJustReturn: false)
        
        let output = CreatePasswordOutput(signUpEnabled: signUpEnabled, stateString: stateString)
        
        let response = input.signUp
            .withLatestFrom(passwords)
            .map { SignUpBody(firstName: accountDetails.firstName,
                              lastName: accountDetails.lastName,
                              email: accountDetails.email,
                              password: $0.0) }
            .flatMapLatest { dataTask(with: URLRequest.signUp($0)) }
            .share(replay: 1)
        
        let user = response
            .map { $0.map { try JSONDecoder().decode(User.self, from: $0) } }
            .map { $0.map { SignUpAction.success($0) } }
            .compactMap { $0.success }
        
        let error = response
            .compactMap { $0.error }
            .map { SignUpAction.error($0) }
        
        let action = Observable
            .merge(user, error)
   
        return (output: output, action: action)
    }
}
