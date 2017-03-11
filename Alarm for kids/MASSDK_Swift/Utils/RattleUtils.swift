
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
        return (-1 , -1)
    }
    
    static func rattlesAreImpacted(rattle1: RattleModel, rattle2: RattleModel) -> (Bool) {
        if pow((rattle1.rattle_rect.x - rattle2.rattle_rect.x),2) + pow((rattle1.rattle_rect.y - rattle2.rattle_rect.y), 2) < (rattle1.rattle_rect.radius + rattle2.rattle_rect.radius) * 0.8
        {
            return true
        }
        return false
    }
    
    static func rattleImpactedWall(rattle: RattleModel, corner: Int) -> RattleModel {
        if corner == Constants.CORNER_LEFT || corner == Constants.CORNER_RIGHT
        {
            rattle.rattle_velocity.vx = -rattle.rattle_velocity.vx
        }
        else if corner == Constants.CORNER_TOP || corner == Constants.CORNER_BOTTOM{           rattle.rattle_velocity.vy = -rattle.rattle_velocity.vy
        }
        return rattle
    }
    
    static func getWallImpactedItems(_ rattles: [RattleModel], bounds: RattleBounds) -> [RattleModel]{
        var resultRattles = rattles
        for index in 0..<resultRattles.count{
            let corner = getCorner(rattleRect: resultRattles[index].rattle_rect, bounds: bounds)
            if corner > 0{
                resultRattles[index] = rattleImpactedWall(rattle: resultRattles[index], corner: corner)
            }
        }
        return rattles
    }
    
    static func getCorner(rattleRect: RattleRect, bounds: RattleBounds) -> Int{
        if rattleRect.x - rattleRect.radius <= 0{
            return Constants.CORNER_LEFT
        }
        else if rattleRect.x + rattleRect.radius >= bounds.width{
            return Constants.CORNER_RIGHT
        }
        else if rattleRect.y - rattleRect.radius <= 0{
            return Constants.CORNER_TOP
        }
        else if rattleRect.y + rattleRect.radius >= bounds.height{
            return Constants.CORNER_BOTTOM
        }
        
        return -1
    }
    
    static func getNewRattles(_ rattles: [RattleModel], bounds: RattleBounds) -> [RattleModel] {
        var resultRattles: [RattleModel] = rattles
        let impactedRattleTags = getImpactedRattles(rattles)
        if impactedRattleTags.0 != -1 {
            let impactedIndex1 = getRattleFromTag(rattles, tag: impactedRattleTags.0)
            let impactedIndex2 = getRattleFromTag(rattles, tag: impactedRattleTags.1)
            let newImpactedRattles = getImpactedRattles(rattle1: rattles[impactedIndex1], rattle2: rattles[impactedIndex2])
            resultRattles[impactedIndex1] = newImpactedRattles.0
            resultRattles[impactedIndex2] = newImpactedRattles.1
        }
        resultRattles = getWallImpactedItems(resultRattles, bounds: bounds)
        for index in 0..<resultRattles.count{
            resultRattles[index] = getStandardNewRattle(rattle: resultRattles[index])
        }
        
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
        let distance = pow(pow((rattle1.rattle_rect.x - rattle2.rattle_rect.x), 2) + pow((rattle1.rattle_rect.y - rattle2.rattle_rect.y), 2), 0.5)
        rattle1.rattle_velocity.vx = (rattle2.rattle_rect.x - rattle1.rattle_rect.x) / distance * RattleModel.RATTLE_MAX_SPEED
        rattle1.rattle_velocity.vy = (rattle2.rattle_rect.y - rattle1.rattle_rect.y) / distance * RattleModel.RATTLE_MAX_SPEED
        rattle2.rattle_velocity.vx = -(rattle2.rattle_rect.x - rattle1.rattle_rect.x) / distance * RattleModel.RATTLE_MAX_SPEED
        rattle2.rattle_velocity.vx = -(rattle2.rattle_rect.x - rattle1.rattle_rect.y) / distance * RattleModel.RATTLE_MAX_SPEED
        
        return (rattle1, rattle2)
    }
    
    static func getRattleFromTag(_ rattles : [RattleModel], tag: Int) -> Int{

        for index in 0..<rattles.count {
            if rattles[index].rattle_tag == tag
            {
                return index
            }
        }
        return -1
    }
    
    
}
