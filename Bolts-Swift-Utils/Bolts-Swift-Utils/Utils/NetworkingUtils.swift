//
//  NetworkingUtils.swift
//  Bolts-Swift-Utils
//
//  Created by thinhvoxuan on 8/26/16.
//  Copyright © 2016 Thinhvoxuan. All rights reserved.
//

import UIKit
import BoltsSwift
import Alamofire

class NetworkingUtils {
    static let shareInstance = NetworkingUtils()
    let modelUtils = ModelUtils.shareInstance
    struct ROUTE {
        static let ROOT = "https://raw.githubusercontent.com/voxuanthinh/Bolts-Swift-Utils/master/Server/"
        static let WEATHER = ROUTE.ROOT + "weather.json"
    }

    func fetchWeatherInformation() -> Task<Weather> {
        return requestWeather()
            .continueOnSuccessWithTask(continuation: modelUtils.parseWeatherModel)
    }

    func requestWeather() -> Task<AnyObject> {
        let task = TaskCompletionSource<AnyObject>()
        Alamofire.request(.GET, ROUTE.WEATHER).responseJSON { response in
            switch response.result {
            case .Success(let value):
                    task.set(result: value)
            case .Failure(let error):
                task.set(error: error)
            }
        }
        return task.task
    }

}
