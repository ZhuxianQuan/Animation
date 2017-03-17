//
//  FloatingItemModel.swift
//  MASSDK_Swift
//
//  Created by Big Shark on 14/03/2017.
//  Copyright © 2017 MasterApp. All rights reserved.
//

import Foundation
import UIKit

class FloatingItemModel {
    
    var item_title = ""
    var item_type = 0
    
    func getImageName() -> String{
        return "image__" + item_title.lowercased().replacingOccurrences(of: " ", with: "_") + "_" + getTypeString(item_type)
    }
    
    func getTypeString(_ type: Int) -> String
    {
        switch type {
        case Constants.BABY_RADIO_MUSIC:
            return "star"
        case Constants.BABY_RADIO_SOUND:
            return "cloud"
        default:
            return ""
        }
    }
    
    func getImage() -> UIImage{
        return UIImage(named: getImageName())!
    }
}
