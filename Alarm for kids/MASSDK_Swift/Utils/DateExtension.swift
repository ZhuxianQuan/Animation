//
//  UTCDateTime.swift
//  FelineFitness
//
//  Created by Huijing on 08/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import Foundation


extension Date{

    func toMillis() -> NSNumber {
        return NSNumber(value:Int64(timeIntervalSince1970 * 1000))
    }

    static func fromMillis(millis: NSNumber?) -> Date? {
        return millis.map() { number in NSDate(timeIntervalSince1970: Double(number) / 1000) as Date}
    }

    static func currentTimeInMillis(_ date: Date) -> NSNumber {
        return date.toMillis()
    }


    static func toLocalMillis(globalMillis: NSNumber) -> NSNumber{
        let tz = NSTimeZone.local
        let differenceSeconds = tz.secondsFromGMT()
        return NSNumber(value: globalMillis.int64Value + differenceSeconds*1000)
    }

    static func getCurrentTimeFromGlobalMillis(millis: Int64) -> Date
    {
        return Date.fromMillis(millis: Date.toLocalMillis(globalMillis: NSNumber(value: millis)))!
    }

}



func getGlobalTime() -> Int64
{
    return Date().toMillis().int64Value
}

func getTimeFromGMTTimeMillis(time: Int64) -> Date
{
    return Date.getCurrentTimeFromGlobalMillis(millis: time)
}

func getLocalTimeString(_ time: Date) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "H:mm"
    return dateFormatter.string(from: time)
}

