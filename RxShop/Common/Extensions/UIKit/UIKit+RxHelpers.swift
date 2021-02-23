//
//  UIKit+RxHelpers.swift
//  RxShop
//
//  Created by Greg Price on 23/02/2021.
//

import UIKit
import RxSwift

extension UITextField {
    func rxText() -> Observable<String> {
        rx.text.orEmpty.asObservable()
    }
}

extension UIButton {
    func rxTap() -> Observable<Void> {
        rx.tap.asObservable()
    }
}

extension UIViewController {
    func rxViewWillAppear() -> Observable<Void> {
        rx.methodInvoked(#selector(viewWillAppear(_:))).asVoid()
    }
}
