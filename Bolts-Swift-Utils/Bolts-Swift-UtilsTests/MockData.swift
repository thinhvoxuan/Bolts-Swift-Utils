//
//  MockData.swift
//  Bolts-Swift-Utils
//
//  Created by thinhvoxuan on 8/28/16.
//  Copyright © 2016 Thinhvoxuan. All rights reserved.
//

import UIKit

class MockData: NSObject {
    static func genFbResponse() -> FacebookResponse {
        let fakeUserID = "testUser\(NSDate().timeIntervalSince1970)"
        let fbToken = [
            "tokenString": "tokensdk\(NSDate().timeIntervalSince1970)",
            "userID": fakeUserID
        ]
        let meInfor: [String: String] = [
            "name": fakeUserID,
            "email": "\(fakeUserID)@geekup.vn",
            "birthday": "04/24/1992"
        ]
        return FacebookResponse(
            accessToken:FacebookToken(dictionary: fbToken),
            meInfor: meInfor)
    }

    static func genFbResponseWithNameOnly() -> FacebookResponse {
        let fakeUserID = "testUser\(NSDate().timeIntervalSince1970)"
        let fbToken = [
            "tokenString": "tokensdk\(NSDate().timeIntervalSince1970)",
            "userID": fakeUserID
        ]
        let meInfor: [String: String] = [
            "name": fakeUserID
        ]
        return FacebookResponse(
            accessToken:FacebookToken(dictionary: fbToken),
            meInfor: meInfor)
    }

    static func genFbResponseWithWrongBirthdaylField() -> FacebookResponse {

        let fakeUserID = "testUser\(NSDate().timeIntervalSince1970)"
        let fbToken = [
            "tokenString": "tokensdk\(NSDate().timeIntervalSince1970)",
            "userID": fakeUserID
        ]
        let meInfor: [String: String] = [
            "name": fakeUserID,
            "email": "\(fakeUserID)@geekup.vn",
            "birthday": "2014/2014/2014"
        ]
        return FacebookResponse(
            accessToken:FacebookToken(dictionary: fbToken),
            meInfor: meInfor)
    }


    static func genSignupInformation() -> [String: String] {
        let fakeUserID = "testUser\(NSDate().timeIntervalSince1970)"
        return [
            "name": fakeUserID,
            "email": "\(fakeUserID)@geekup.vn",
            "password": "ABC123",
            "city" : "HỒ CHÍ MINH",
        ]
    }

    static func genSignupFullInformation() -> [String: String] {
        let fakeUserID = "testUser\(NSDate().timeIntervalSince1970)"
        return [
            "name": fakeUserID,
            "email": "\(fakeUserID)@geekup.vn",
            "password": "ABC123",
            "city" : "HỒ CHÍ MINH",
            "birthday" : "2014/04/24",
            "phone": "0909090999"
        ]
    }
}
