//
//  LandingViewModel.swift
//  RxShop
//
//  Created by Greg Price on 12/01/2021.
//

import RxSwift
import RxCocoa

struct LandingInput {
    let viewWillAppear: Observable<Void>
    let signUpTap: Observable<Void>
    let signInTap: Observable<Void>
}

struct LandingOutput {
    let buttonsHidden: Driver<Bool>
}

enum LandingAction {
    case wantsSignUp
    case wantsSignIn
    case authenticated(User)
}

func landingViewModel() -> (_ input: LandingInput) -> (output: LandingOutput, action: Observable<LandingAction>) {
    return { input in
        
        let user = input.viewWillAppear
            .map { cachedUser()}
            .distinctUntilChanged()
            .share()
        
        let buttonsHidden = user
            .map { $0 != nil }
            .asDriver(onErrorJustReturn: false)
        
        let wantsSignUp = input.signUpTap
            .map { LandingAction.wantsSignUp }
        
        let wantsSignIn = input.signInTap
            .map { LandingAction.wantsSignIn }
        
        let authenticated = user
            .compactMap { $0 }
            .map { LandingAction.authenticated($0) }
        
        let action = Observable
            .merge(wantsSignUp, wantsSignIn, authenticated)
        
        return (LandingOutput(buttonsHidden: buttonsHidden), action)
    }
}
