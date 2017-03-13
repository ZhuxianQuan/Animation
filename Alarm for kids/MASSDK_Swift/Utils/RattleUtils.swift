
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
    
    
    
    static func initRattles(_ images: [UIImage], frameWidth : CGFloat, bounds: RattleBounds) -> [RattleModel] {
        
        var rattles : [RattleModel] = []
        var index = 0
        for image in images {
            let rattle = RattleModel()
            rattle.rattle_image = image
            rattle.rattle_tag = index
            var radius : CGFloat!
            let imageSize = image.size
            var imageWidth :CGFloat!
            if imageSize.width > imageSize.height{
                imageWidth = imageSize.width
            }
            else{
                imageWidth = imageSize.height
            }
            
            if UIScreen.main.bounds.size.width > 350{
                radius = imageWidth / frameWidth / 2
            }
            else{
                radius = imageWidth / frameWidth / 2.5
            }
            
            rattle.rattle_rect = getInitRattleRect(radius: radius, bounds: bounds)
            rattle.rattle_velocity = getInitRattleVelocity()
            rattles.append(rattle)
            index += 1
            
        }
        
        return rattles
        
    }
    
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
        if pow((rattle1.rattle_rect.x - rattle2.rattle_rect.x),2) + pow((rattle1.rattle_rect.y - rattle2.rattle_rect.y), 2) < pow((rattle1.rattle_rect.radius + rattle2.rattle_rect.radius) * 0.8, 2)
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
        else if corner == Constants.CORNER_TOP || corner == Constants.CORNER_BOTTOM{
            rattle.rattle_velocity.vy = -rattle.rattle_velocity.vy
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
        return resultRattles
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
        
        return 0
    }
    
    static func getNewRattles(_ rattles: [RattleModel], bounds: RattleBounds) -> [RattleModel] {
        var resultRattles: [RattleModel] = rattles
        //get impacting rattles
        let impactedRattleTags = getImpactedRattles(rattles)
        
        if impactedRattleTags.0 != -1 {
            //if exists impacting rattles, process it

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
        if velocity != 0{
            rattle.rattle_rect.x += rattle.rattle_velocity.vx * RattleModel.RATTLE_INTERVAL + 0.5 * (RattleModel.RATTLE_ACCELERATION) * rattle.rattle_velocity.vx / velocity * pow(RattleModel.RATTLE_INTERVAL, 2)
            rattle.rattle_rect.y += rattle.rattle_velocity.vy * RattleModel.RATTLE_INTERVAL + 0.5 * (RattleModel.RATTLE_ACCELERATION) * rattle.rattle_velocity.vy / velocity * pow(RattleModel.RATTLE_INTERVAL, 2)
        }
        if rattle.rattle_velocity.angle + RattleModel.RATTLE_ANGULARACCELERATION * RattleModel.RATTLE_INTERVAL <= 0{
            rattle.rattle_velocity.angle = 0
        }
        else{
            rattle.rattle_velocity.angle += RattleModel.RATTLE_ANGULARACCELERATION * RattleModel.RATTLE_INTERVAL
            rattle.rattle_rect.rotation += rattle.rattle_velocity.angle * RattleModel.RATTLE_INTERVAL
        }
        
        //if rattle
        
        return rattle
    }
    
    static func getImpactedRattles(rattle1 : RattleModel, rattle2: RattleModel) -> (RattleModel, RattleModel){
        let distance = pow(pow((rattle1.rattle_rect.x - rattle2.rattle_rect.x), 2) + pow((rattle1.rattle_rect.y - rattle2.rattle_rect.y), 2), 0.5)
        var angleOfVelocity1 : CGFloat!
        var angleOfVelocity2 : CGFloat!
        if rattle1.rattle_velocity.vy != 0{
            angleOfVelocity1 = atan(rattle1.rattle_velocity.vx / rattle1.rattle_velocity.vy)
        }
        else if rattle1.rattle_velocity.vx > 0{
            angleOfVelocity1 = 3.14159235359 / 2
        }
        if rattle2.rattle_velocity.vy != 0 {
            angleOfVelocity2 = atan(rattle1.rattle_velocity.vx / rattle2.rattle_velocity.vy)
        }
        else if rattle2.rattle_velocity.vx > 0{
            angleOfVelocity2 = 3.14159235359 / 2
        }
        rattle1.rattle_velocity.vx = -(rattle2.rattle_rect.x - rattle1.rattle_rect.x) / distance * RattleModel.RATTLE_MAX_SPEED
        rattle1.rattle_velocity.vy = -(rattle2.rattle_rect.y - rattle1.rattle_rect.y) / distance * RattleModel.RATTLE_MAX_SPEED
        rattle2.rattle_velocity.vx = (rattle2.rattle_rect.x - rattle1.rattle_rect.x) / distance * RattleModel.RATTLE_MAX_SPEED
        rattle2.rattle_velocity.vy = (rattle2.rattle_rect.y - rattle1.rattle_rect.y) / distance * RattleModel.RATTLE_MAX_SPEED
        
        if angleOfVelocity1 != nil{
            rattle1.rattle_velocity.angle = (atan(rattle1.rattle_velocity.vx) - angleOfVelocity1) / 3.14 * RattleModel.RATTLE_MAX_ANGULARSPEED
        }
        
        if angleOfVelocity2 != nil {
            rattle2.rattle_velocity.angle = (atan(rattle2.rattle_velocity.vx) - angleOfVelocity2) / 3.14 * RattleModel.RATTLE_MAX_ANGULARSPEED
        }
        
        
        
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
    
    static func getInitRattleRect(radius : CGFloat, bounds: RattleBounds) -> RattleRect{
        return RattleRect(x: radius + CGFloat(CommonUtils.getRandomNumber(1000)) / 1000 * (bounds.width - radius * 2), y : radius + CGFloat(CommonUtils.getRandomNumber(1000)) / 1000 * (bounds.height - radius * 2), radius: radius, rotation: CGFloat(CommonUtils.getRandomNumber(1000)) / 1000 * 6.28)
    }
    
    static func getInitRattleVelocity() -> RattleVelocity {
        return RattleVelocity(vx : CGFloat(CommonUtils.getRandomNumber(1000)) / 1000 * RattleModel.RATTLE_MAX_SPEED, vy: CGFloat(CommonUtils.getRandomNumber(5000)) / 5000 * RattleModel.RATTLE_MAX_SPEED, angle: 0)
    }
    
    
    
}
