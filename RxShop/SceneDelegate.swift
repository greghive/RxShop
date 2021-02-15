//
//  SceneDelegate.swift
//  RxShop
//
//  Created by Greg Price on 12/01/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        authCoordinator(window)
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}

