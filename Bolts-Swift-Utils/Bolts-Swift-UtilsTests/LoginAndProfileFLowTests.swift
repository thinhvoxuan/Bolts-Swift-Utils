//
//  LoginAndProfileFLowTests.swift
//  Bolts-Swift-Utils
//
//  Created by thinhvoxuan on 8/29/16.
//  Copyright © 2016 Thinhvoxuan. All rights reserved.
//

import XCTest
import EVReflection

class LoginAndProfileFLowTests: XCTestCase {

    let networking = ArabicaUilts.shareInstance
    var userToken: UserToken?
    override func setUp() {
        super.setUp()
        EVReflection.setBundleIdentifier(Config)

        let exp = expectationWithDescription("Register a user")
        let data = MockData.genSignupFullInformation()
        networking.signUpWithData(data).continueWith { task in
            self.userToken = task.result
            exp.fulfill()
        }
        waitForExpectationsWithTimeout(25, handler: nil)
        XCTAssertNotNil(self.userToken, "Register success")
    }

    override func tearDown() { super.tearDown() }

    func testSignupAndLoadProfile() {
        if userToken != nil {
            let exp = expectationWithDescription("fetch Profile user")
            var userInfor: UserInformation? = nil
            networking.loadProfile(self.userToken!).continueWith {
                taskUserProfile in
                userInfor = taskUserProfile.result
                exp.fulfill()
            }
            waitForExpectationsWithTimeout(25, handler: nil)
            XCTAssertNotNil(userInfor, "Fetch success profile")
            XCTAssertNotNil(userInfor?.name, "Fetch success profile")
            XCTAssertTrue(userInfor?.name.characters.count > 0, "name must greater than 0")
        } else {
            XCTFail("Could not load Profile from Register")
        }
    }

    func testFetchProfileWithWrongToken() {
        let tokenNotExits = UserToken(json: "{\"token\":\"abc123\"}")
        let exp = expectationWithDescription("fetch Profile user")
        var userInfor: UserInformation? = nil
        networking.loadProfile(tokenNotExits).continueWith {
            taskUserProfile in
            userInfor = taskUserProfile.result
            exp.fulfill()
        }
        waitForExpectationsWithTimeout(25, handler: nil)
        XCTAssertNotNil(userInfor, "Fetch success profile")
        XCTAssertTrue(userInfor?.message.characters.count > 0, "message must greater than 0")
        XCTAssertTrue(userInfor?.code != 200, "status_code differ from 200")
    }
}
