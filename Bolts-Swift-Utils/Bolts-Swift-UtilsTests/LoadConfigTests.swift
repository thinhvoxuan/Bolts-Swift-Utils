//
//  LoadConfigTests.swift
//  Bolts-Swift-Utils
//
//  Created by thinhvoxuan on 8/28/16.
//  Copyright © 2016 Thinhvoxuan. All rights reserved.
//

import XCTest
import BoltsSwift
import EVReflection

class LoadConfigTests: XCTestCase {

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
}
