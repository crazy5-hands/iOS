//
//  DateUtils.swift
//  hands
//
//  Created by 山浦功 on 2018/05/04.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation

class DateUtils {
    
    func dateFromString(stringDate: String, format: String) -> NSDate {
        let formatter = DateFormatter()
        formatter.dateFormat = "yMdkHms"
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.date(from: stringDate)! as NSDate
    }
    
    func stringFromDate(date: NSDate) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMdkHms", options: 0, locale: Locale(identifier: "ja_JP"))
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: date as Date) // 2018/8/13 16:29
    }
}
