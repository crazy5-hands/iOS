//
//  extensions.swift
//  hands
//
//  Created by 山浦功 on 2017/12/27.
//  Copyright © 2017年 KoYamaura. All rights reserved.
//

import Foundation


extension DateFormatter {
    
    enum Template: String {
        case date = "yMd"     // 2017/1/1
        case time = "Hm"     // 12:39
        case full = "yMdkHm" // 2017/1/1 12:39
        case onlyHour = "k"   // 17時
        case era = "GG"       // "西暦" (default) or "平成" (本体設定で和暦を指定している場合)
        //        case weekDay = "EEEE" // 日曜日
    }
    
    func setTemplate(_ template: Template) {
        // optionsは拡張のためにあるが使用されていない引数
        // localeは省略できないがほとんどの場合currentを指定する
        dateFormat = DateFormatter.dateFormat(fromTemplate: template.rawValue, options: 0, locale: .current)
    }
}

class DateUtils {
    class func dateFromString(string: String) -> NSDate {
        let formatter: DateFormatter = DateFormatter()
        formatter.setTemplate(.full)
        return formatter.date(from: string)! as NSDate
    }
    
    class func stringFromDate(date: NSDate) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.setTemplate(.full)
        return formatter.string(from: date as Date)
    }
}
