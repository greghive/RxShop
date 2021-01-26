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
    let signUp: Observable<String>
}

struct CreatePasswordOutput {
    let signUpEnabled: Driver<Bool>
}

typealias SignUpAction = Result<User, Error>

func createPasswordViewModel(accountDetails: AccountDetails) -> (_ input: CreatePasswordInput) -> (output: CreatePasswordOutput, action: Observable<SignUpAction>) {
    return { input in
        
        let passwords = Observable
            .combineLatest(input.password, input.confirmation)
            .share()
                
        let signUpEnabled = passwords
            .map { $0.0.count > 0 && $0.0 == $0.1 }
            .asDriver(onErrorJustReturn: false)
        
        let output = CreatePasswordOutput(signUpEnabled: signUpEnabled)
        
        let response = input.signUp
            .withLatestFrom(passwords)
            .map { SignUpBody(firstName: accountDetails.firstName,
                              lastName: accountDetails.lastName,
                              email: accountDetails.email,
                              password: $0.0) }
            .flatMap { dataTask(with: URLRequest.signUp($0)) }
        
        let user = response
            .decode(type: User.self, decoder: jsonDecoder()) // what if this fails?????
            .map { SignUpAction.success($0) }
        
        // no way to get the error out ????
        // see Daniels code 'dataTask(with)' + materialize
        
        return (output: output, action: user)
    }
}
