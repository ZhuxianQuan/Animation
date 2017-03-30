//
//  EventModel.swift
//  MASSDK_Swift
//
//  Created by Huijing on 30/01/2017.
//  Copyright © 2017 MasterApp. All rights reserved.
//

import Foundation


class EventModel{
    var eventTime: Int64 = 0
    var eventContent = ""
    var eventType = 0
    
    static let TABLE_COLUMN_TIME = "eventtime"
    static let TABLE_COLUMN_CONTENT = "eventcontent"
    static let TABLE_COLUMN_TYPE = "eventtype"
    
    static let localTableName = "tbl_event"
    static let localTableObject = [TABLE_COLUMN_TIME : "BIGINT",
                                   TABLE_COLUMN_CONTENT: "TEXT",
                                   TABLE_COLUMN_TYPE : "INT"
                                   ]
    static let localTablePrimaryKey = ""

    static let EVENT_SOUND_START         = 1
    static let EVENT_SOUND_STOP          = 2
    /*
    static let EVENT_MONITER_START      = 3
    static let EVENT_MONITER_START      = 3*/
    
    func getEventObject() -> [String: AnyObject] {
        return [EventModel.TABLE_COLUMN_TIME : eventTime as AnyObject,
                EventModel.TABLE_COLUMN_CONTENT : eventContent as AnyObject,
                EventModel.TABLE_COLUMN_TYPE : eventType as AnyObject
        ]
    }
}
