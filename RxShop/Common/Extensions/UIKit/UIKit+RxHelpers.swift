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

extension UITableView {
    func rxItemDeleted() -> Observable<IndexPath> {
        return rx.itemDeleted.asObservable()
    }
}

extension UIViewController {
    func rxViewWillAppear() -> Observable<Void> {
        rx.methodInvoked(#selector(viewWillAppear(_:))).asVoid()
    }
}

extension UIViewController {
    enum AlertAction {
        case `default`
        case cancel
    }
    
    func alert(title: String? = nil, message: String, defaultTitle: String, cancelTitle: String = "Cancel") -> Observable<AlertAction> {
        return Observable.create { [weak self] observable in
            let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: defaultTitle, style: .default, handler: { _ in
                observable.onNext(.default)
                observable.onCompleted()
            }))
            vc.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: { _ in
                observable.onNext(.cancel)
                observable.onCompleted()
            }))
            self?.present(vc, animated: true)
            return Disposables.create {
                self?.dismiss(animated: true)
            }
        }
    }
}
