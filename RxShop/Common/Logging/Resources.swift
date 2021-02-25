//
//  Resources.swift
//  RxShop
//
//  Created by Greg Price on 25/02/2021.
//

import RxSwift

func logRxResources() {
    #if DEBUG
    _ = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        .map { _ in RxSwift.Resources.total }
        .distinctUntilChanged()
        .subscribe(onNext: { print("♦️ Resource count", $0) })
    #endif
}
