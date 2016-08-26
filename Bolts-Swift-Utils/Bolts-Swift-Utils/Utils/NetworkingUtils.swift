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

class NetworkingUtils: NetwokingBase {

    static let shareInstance = NetworkingUtils()
    let modelUtils = ModelUtils.shareInstance

    struct ROUTE {
        static let ROOT = "https://raw.githubusercontent.com/voxuanthinh/Bolts-Swift-Utils/master/Server/"
        static let Weather = ROUTE.ROOT + "weather.json"
        static let WeatherError = ROUTE.ROOT + "weatherError.json"
        static let WrongUrl = ROUTE.ROOT + "NotFoundURL.json"
        static let Config = ROUTE.ROOT + "config.json"
    }

    func fetchWeatherInformation() -> Task<Weather> {
        return self.fetchRequest(ROUTE.Weather)
            .continueOnSuccessWithTask(continuation: modelUtils.parseWeatherModel)
    }


    func fetchWeatherError() -> Task<Weather> {
        return fetchRequest(ROUTE.WeatherError)
            .continueOnSuccessWithTask(continuation: modelUtils.parseWeatherModel)
    }

    func fetchWeatherErrorFromNetwork() -> Task<Weather> {
        return fetchRequest(ROUTE.WrongUrl)
            .continueOnSuccessWithTask(continuation: modelUtils.parseWeatherModel)
    }


    func fetchConfig() -> Task<Config> {
        return fetchRequest(ROUTE.Config)
            .continueOnSuccessWithTask(continuation: modelUtils.parseConfigModel)
    }

}
