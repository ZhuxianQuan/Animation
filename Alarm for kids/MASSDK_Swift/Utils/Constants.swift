//
//  Constants.swift
//  MASSDK_Swift
//
//  Created by Big Shark on 10/02/2017.
//  Copyright © 2017 MasterApp. All rights reserved.
//

import Foundation
import UIKit

class Constants {
    
    static let ORDER_PLAY_AUDIO             = "play audio"
    static let ORDER_PAUSE_AUDIO            = "pause audio"
    static let ORDER_PAUSE_AUDIO_BYTIMER    = "pause audio by timer"
    
    static let KEY_AUDIO_FILENAME           = "audio file name"
    
    
    static let NOISE_STATUS_SLEEP           = 1
    static let NOISE_STATUS_CRYING          = 2
    
    static let BABY_MODE_ON                 = 1
    static let BABY_MODE_OFF                = 2
    
    static let BABY_SOUND_TIMER_ON          = 1
    static let BABY_SOUND_TIMER_OFF         = 2
    
    static let BABY_SOUND_PLAYING           = 1
    static let BABY_SOUND_UNPLAYING         = 2
    
    static let BABY_RADIO_STAR              = 1
    static let BABY_RADIO_CLOUD             = 2
    
    static let BABY_CRYING_SLEEPING         = 1
    static let BABY_CRYING_CRYING           = 2
    static let BABY_CRYING_MORECRYING       = 3
    
    
    static let COLOR_BUTTON_SELECTED        = UIColor(colorLiteralRed: 89.0 / 255.0, green: 122.0/255.0, blue: 160.0 / 255.0 , alpha: 1)
    static let COLOR_BUTTON_UNSELECTED      = UIColor(colorLiteralRed: 178.0 / 255.0, green: 204.0/255.0, blue: 229.0 / 255.0 , alpha: 1)
    
    
    static let COLOR_EVENT_PALY             = UIColor(colorLiteralRed: 72.0 / 255.0, green: 142.0 / 255.0 , blue: 42.0 / 255.0, alpha: 1)
    static let COLOR_EVENT_STOP             = UIColor(colorLiteralRed: 173.0 / 255.0, green: 37.0 / 255.0 , blue: 36.0 / 255.0, alpha: 1)
    
    static let CORNER_LEFT                  = 1
    static let CORNER_RIGHT                 = 2
    static let CORNER_TOP                   = 4
    static let CORNER_BOTTOM                = 8
    
    
    static let BABY_RADIO_SOUND             = 2
    static let BABY_RADIO_MUSIC             = 1
    static let BABY_RADIO_ALL               = 0
    
    static let ANIMAL_SLEEP                 = 1
    static let ANIMAL_AWAKE                 = 2
    
    static let AUDIO_SOURCE_ASSET           = 1
    static let AUDIO_SOURCE_DOWNLOAD        = 2
    
    static let DB_NAME                      = "MAS_DB"
    
    static let ORDER_TIMER_START            = "timer start"
    static let ORDER_TIMER_STOP             = "timer stop"
    static let ORDER_REMAINTIME_CHANGED     = "remain time changed"
    
    static let APP_DID_ENTER_FOREGROUND     = "app did enter foreground"
    
    
}
