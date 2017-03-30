//
//  CommonUtils.swift
//  MASSDK_Swift
//
//  Created by Big Shark on 12/03/2017.
//  Copyright © 2017 MasterApp. All rights reserved.
//

import Foundation

class CommonUtils {
    
    
    static func getRandomNumber(_ maxValue : Int) -> Int{
        return Int(arc4random_uniform(UInt32(maxValue)))
    }
    
    static func getIndex(item: FloatingItemModel, from items : [FloatingItemModel]) -> Int {
        var index = 0
        for subItem in items {
            if item.item_title == subItem.item_title{
                return index
            }
            index += 1
        }
        return -1
    }    
    

}
