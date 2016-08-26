//
//  UserConfig.swift
//  Bolts-Swift-Utils
//
//  Created by thinhvoxuan on 8/26/16.
//  Copyright © 2016 Thinhvoxuan. All rights reserved.
//
import SwiftyUserDefaults

extension DefaultsKeys {
    static let userfbID = DefaultsKey<String?>("userfbID")
    static let userfbToken = DefaultsKey<String?>("userfbToken")
    static let isAlreadyStartApp = DefaultsKey<Bool>("isAlreadyStartApp")
    static let tokenAuthentication = DefaultsKey<String?>("tokenAuthentication")
}
