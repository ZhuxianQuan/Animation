
//
//  RattleUtils.swift
//  MASSDK_Swift
//
//  Created by Big Shark on 08/03/2017.
//  Copyright © 2017 MasterApp. All rights reserved.
//

import Foundation
import UIKit

class RattleUtils{
    
    
    
    static func getImpactedRattles(_ rattles: [RattleModel]) -> (Int, Int){
        var otherRattles : [RattleModel] = rattles

        for rattle in rattles{
            otherRattles.remove(at: 0)
            for otherRattle in otherRattles{
                let impactResult = rattlesAreImpacted(rattle1: rattle, rattle2: otherRattle)
                if impactResult {
                    return (rattle.rattle_tag, otherRattle.rattle_tag)
                }
            }
        }
        return (0 , 0)
    }
    
    static func rattlesAreImpacted(rattle1: RattleModel, rattle2: RattleModel) -> (Bool) {
        if pow((rattle1.rattle_rect.x - rattle2.rattle_rect.x),2) + pow((rattle1.rattle_rect.y - rattle2.rattle_rect.y), 2) < (rattle1.rattle_rect.radius + rattle2.rattle_rect.radius) * 0.8
        {
            return true
        }
        return false
    }
    
    static func rattleImpactedWall(rattle: RattleModel) -> RattleModel {
    
       
        return rattle
    }
    
    static func getNewRattle(_ rattles: [RattleModel]) -> [RattleModel] {
        var resultRattles: [RattleModel] = []
        
        return resultRattles
    }
    
    static func getStandardNewRattle(rattle: RattleModel) -> RattleModel {
        
        let velocity = pow((rattle.rattle_velocity.vx * rattle.rattle_velocity.vx + rattle.rattle_velocity.vy * rattle.rattle_velocity.vy), 0.5)
        if velocity + RattleModel.RATTLE_ACCELERATION * RattleModel.RATTLE_INTERVAL <= 0{
            rattle.rattle_velocity.vx = 0
            rattle.rattle_velocity.vy = 0
        }
        else{
            rattle.rattle_velocity.vx += (RattleModel.RATTLE_ACCELERATION * RattleModel.RATTLE_INTERVAL) * rattle.rattle_velocity.vx / velocity
            rattle.rattle_velocity.vy += RattleModel.RATTLE_ACCELERATION * RattleModel.RATTLE_INTERVAL * rattle.rattle_velocity.vy / velocity
        }
        rattle.rattle_rect.x += rattle.rattle_velocity.vx * RattleModel.RATTLE_INTERVAL + 0.5 * (RattleModel.RATTLE_ACCELERATION) * rattle.rattle_velocity.vx / velocity * pow(RattleModel.RATTLE_INTERVAL, 2)
        rattle.rattle_rect.y += rattle.rattle_velocity.vy * RattleModel.RATTLE_INTERVAL + 0.5 * (RattleModel.RATTLE_ACCELERATION) * rattle.rattle_velocity.vy / velocity * pow(RattleModel.RATTLE_INTERVAL, 2)
        //if rattle
        
        return rattle
    }
    
    static func getImpactedRattles(rattle1 : RattleModel, rattle2: RattleModel) -> (RattleModel, RattleModel){
        
        return (rattle1, rattle2)
    }
    
}
