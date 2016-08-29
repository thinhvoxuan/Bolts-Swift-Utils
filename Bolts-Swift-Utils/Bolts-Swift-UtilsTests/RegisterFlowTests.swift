//
//  RegisterFlowTests.swift
//  Bolts-Swift-Utils
//
//  Created by thinhvoxuan on 8/28/16.
//  Copyright © 2016 Thinhvoxuan. All rights reserved.
//

import XCTest
import EVReflection

class RegisterFlowTests: XCTestCase {

    let networking = ArabicaUilts.shareInstance
    override func setUp() {
        super.setUp()
        EVReflection.setBundleIdentifier(Config)
    }

    override func tearDown() { super.tearDown() }

    func testSuccessRegister() {
        let ex = expectationWithDescription("Signup with Normal Form")
        let postData = MockData.genSignupInformation()
        var result: UserToken? = nil
        networking.signUpWithData(postData).continueWith { task in
            result = task.result
            ex.fulfill()
        }
        waitForExpectationsWithTimeout(25, handler: nil)
        XCTAssertNotNil(result)
        XCTAssertNotNil(result?.token)
    }

    func testRegisterThenLogin() {
        let ex = expectationWithDescription("Signup with Normal Form")
        let postData = MockData.genSignupInformation()
        var result: UserToken? = nil
        networking.signUpWithData(postData).continueWith { task in
            self.networking.signInWithData(postData).continueWith(continuation: { task2 in
                result = task2.result
                ex.fulfill()
            })
        }
        waitForExpectationsWithTimeout(25, handler: nil)
        XCTAssertNotNil(result)
        XCTAssertNotNil(result?.token)
    }

    func testRegisterThenLoginFail() {
        let ex = expectationWithDescription("Signup with Normal Form")
        var postData = MockData.genSignupInformation()
        var error: ErrorType? = nil
        networking.signUpWithData(postData).continueWith { task in
            postData["password"] = "geekhub.vn"
            self.networking.signInWithData(postData).continueWith(continuation: { task2 in
                error = task2.error
                ex.fulfill()
            })
        }
        waitForExpectationsWithTimeout(25, handler: nil)
        XCTAssertNotNil(error)
        if let nsError = error as? NSError {
            XCTAssertEqual(nsError.localizedDescription, "Email hoặc mật khẩu không đúng. Vui lòng thử lại.")
        } else {
            XCTAssert(false, "Do not go here")
        }
    }

    func testSignupDoubleWithSameData() {
        let ex = expectationWithDescription("Signup with Normal Form")
        let postData = MockData.genSignupInformation()
        var error: ErrorType? = nil
        networking.signUpWithData(postData).continueWith { task in
            self.networking.signUpWithData(postData).continueWith { task2 in
                error = task2.error
                ex.fulfill()
            }
        }
        waitForExpectationsWithTimeout(25, handler: nil)
        XCTAssertNotNil(error)
        if let nsError = error as? NSError {
            XCTAssertEqual(nsError.localizedDescription, "The email has already been taken.")
        } else {
            XCTAssert(false, "Do not go here")
        }
    }
}
