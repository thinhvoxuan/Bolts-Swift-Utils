//
//  NetwokingBase.swift
//  Bolts-Swift-Utils
//
//  Created by thinhvoxuan on 8/26/16.
//  Copyright © 2016 Thinhvoxuan. All rights reserved.
//

import UIKit
import BoltsSwift
import Alamofire

class NetwokingBase: NSObject {
    func fetchRequest(url: String, params: [String: String] = [:], headers: [String:String]=[:]) -> Task<AnyObject> {
        let task = TaskCompletionSource<AnyObject>()
        Alamofire.request(.GET, url, parameters: params, headers: headers).responseJSON { response in
            switch response.result {
            case .Success(let value):
                task.set(result: value)
            case .Failure(let error):
                task.set(error: error)
            }
        }
        return task.task
    }

    func postRequest(url: String, params: [String: String] = [:], header: [String:String]=[:]) -> Task<AnyObject> {
        let task = TaskCompletionSource<AnyObject>()
        Alamofire.request(.POST, url, parameters: params, encoding: .JSON, headers: header)
            .validate(statusCode: 200..<600)
            .responseJSON { response in
                self.parseResult(task, response: response)
            }
        return task.task
    }

    func parseResult(task: TaskCompletionSource<AnyObject>, response: Response<AnyObject, NSError>) {
        switch response.result {
        case .Success(let value):
            if let status_code = value["status_code"] as? Int {
                if status_code != 200 {
                    var message = "ERROR"
                    if let messageValue = value["message"] as? String {
                        message = messageValue
                    }
                    if let errorsArray = value["errors"] as? [[String]] {
                        message = errorsArray[0][0]
                    }
                    task.set(error: NSError(domain: "requestFail", code: -1, userInfo: [NSLocalizedDescriptionKey:message]))
                    return
                }
            }
            task.set(result: value)
            break
        case .Failure(let error):
            task.set(result: error)
        }
    }
}
