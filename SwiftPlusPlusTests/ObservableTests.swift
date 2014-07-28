//
//  ObservableTests.swift
//  SwiftPlusPlus
//
//  Created by Andrew J Wagner on 7/27/14.
//  Copyright (c) 2014 Drewag LLC. All rights reserved.
//

import UIKit
import XCTest

class ObservableTests: XCTestCase {
    func testSubscribing() {
        var observable = Observable<String>("Old Value")
        var called = false
        observable.addObserverForOwner(self, triggerImmediately: false) {
            (oldValue: String?, newValue: String) in
            XCTAssertEqual(oldValue!, "Old Value")
            XCTAssertEqual(newValue, "New Value")
            called = true
        }
        observable.value = "New Value"
        XCTAssertTrue(called)
    }

    func testUnsubscribing() {
        var observable = Observable<String>("Old Value")
        var called = false
        observable.addObserverForOwner(self, triggerImmediately: false) {
            (oldValue: String?, newValue: String) in
            called = true
        }
        observable.removeObserversForOwner(self)
        observable.value = "New Value"
        XCTAssertFalse(called)
    }

    func testTriggerImmediately() {
        var observable = Observable<String>("Current Value")
        var called = false
        observable.addObserverForOwner(self, triggerImmediately: true) {
            (oldValue: String?, newValue: String) in
            XCTAssertNil(oldValue)
            XCTAssertEqual(newValue, "Current Value")
            called = true
        }
        XCTAssertTrue(called)
    }
}
