//
//  ProfileViewModel.swift
//  RxShop
//
//  Created by Greg Price on 23/02/2021.
//

import RxSwift

struct ProfileInput {
    let signOut: Observable<Void>
}

struct ProfileOutput {
    let nameText: String
}

enum ProfileAction {
    case signOut
}

func profileViewModel(user: User) -> (_ input: ProfileInput) -> (output: ProfileOutput, action: Observable<ProfileAction>) {
    return { input in
        let output = ProfileOutput(nameText: "You are logged in as \(user.fullName)")
        let action = input.signOut.map { ProfileAction.signOut }
        return (output: output, action: action)
    }
 }
