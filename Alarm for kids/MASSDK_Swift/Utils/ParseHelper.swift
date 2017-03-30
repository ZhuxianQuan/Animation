//
//  ParseHelper.swift
//  MASSDK_Swift
//
//  Created by Big Shark on 30/03/2017.
//  Copyright © 2017 MasterApp. All rights reserved.
//

import Foundation

class ParseHelper {
    
    static func parseEvent(_ object: [String: AnyObject]) -> EventModel{
        let event = EventModel()
        event.eventTime = object[EventModel.TABLE_COLUMN_TIME] as! Int64
        event.eventContent = object[EventModel.TABLE_COLUMN_CONTENT] as! String
        event.eventType = object[EventModel.TABLE_COLUMN_TYPE] as! Int
        
        return event
    }
}
