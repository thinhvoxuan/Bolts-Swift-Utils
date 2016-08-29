//
//  FacebookLoginFlowTests.swift
//  Bolts-Swift-Utils
//
//  Created by thinhvoxuan on 8/26/16.
//  Copyright © 2016 Thinhvoxuan. All rights reserved.
//

import XCTest
import EVReflection
import FBSDKLoginKit

class FacebookLoginFlowTests: XCTestCase {

    let networking = ArabicaUilts.shareInstance
    override func setUp() {
        super.setUp()
        EVReflection.setBundleIdentifier(ConfigApp)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSignupFacebook() {
        let ex = expectationWithDescription("Signup with Facebook")
        let fbReponse = MockData.genFbResponse()
        var result: UserToken? = nil
        networking.signupWithFacebook(fbReponse).continueWith { task in
            result = task.result
            ex.fulfill()
        }
        waitForExpectationsWithTimeout(25, handler: nil)
        XCTAssertNotNil(result)
        XCTAssertNotNil(result?.token)
    }


    func testSignupFacebookWithoutEmail() {
        let ex = expectationWithDescription("Signup with Facebook")
        let fbReponse = MockData.genFbResponseWithNameOnly()
        var result: UserToken? = nil
        networking.signupWithFacebook(fbReponse).continueWith { task in
            result = task.result
            ex.fulfill()
        }
        waitForExpectationsWithTimeout(25, handler: nil)
        XCTAssertNotNil(result)
        XCTAssertNotNil(result?.token)
    }

    func testSignupErrorWithWrongBirthdayField() {
        let ex = expectationWithDescription("Signup with Facebook")
        let fbReponse = MockData.genFbResponseWithWrongBirthdaylField()
        var result: UserToken? = nil
        networking.signupWithFacebook(fbReponse).continueWith { task in
            result = task.result
            ex.fulfill()
        }
        waitForExpectationsWithTimeout(25, handler: nil)
        XCTAssertNotNil(result)
        XCTAssertNotNil(result?.token)
    }

}
