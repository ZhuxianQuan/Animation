//
//  FMDBManager+Data.swift
//  MASSDK_Swift
//
//  Created by Big Shark on 30/03/2017.
//  Copyright © 2017 MasterApp. All rights reserved.
//

import Foundation


class GetDataFromFMDB {
    static func getEvents() -> [EventModel]{
        var events: [EventModel] = []
        let eventObjects = fmdbManager.getDataFromFMDB(with: "select * from \(EventModel.localTableName)", tableObject: EventModel.localTableObject)
        for object in eventObjects {
            let eventObject = object as! [String: AnyObject]
            events.append(ParseHelper.parseEvent(eventObject))
        }
        return events
    }
    
}

class SetDataToFMDB {
    
    static func saveEvent(_ event: EventModel){
        fmdbManager.executeQuery(fmdbManager.insertOrUpdateRecordQuery(tableObject: EventModel.localTableObject, tableName: EventModel.localTableName, tableData: event.getEventObject(), primaryKey: EventModel.localTablePrimaryKey))      
    
    }
    
    static func clearEvent() {
        fmdbManager.emptyTables()
    }
}
