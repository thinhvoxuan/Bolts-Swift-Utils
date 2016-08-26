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
        static let WEATHERERROR = ROUTE.ROOT + "weatherError.json"
        static let WRONGURL = ROUTE.ROOT + "NotFoundURL.json"
    }

    func fetchWeatherInformation() -> Task<Weather> {
        return fetchRequest(ROUTE.WEATHER)
            .continueOnSuccessWithTask(continuation: modelUtils.parseWeatherModel)
    }


    func fetchWeatherError() -> Task<Weather> {
        return fetchRequest(ROUTE.WEATHERERROR)
            .continueOnSuccessWithTask(continuation: modelUtils.parseWeatherModel)
    }

    func fetchWeatherErrorFromNetwork() -> Task<Weather> {
        return fetchRequest(ROUTE.WRONGURL)
            .continueOnSuccessWithTask(continuation: modelUtils.parseWeatherModel)
    }

    func fetchRequest(url: String) -> Task<AnyObject> {
        let task = TaskCompletionSource<AnyObject>()
        Alamofire.request(.GET, url).responseJSON { response in
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
