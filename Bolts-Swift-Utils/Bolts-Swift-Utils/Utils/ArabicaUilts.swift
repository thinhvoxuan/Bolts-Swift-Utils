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
        static let ROOT = "http://xxxxxx/api"
        static let config = ROUTE.ROOT + "/config"
        static let signup = ROUTE.ROOT + "/config"
    }

    func fetchConfig() -> Task<Config> {
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
            let nsDateObject = TransformUtils.parseDate(birthdayValue, format: "MM/dd/yyyy")
            let stringDate = TransformUtils.formatDate(nsDateObject, format: "yyyy/MM/dd")
            facebookInformation["birthday"] = stringDate
        }
        facebookInformation["avatar"] = "https://graph.facebook.com/\(fbResponse.accessToken.userID)/picture?type=large&width=200&height=200"
        return facebookInformation
    }

    func signupWithFacebook(fbResponse: FacebookResponse) -> Task<UserToken> {
        let postData = buildSignupData(fbResponse)
        return postRequest(ROUTE.signup, params: postData)
            .continueOnSuccessWithTask(continuation: model.parseTokenModel)
    }
}
