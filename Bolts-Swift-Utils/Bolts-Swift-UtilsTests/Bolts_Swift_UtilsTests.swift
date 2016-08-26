//
//  Bolts_Swift_UtilsTests.swift
//  Bolts-Swift-UtilsTests
//
//  Created by thinhvoxuan on 8/25/16.
//  Copyright © 2016 Thinhvoxuan. All rights reserved.
//

import XCTest
import BoltsSwift
import EVReflection
@testable import Bolts_Swift_Utils

class BoltsSwiftUtilsTests: XCTestCase {

    let networking = NetworkingUtils.shareInstance
    override func setUp() {
        super.setUp()
        EVReflection.setBundleIdentifier(Weather)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testWeather() {
        let ex = expectationWithDescription("Weather Response")
        var resultTask: Task<Weather>? = nil

        networking.fetchWeatherInformation().continueWith { task in
            resultTask = task
            ex.fulfill()
        }

        waitForExpectationsWithTimeout(5, handler: nil)
        XCTAssertNotNil(resultTask, "Weather result must not nil")
        XCTAssertNotNil(resultTask!.result, "Weather result must not nil")
    }

    func testWeatherError() {
        let ex = expectationWithDescription("Weather Error Reponse")
        var resultTask: Task<Weather>? = nil
        networking.fetchWeatherError().continueWith { task in
            resultTask = task
            ex.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: nil)
        XCTAssertNotNil(resultTask, "Weather result must not nil")
        XCTAssertNotNil(resultTask!.result, "Weather result must not nil")
        XCTAssertEqual(resultTask!.result!.code, 401)
    }

    func testLoadConfig() {
        let ex = expectationWithDescription("Config Error Reponse")
        var resultTask: Task<Config>? = nil
        networking.fetchConfig().continueWith { task in
            resultTask = task
            ex.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: nil)
        print("Result: \(resultTask)")
        XCTAssertNotNil(resultTask, "Config result must not nil")
        XCTAssertNotNil(resultTask!.result, "Config result must not nil")
        XCTAssertNotNil(resultTask!.result!.android, "Config result must not nil")
        XCTAssertNotNil(resultTask!.result!.ios, "Config result must not nil")
    }

}
