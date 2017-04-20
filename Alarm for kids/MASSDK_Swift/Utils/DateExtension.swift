//
//  UTCDateTime.swift
//  FelineFitness
//
//  Created by Huijing on 08/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import Foundation

typealias MyTime = (hour: Int, minute: Int, second: Int)

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
        return NSNumber(value: globalMillis.int64Value + Int64(differenceSeconds*1000))
    }

    static func getCurrentTimeFromGlobalMillis(millis: Int64) -> Date
    {
        return Date.fromMillis(millis: Date.toLocalMillis(globalMillis: NSNumber(value: millis)))!
    }
    
}



func getGlobalTime() -> Int64
{
    let tz = NSTimeZone.local
    let differenceSeconds = tz.secondsFromGMT()
    return Date().toMillis().int64Value - Int64(differenceSeconds * 1000)
}

func getTimeFromGMTTimeMillis(time: Int64) -> Date
{
    return Date.getCurrentTimeFromGlobalMillis(millis: time)
}

func getLocalTimeString(_ timeStamp: Int64) -> String{
    let time = getTimeFromGMTTimeMillis(time: timeStamp)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yy, hh:mm a:"
    return dateFormatter.string(from: time)
}

func getCurrentTime() -> MyTime {
    let time = getTimeFromGMTTimeMillis(time: getGlobalTime())
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm:ss"
    let timeString = dateFormatter.string(from: time)
    let timeArray = timeString.components(separatedBy: ":")
    let hour = Int(timeArray[0])
    let minute = Int(timeArray[1])
    let second = Int(timeArray[2])
    return MyTime(hour: hour!, minute: minute!, second : second!)
    
    //var currentTime = MyTime(hour)
}

func getRemainTimeTo(_ till: MyTime) -> Int{
    let currentTime = getCurrentTime()
    if till.hour * 3600 + till.minute * 60 + till.second > currentTime.hour * 3600 + currentTime.minute * 60 + currentTime.second {
        return till.hour * 3600 + till.minute * 60 + till.second - (currentTime.hour * 3600 + currentTime.minute * 60 + currentTime.second)
    }
    else {
        return till.hour * 3600 + till.minute * 60 + till.second + 86400 - (currentTime.hour * 3600 + currentTime.minute * 60 + currentTime.second)
    }
}

func getTargetTime(_ remainTime: Int) -> MyTime {
    let currentTime = getCurrentTime()
    let targetTimeSec = currentTime.hour * 3600 + currentTime.minute * 60 + currentTime.second + remainTime
    let hours = Int(targetTimeSec / 3600) % 24
    let minutes = Int(targetTimeSec / 60) % 60
    let seconds = Int(targetTimeSec % 60)
    return MyTime(hour: hours, minute: minutes, second: seconds)
    
}

func getMyTimeFrom(hour: Int, minute: Int, second: Int, m: Int) -> MyTime{
    if m == 0 {
        if hour == 12{
            return MyTime(hour: 0, minute: minute, second: second)
        }
        else{
            return MyTime(hour: hour, minute: minute, second: second)
        }
    }
    else {
        if hour == 12{
            return MyTime(hour: hour, minute: minute, second: second)
        }
        else{
            return MyTime(hour: hour + 12, minute: minute, second: second)
        }
    }
}


func getRemainTimeString(_ remainTime: Int) -> String{
    let hours = Int(remainTime / 3600)
    let minutes = Int((remainTime - 3600 * hours) / 60)
    let seconds = remainTime % 60
    return String.localizedStringWithFormat("%d:%02d:%02d", hours, minutes, seconds)
}

func setTargetTime(_ remainTime: Int) -> String{
    let targetTime = getTargetTime(remainTime)
    return String.localizedStringWithFormat("%@ %02d:%02d",NSLocalizedString("Sound stop at", comment: ""), targetTime.hour, targetTime.minute)
    
}


