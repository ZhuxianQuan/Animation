//
//  RattleModel.swift
//  MASSDK_Swift
//
//  Created by Big Shark on 08/03/2017.
//  Copyright © 2017 MasterApp. All rights reserved.
//

import Foundation
import UIKit

typealias RattleRect = (x: CGFloat, y : CGFloat, radius: CGFloat, rotation: CGFloat)
typealias RattleVelocity = (vx: CGFloat, vy: CGFloat, angle: CGFloat)
typealias RattleBounds = (width: CGFloat, height: CGFloat)

class RattleModel{
    
    //in here rattle model means an item for sky rattles
    //speed value range is 0 to 0.5 (real velocity will be the screenWidth * velocity)
    //center position x range is 0 to 1
    //
    
    static let RATTLE_ACCELERATION : CGFloat = -1.5             // 1.2 unit per second
    static let RATTLE_MAX_SPEED : CGFloat = 2                //(0.5 unit per second)
    static let RATTLE_MAX_ANGULARSPEED : CGFloat = 31.4         //rad per square second
    static let RATTLE_ANGULARACCELERATION : CGFloat = -3.14      //rad per square second
    
    static let RATTLE_INTERVAL : CGFloat = 0.001
    
    var rattle_velocity = RattleVelocity(vx: 0, vy: 0, angle : 0)    
    var rattle_rect = RattleRect(x: 0, y : 0, radius: 0.0, rotation: 0.0)
    var rattle_tag = 0
    var rattle_image = UIImage()
    
    
}
