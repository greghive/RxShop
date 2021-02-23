//
//  UIButton+RxHelpers.swift
//  RxShop
//
//  Created by Greg Price on 26/01/2021.
//

import UIKit
import RxSwift

extension UIButton {
    func rxTap() -> Observable<Void> {
        return rx.tap.asObservable()
    }
}
