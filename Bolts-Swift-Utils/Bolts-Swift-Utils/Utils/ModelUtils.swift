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

    func parseConfigModel(anyObject: AnyObject) -> Task<Config> {
        let task = TaskCompletionSource<Config>()
        let config = Config(dictionary: (anyObject as? NSDictionary)!)
        task.set(result: config)
        return task.task
    }
    func parseTokenModel(anyObject: AnyObject) -> Task<UserToken> {
        let task = TaskCompletionSource<UserToken>()
        let token = UserToken(dictionary: (anyObject as? NSDictionary)!)
        task.set(result: token)
        return task.task
    }
}
