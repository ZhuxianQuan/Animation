//
//  FMDBManager.swift
//  Langu.ag
//
//  Created by Huijing on 14/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//



import Foundation
import FMDB


class FMDBManager{

    var fileURL: URL!
    var database : FMDatabase!

    init(){

        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(Constants.DB_NAME)

        database = FMDatabase(path: fileURL.path)
        if(database == nil)
        {
            return
        }
        database.open()
        createTables()
        database.close()

    }


    func createTables()
    {

        do {

            //create categories table
            try database.executeUpdate(createTableString(tableName:EventModel.localTableName, tableObject: EventModel.localTableObject, primaryKey: EventModel.localTablePrimaryKey), values: nil)
            
        } catch {
            print("failed: \(error.localizedDescription)")
        }

    }

    func emptyTables()
    {
        do{
            try database.executeUpdate("DROP TABLE " + EventModel.localTableName, values: nil)
        }
        catch{
            print("failed: \(error.localizedDescription)")
        }
    }
    
    func executeQuery(_ query : String) {
        do{
            database.open()
            try database.executeUpdate(query, values: nil)
            database.close()
        }
        catch{
            print("failed: \(error.localizedDescription)")
        }
    }

    func createTableString(tableName: String, tableObject: [String: String], primaryKey: String) -> String{
        //let tableDict  = tableObject as! NSDictionary
        //let keys = tableDict.allKeys
        var resultString = "CREATE TABLE IF NOT EXISTS " + tableName + "("
        for (key, value) in tableObject{
            if(key != primaryKey){
                resultString = resultString + key + " " + value + " ,"
            }
            else{
                resultString = resultString + key + " " + value + " PRIMARY KEY ,"
            }
        }

        resultString.remove(at: resultString.index(before: resultString.endIndex))
        resultString.append(")")

        NSLog("create tableString ===== \(resultString)")
        return resultString
    }

    func insertOrUpdateRecordQuery(tableObject: [String: String], tableName: String, tableData: [String: AnyObject], primaryKey: String) -> String{


        var insertString = "INSERT OR REPLACE INTO \(tableName) "
        var keysString = "("
        var valuesString = "("

        for (key,_) in tableObject{

            keysString.append("\(key),")
            valuesString += " '"
            if(key == primaryKey){
                valuesString += ("(SELECT \(key) FROM \(tableName) where \(key)= \(tableData[key] as AnyObject))")
            }
            else{
                valuesString += ("\(tableData[key] as AnyObject)")
            }
            valuesString += "' ,"

        }
        keysString.remove(at: keysString.index(before: keysString.endIndex))
        keysString.append(") values ")

        valuesString.remove(at: valuesString.index(before: valuesString.endIndex))
        valuesString.append(")")

        insertString.append(keysString)
        insertString.append(valuesString.replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")',", with: "',"))

        NSLog(insertString)

        return insertString
        
    }


    func getDataFromFMDB(with query: String, tableObject: [String: String]) -> [AnyObject]{

        var result : [AnyObject] = []
        database.open()
        do{
            let rs = try database.executeQuery(query, values: nil)

            while rs.next(){
                var resultItem : [String: AnyObject] = [:]
                NSLog("\(tableObject)")
                for item in tableObject{
                    resultItem[item.key] = getObjectFromKey(value: rs, type: item.value, key: item.key)
                }
                result.append(resultItem as AnyObject)
            }

        }catch {
            print("failed: \(error.localizedDescription)")
        }
        database.close()
        return result
    }

    func getObjectFromKey(value: FMResultSet, type: String, key: String) -> AnyObject{

        if (type.hasPrefix("VARCHAR")){
            return value.string(forColumn: key) as AnyObject
        }
        else if(type.hasPrefix("TINYINT")){
            return value.bool(forColumn: key) as AnyObject
        }
        else if(type.hasPrefix("BIGINT")){
            return value.longLongInt(forColumn: key) as AnyObject
        }
        else if(type.hasPrefix("INT"))
        {
            return Int(value.string(forColumn: key)) as AnyObject
        }
        else if(type.hasPrefix("DOUBLE"))
        {
            return Double(value.string(forColumn: key)) as AnyObject
        }
        return "" as AnyObject
    }

}


var fmdbManager = FMDBManager()
