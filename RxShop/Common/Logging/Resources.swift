//
//  Resources.swift
//  RxShop
//
//  Created by Greg Price on 25/02/2021.
//

import RxSwift

/*
 https://github.com/ReactiveX/RxSwift/blob/main/Documentation/GettingStarted.md#debugging-memory-leaks
 Most efficient way to test for memory leaks is:
 
 - navigate to your screen and use it
 - navigate back
 - observe initial resource count
 - navigate second time to your screen and use it
 - navigate back
  -observe final resource count
 
 In case there is a difference in resource count between initial and final resource counts, there might be a memory leak somewhere.
 The reason why 2 navigations are suggested is because first navigation forces loading of lazy resources.
 */

func logRxResources() {
    #if DEBUG
    _ = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        .map { _ in RxSwift.Resources.total }
        .distinctUntilChanged()
        .subscribe(onNext: { print("♦️ Resource count", $0) })
    #endif
}
