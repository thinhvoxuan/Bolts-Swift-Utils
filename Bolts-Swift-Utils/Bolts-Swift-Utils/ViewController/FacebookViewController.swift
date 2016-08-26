//
//  FacebookViewController.swift
//  Bolts-Swift-Utils
//
//  Created by thinhvoxuan on 8/25/16.
//  Copyright © 2016 Thinhvoxuan. All rights reserved.
//

import UIKit

class FacebookViewController: UIViewController {
    @IBAction func loginAction(sender: UIButton) {
        FacebookUtils.sharedInstance.loginAndFetchProfile(self).continueWith {
            task in
            if task.error != nil {
                if let error = task.error as NSError? {
                    print(error.localizedDescription)
                    return
                }
            } else {
                print("\(task.result?.accessToken)")
                print("\(task.result?.meInfor)")
            }
        }
    }
}
