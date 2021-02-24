//
//  ProfileViewController.swift
//  RxShop
//
//  Created by Greg Price on 01/02/2021.
//

import UIKit

class ProfileViewController: XiblessViewController<ProfileView>, HasViewModel {
    
    var viewModelFactory: (ProfileInput) -> ProfileOutput = { _ in fatalError("Missing view model factory.") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        
        let input = ProfileInput(signOut: contentView.signOut.rxTap())
        let viewModel = viewModelFactory(input)
        contentView.userLabel.text = viewModel.nameText
    }
}

