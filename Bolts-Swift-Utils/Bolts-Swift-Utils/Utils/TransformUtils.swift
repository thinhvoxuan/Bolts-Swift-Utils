//
//  TransformUtils.swift
//  Bolts-Swift-Utils
//
//  Created by thinhvoxuan on 8/26/16.
//  Copyright © 2016 Thinhvoxuan. All rights reserved.
//

import UIKit

class TransformUtils {

    static func changeFormatDate(fromDateString: String, fromFormat: String = "yyyy-MM-dd", toFormat: String = "yyyy-MM-dd") -> String {
        let dateObject = self.parseDate(fromDateString, format: fromFormat)
        if dateObject != nil {
            return self.formatDate(dateObject!, format: toFormat)
        }
        return ""
    }

    static func parseDate(dateStr: String, format: String="yyyy-MM-dd") -> NSDate? {
        let dateFmt = NSDateFormatter()
        dateFmt.timeZone = NSTimeZone.defaultTimeZone()
        dateFmt.dateFormat = format
        return dateFmt.dateFromString(dateStr)
    }

    static func formatDate(date: NSDate, format: String="yyyy-MM-dd") -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.dateFormat = format
        return dateFormatter.stringFromDate(date)
    }
}
