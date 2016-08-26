//
//  NetworkViewController.swift
//  Bolts-Swift-Utils
//
//  Created by thinhvoxuan on 8/26/16.
//  Copyright © 2016 Thinhvoxuan. All rights reserved.
//

import UIKit

class NetworkViewController: UIViewController {

    let network = NetworkingUtils.shareInstance
    @IBAction func actionLoadSuccess(sender: UIButton) {
        network.fetchWeatherInformation().continueWith { task in
            self.labelResult.text = task.result?.toJsonString()
        }
    }
    @IBAction func actionLoadFail(sender: UIButton) {
        network.fetchWeatherErrorFromNetwork().continueWith { task in
            if let taskError = task.error as? NSError {
                self.labelResult.text = taskError.localizedDescription
                return
            }
            self.labelResult.text = task.result?.toJsonString()
        }
    }
    @IBOutlet weak var labelResult: UILabel!
}
