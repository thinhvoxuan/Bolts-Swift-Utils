//
//  ConfigLoadTests.swift
//  Bolts-Swift-Utils
//
//  Created by thinhvoxuan on 8/26/16.
//  Copyright © 2016 Thinhvoxuan. All rights reserved.
//

import XCTest
import BoltsSwift
import EVReflection
class ConfigLoadTests: XCTestCase {

    let networking = ArabicaUilts.shareInstance
    override func setUp() {
        super.setUp()
        EVReflection.setBundleIdentifier(ConfigApp)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testLoadConfig() {
        let ex = expectationWithDescription("Config Error Reponse")
        var resultTask: Task<ConfigApp>? = nil
        networking.fetchConfig().continueWith { task in
            resultTask = task
            ex.fulfill()
        }
        waitForExpectationsWithTimeout(25, handler: nil)
        print("Result: \(resultTask)")
        XCTAssertNotNil(resultTask, "Config result must not nil")
        XCTAssertNotNil(resultTask!.result, "Config result must not nil")
        XCTAssertNotNil(resultTask!.result!.android, "Config result must not nil")
        XCTAssertNotNil(resultTask!.result!.ios, "Config result must not nil")
    }

    func testNeedUpdate() {
        let config = ConfigApp()
        config.ios = "10.0.1"
        let trueResult = config.isNeedUpdate()
        XCTAssertTrue(trueResult, "Must be update if config version is Greater")
    }

    func testNoNeedUpdate() {
        let config = ConfigApp()
        config.ios = "0.0.1"
        let falseResult = config.isNeedUpdate()
        XCTAssertTrue(!falseResult, "Must be update if config version is Greater")
    }
}
