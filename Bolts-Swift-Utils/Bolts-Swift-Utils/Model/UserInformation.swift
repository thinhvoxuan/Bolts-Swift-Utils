//
//  UserInformation.swift
//  Bolts-Swift-Utils
//
//  Created by thinhvoxuan on 8/29/16.
//  Copyright © 2016 Thinhvoxuan. All rights reserved.
//

import UIKit
import EVReflection

class UserInformation: EVObject {
    var message: String = ""
    var code: Int = 200
    var name: String = ""
    var email: String = ""
    var birthday: String = "--"
    var phone: String = "--"
    var city: String = "--"
    var points: String = ""
    var avatar: String = ""
    var qrCodeUrl: String = ""
    var barcode: String = ""
    var membershipText: String = ""
    override func propertyMapping() -> [(String?, String?)] {
        return [
            ("membershipText", "membership_text"),
            ("code", "status_code")
        ]
    }

    func getBarCodeFormatted() -> String {
        if self.barcode.characters.count == 9 {
            let str = self.barcode
            let first = str.substringWithRange(str.startIndex ..< str.startIndex.advancedBy(3))
            let second = str.substringWithRange(str.startIndex.advancedBy(3) ..< str.startIndex.advancedBy(5))
            let third = str.substringWithRange(str.startIndex.advancedBy(5) ..< str.startIndex.advancedBy(9))
            let showMessage = "\(first) \(second) \(third)"
            return showMessage
        }
        return ""
    }
}
