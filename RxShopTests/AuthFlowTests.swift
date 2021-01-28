//
//  AuthFlowTests.swift
//  RxShopTests
//
//  Created by Greg Price on 23/01/2021.
//

import XCTest
import RxSwift
import RxTest
@testable import RxShop

class AuthFlowTests: XCTestCase {

    var scheduler: TestScheduler!
    var subscription: Disposable!
    
    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDown() {
        super.tearDown()
        scheduler.scheduleAt(1000) {
            self.subscription.dispose()
        }
    }
    
    func testInt() {
        let observer = scheduler.createObserver(Int.self)
        let observable = scheduler.createHotObservable([
            Recorded.next(100, LandingAction.wantsSignUp),
            Recorded.next(200, LandingAction.wantsSignIn),
        ])
        
        subscription = observable
            .int()
            .subscribe(observer)
        scheduler.start()
        
        let results = observer.events.compactMap { $0.value.element }
        XCTAssertEqual(results, [1, 2])
    }
    
    
}
