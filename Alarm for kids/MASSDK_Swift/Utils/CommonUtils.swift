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

}
