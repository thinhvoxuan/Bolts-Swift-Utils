//
//  ArabicaUilts.swift
//  Bolts-Swift-Utils
//
//  Created by thinhvoxuan on 8/26/16.
//  Copyright © 2016 Thinhvoxuan. All rights reserved.
//

import UIKit
import BoltsSwift

class ArabicaUilts: NetwokingBase {
    static let shareInstance = ArabicaUilts()
    let model = ModelUtils.shareInstance

    struct ROUTE {
        static let ROOT = "http://api.thecoffeehouse.vn/api"
        static let config = ROUTE.ROOT + "/config"
        static let signup = ROUTE.ROOT + "/signup"
        static let signin = ROUTE.ROOT + "/login"
        static let profile = ROUTE.ROOT + "/profile"
    }

    func fetchConfig() -> Task<ConfigApp> {
        return fetchRequest(ROUTE.config)
            .continueOnSuccessWithTask(continuation: model.parseConfigModel)
    }

    func buildSignupData(fbResponse: FacebookResponse) -> [String:String] {
        var facebookInformation: [String: String] = [:]
        facebookInformation["facebookId"] = fbResponse.accessToken.userID
        facebookInformation["facebookToken"] = fbResponse.accessToken.tokenString
        facebookInformation["name"] = fbResponse.meInfor["name"] as? String
        facebookInformation["email"] = ""
        if let emailValue =  fbResponse.meInfor["email"] as? String {
            facebookInformation["email"] = emailValue
        }
        facebookInformation["birthday"] = ""
        if let birthdayValue =  fbResponse.meInfor["birthday"] as? String {
            let reFormatBirthdayValue = TransformUtils.changeFormatDate(birthdayValue, fromFormat: "MM/dd/yyyy", toFormat: "yyyy/MM/dd")
            facebookInformation["birthday"] = reFormatBirthdayValue
        }
        facebookInformation["avatar"] = "https://graph.facebook.com/\(fbResponse.accessToken.userID)/picture?type=large&width=200&height=200"
        return facebookInformation
    }

    func signupWithFacebook(fbResponse: FacebookResponse) -> Task<UserToken> {
        let postData = buildSignupData(fbResponse)
        return self.signUpWithData(postData)
    }

    func signUpWithData(postData: [String: String]) -> Task<UserToken> {
        return postRequest(ROUTE.signup, params: postData)
            .continueOnSuccessWithTask(continuation: model.parseTokenModel)
    }

    func signInWithData(postData: [String:String]) -> Task<UserToken> {
        return postRequest(ROUTE.signin, params: postData)
            .continueOnSuccessWithTask(continuation: model.parseTokenModel)
    }

    func loadProfile(token: UserToken) -> Task<UserInformation> {
        let headers = [
            "Authorization" : "Bearer \(token.token)",
            "Accept-Language": "vi"
        ]
        return fetchRequest(ROUTE.profile, headers: headers)
            .continueOnSuccessWithTask(continuation: model.parseUserInformation)
    }
}
