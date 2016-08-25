//
//  FacebookUtils.swift
//  Bolts-Swift-Utils
//
//  Created by thinhvoxuan on 8/25/16.
//  Copyright © 2016 Thinhvoxuan. All rights reserved.
//

import UIKit
import BoltsSwift
import FBSDKLoginKit

struct FacebookResponse {
    var accessToken: FBSDKAccessToken
    var me: AnyObject
}

class FacebookUtils {
    static let sharedInstance = FacebookUtils()
    
    func loginAndFetchProfile(fromViewController: UIViewController) -> Task<FacebookResponse> {
        return openLoginScreen(fromViewController).continueOnSuccessWithTask(continuation: self.fetchUserProfileBF)
    }
    
    func openLoginScreen(fromViewController: UIViewController) -> Task<FBSDKAccessToken> {
        let task = TaskCompletionSource<FBSDKAccessToken>()
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()// need to logout first to clear last fb cached session
        
        loginManager.logInWithReadPermissions(["public_profile", "email", "user_friends", "user_birthday"], fromViewController: fromViewController) { (loginResult, error) in
            if (error != nil) {
                task.set(error: error)
            } else if (loginResult.isCancelled) {
                task.set(error: NSError(domain: "Facebook", code: 301, userInfo: [NSLocalizedDescriptionKey:"Cancel Facebook"]))
            } else {
                task.set(result: loginResult.token)
            }
        }
        return task.task;
    }
    
    
    func fetchUserProfileBF(token: FBSDKAccessToken) -> Task<FacebookResponse> {
        let task = TaskCompletionSource<FacebookResponse>()
        let graphRequest = FBSDKGraphRequest(graphPath: "me?fields=id,name,gender,email,birthday", parameters: nil)
        graphRequest.startWithCompletionHandler({ (requestconnection, bodyResult, error) in
            if error != nil {
                task.set(error: error)
            }else{
                task.set(result: FacebookResponse(accessToken: token, me: bodyResult))
                
            }
        })
        return task.task
    }
}
