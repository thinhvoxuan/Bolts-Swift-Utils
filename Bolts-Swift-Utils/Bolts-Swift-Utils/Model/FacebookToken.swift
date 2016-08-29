//
//  FacebookToken.swift
//  Bolts-Swift-Utils
//
//  Created by thinhvoxuan on 8/28/16.
//  Copyright © 2016 Thinhvoxuan. All rights reserved.
//

import UIKit
import EVReflection
import FBSDKLoginKit

class FacebookToken: EVObject {
    var appID: String = ""
    var tokenString: String = ""
    var userID: String = ""
    static func initFromFBSDKAccessToken(fb: FBSDKAccessToken) -> FacebookToken {
        let customToken = FacebookToken()
        customToken.appID = fb.appID
        customToken.tokenString = fb.tokenString
        customToken.userID = fb.userID
        return customToken
    }
}
