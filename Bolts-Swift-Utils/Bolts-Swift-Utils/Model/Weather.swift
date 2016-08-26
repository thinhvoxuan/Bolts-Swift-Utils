//
//  Weather.swift
//  Bolts-Swift-Utils
//
//  Created by thinhvoxuan on 8/26/16.
//  Copyright © 2016 Thinhvoxuan. All rights reserved.
//

import UIKit
import EVReflection

class Weather: EVObject {
    var location: String = ""
    var threeDayForecast: [DailyRecord] = [DailyRecord]()
    override func propertyMapping() -> [(String?, String?)] {
        return [("threeDayForecast", "three_day_forecast")]
    }
}

class DailyRecord: EVObject {
    var conditions: String = ""
    var day: String = ""
    var temperature: Int = 0
}
