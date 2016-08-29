//
//  Config.swift
//  Bolts-Swift-Utils
//
//  Created by thinhvoxuan on 8/26/16.
//  Copyright © 2016 Thinhvoxuan. All rights reserved.
//

import UIKit
import EVReflection
import Version

class ConfigApp: EVObject {
    var home: MultiLanguages = MultiLanguages()
    var store: MultiLanguages = MultiLanguages()
    var android: String = "0.0.0"
    var ios: String = "0.0.0"

    func isNeedUpdate() -> Bool {
        let appVersion = UIApplication.sharedApplication().appVersion!
        let currentVersion = Version(appVersion)
        let storeVersion = Version(self.ios)
        return currentVersion < storeVersion
    }
}

class MultiLanguages: EVObject {
    var vi: String = ""
    var en: String = ""
    func langUrl(lan: String) -> String {
        switch lan {
        case "vi":
            return self.vi
        case "en":
            return self.en
        default:
            return self.vi
        }
    }
}
