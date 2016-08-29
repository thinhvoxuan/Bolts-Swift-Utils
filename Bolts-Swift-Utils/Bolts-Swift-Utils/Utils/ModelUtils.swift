//
//  ModelUtils.swift
//  Bolts-Swift-Utils
//
//  Created by thinhvoxuan on 8/26/16.
//  Copyright © 2016 Thinhvoxuan. All rights reserved.
//

import UIKit
import BoltsSwift

class ModelUtils {
    static let shareInstance = ModelUtils()

    func parseWeatherModel(anyObject: AnyObject) -> Task<Weather> {
        let task = TaskCompletionSource<Weather>()
        let weatherInfor = Weather(dictionary: (anyObject as? NSDictionary)!)
        task.set(result: weatherInfor)
        return task.task
    }

    func parseConfigModel(anyObject: AnyObject) -> Task<ConfigApp> {
        let task = TaskCompletionSource<ConfigApp>()
        let config = ConfigApp(dictionary: (anyObject as? NSDictionary)!)
        task.set(result: config)
        return task.task
    }

    func parseTokenModel(anyObject: AnyObject) -> Task<UserToken> {
        let task = TaskCompletionSource<UserToken>()
        let token = UserToken(dictionary: (anyObject as? NSDictionary)!)
        task.set(result: token)
        return task.task
    }

    func parseUserInformation(anyObject: AnyObject) -> Task<UserInformation> {
        let task = TaskCompletionSource<UserInformation>()
        let userInfor = UserInformation(dictionary: (anyObject as? NSDictionary)!)
        task.set(result: userInfor)
        return task.task
    }
}
