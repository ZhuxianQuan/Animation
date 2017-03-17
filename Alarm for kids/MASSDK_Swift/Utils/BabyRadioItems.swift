//
//  BabyRadioItems.swift
//  MASSDK_Swift
//
//  Created by Big Shark on 15/03/2017.
//  Copyright © 2017 MasterApp. All rights reserved.
//

import Foundation


class BabyRadioItems{
    
    static func getAllItems() -> [FloatingItemModel]{
        
        var result : [FloatingItemModel] = []
        
        var item = FloatingItemModel()
        item.item_title = "Washing machine"
        item.item_type = Constants.BABY_RADIO_SOUND
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Vacuum cleaner"
        item.item_type = Constants.BABY_RADIO_SOUND
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Jukebox"
        item.item_type = Constants.BABY_RADIO_MUSIC
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Chimes"
        item.item_type = Constants.BABY_RADIO_MUSIC
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Mom's heartbeat"
        item.item_type = Constants.BABY_RADIO_SOUND
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Fan"
        item.item_type = Constants.BABY_RADIO_SOUND
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Forest"
        item.item_type = Constants.BABY_RADIO_SOUND
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Cat purr"
        item.item_type = Constants.BABY_RADIO_SOUND
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Violin"
        item.item_type = Constants.BABY_RADIO_MUSIC
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Wind"
        item.item_type = Constants.BABY_RADIO_SOUND
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Air conditioning"
        item.item_type = Constants.BABY_RADIO_SOUND
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Piano"
        item.item_type = Constants.BABY_RADIO_MUSIC
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Sax"
        item.item_type = Constants.BABY_RADIO_MUSIC
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Dishwasher"
        item.item_type = Constants.BABY_RADIO_SOUND
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Lorry"
        item.item_type = Constants.BABY_RADIO_SOUND
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Flute"
        item.item_type = Constants.BABY_RADIO_MUSIC
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "White_noise"
        item.item_type = Constants.BABY_RADIO_SOUND
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Rain"
        item.item_type = Constants.BABY_RADIO_SOUND
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Xylophone"
        item.item_type = Constants.BABY_RADIO_MUSIC
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Harp"
        item.item_type = Constants.BABY_RADIO_MUSIC
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Cars"
        item.item_type = Constants.BABY_RADIO_SOUND
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Grandfather clock"
        item.item_type = Constants.BABY_RADIO_SOUND
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Waterfall"
        item.item_type = Constants.BABY_RADIO_SOUND
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Train"
        item.item_type = Constants.BABY_RADIO_SOUND
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Shower"
        item.item_type = Constants.BABY_RADIO_SOUND
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Dolphin"
        item.item_type = Constants.BABY_RADIO_SOUND
        
        result.append(item)
        item = FloatingItemModel()
        item.item_title = "Guitar"
        item.item_type = Constants.BABY_RADIO_MUSIC
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Lyre"
        item.item_type = Constants.BABY_RADIO_MUSIC
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Stream"
        item.item_type = Constants.BABY_RADIO_SOUND
        
        result.append(item)
        
        item = FloatingItemModel()
        item.item_title = "Fire"
        item.item_type = Constants.BABY_RADIO_SOUND
        
        result.append(item)
        
        return result
    }
    
    static func getSounds() -> [FloatingItemModel]{
        var result : [FloatingItemModel] = []
        for item in getAllItems(){
            if item.item_type == Constants.BABY_RADIO_SOUND{
                result.append(item)
            }
        }
        
        
        return result
    }
    
    static func getMusic() -> [FloatingItemModel]{
        
        var result : [FloatingItemModel] = []
        for item in getAllItems(){
            if item.item_type == Constants.BABY_RADIO_MUSIC{
                result.append(item)
            }
        }
        
        
        return result
    }
    
    
    
}
