
//
//  RattleUtils.swift
//  MASSDK_Swift
//
//  Created by Big Shark on 08/03/2017.
//  Copyright © 2017 MasterApp. All rights reserved.
//

import Foundation
import UIKit


class RattleUtils {

    static let pi: CGFloat = 3.14159265359
    
    
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
            
            rattle.rattle_rect = getInitRattleRect(radius: radius, bounds: bounds, index: index, count: images.count)
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
        if pow((rattle1.rattle_rect.x - rattle2.rattle_rect.x),2) + pow((rattle1.rattle_rect.y - rattle2.rattle_rect.y), 2) < pow((rattle1.rattle_rect.radius + rattle2.rattle_rect.radius) * 0.95, 2)
        {
            return true
        }
        return false
    }
    
    static func rattleImpactedWall(rattle: RattleModel, corner: Int, bounds: RattleBounds) -> RattleModel {
        if corner & Constants.CORNER_LEFT == Constants.CORNER_LEFT || corner & Constants.CORNER_RIGHT == Constants.CORNER_RIGHT
        {
            if rattle.rattle_velocity.magnitude < RattleModel.RATTLE_MAX_SPEED * 0.2{
                rattle.rattle_velocity.magnitude = RattleModel.RATTLE_MAX_SPEED * 0.2
            }
            rattle.rattle_velocity.fuai = -rattle.rattle_velocity.fuai + pi
            
            if corner & Constants.CORNER_LEFT == Constants.CORNER_LEFT {
                rattle.rattle_rect.x = rattle.rattle_rect.radius
            }
            else{
                rattle.rattle_rect.x = 1 - rattle.rattle_rect.radius
            }
        }
        
        if corner & Constants.CORNER_TOP == Constants.CORNER_TOP || corner & Constants.CORNER_BOTTOM == Constants.CORNER_BOTTOM{
            if rattle.rattle_velocity.magnitude < RattleModel.RATTLE_MAX_SPEED * 0.2{
                rattle.rattle_velocity.magnitude = RattleModel.RATTLE_MAX_SPEED * 0.2
            }
            rattle.rattle_velocity.fuai = -rattle.rattle_velocity.fuai
            if corner & Constants.CORNER_TOP == Constants.CORNER_TOP {
                rattle.rattle_rect.y = rattle.rattle_rect.radius
            }
            else{
                rattle.rattle_rect.y = bounds.height - rattle.rattle_rect.radius
            }
        }
        
        return rattle
    }
    
    static func getWallImpactedItems(_ rattles: [RattleModel], bounds: RattleBounds) -> [RattleModel]{
        var resultRattles = rattles
        for index in 0..<resultRattles.count{
            let corner = getCorner(rattleRect: resultRattles[index].rattle_rect, bounds: bounds)
            if corner > 0{
                resultRattles[index] = rattleImpactedWall(rattle: resultRattles[index], corner: corner, bounds: bounds)
            }
        }
        return resultRattles
    }
    
    static func getCorner(rattleRect: RattleRect, bounds: RattleBounds) -> Int{
        var result = 0
        if rattleRect.x - rattleRect.radius <= 0{
            result += Constants.CORNER_LEFT
        }
        else if rattleRect.x + rattleRect.radius >= bounds.width{
            result += Constants.CORNER_RIGHT
        }
        else if rattleRect.y - rattleRect.radius <= 0{
            result += Constants.CORNER_TOP
        }
        else if rattleRect.y + rattleRect.radius >= bounds.height{
            result += Constants.CORNER_BOTTOM
        }
        
        return result
    }
    
    static func getNewRattles(_ rattles: [RattleModel], bounds: RattleBounds) -> ([RattleModel] , [Int]){
        var resultRattles: [RattleModel] = rattles
        var impactedTags : [Int] = []
        //get impacting rattles
        let impactedRattleTags = getImpactedRattles(rattles)
        
        if impactedRattleTags.0 != -1 {
            //if exists impacting rattles, process it

            let impactedIndex1 = getRattleFromTag(rattles, tag: impactedRattleTags.0)
            let impactedIndex2 = getRattleFromTag(rattles, tag: impactedRattleTags.1)
            let newImpactedRattles = getImpactedRattles(rattle1: rattles[impactedIndex1], rattle2: rattles[impactedIndex2])
            resultRattles[impactedIndex1] = newImpactedRattles.0
            resultRattles[impactedIndex2] = newImpactedRattles.1
            impactedTags.append(impactedIndex1)
            impactedTags.append(impactedIndex2)
        }
        resultRattles = getWallImpactedItems(resultRattles, bounds: bounds)
        for index in 0..<resultRattles.count{
            resultRattles[index] = getStandardNewRattle(rattle: resultRattles[index])
        }
        
        return (resultRattles, impactedTags)
    }
    
    static func getStandardNewRattle(rattle: RattleModel) -> RattleModel {
        
        
        if rattle.rattle_velocity.magnitude + rattle.rattle_velocity.magnitude * RattleModel.RATTLE_INTERVAL * 2 <= 0.001{
            rattle.rattle_velocity.magnitude = 0
        }
        else{
            rattle.rattle_velocity.magnitude -= rattle.rattle_velocity.magnitude * RattleModel.RATTLE_INTERVAL * 2
        }
        if rattle.rattle_velocity.magnitude != 0{
            rattle.rattle_rect.x += rattle.rattle_velocity.magnitude * cos(rattle.rattle_velocity.fuai) * RattleModel.RATTLE_INTERVAL
            rattle.rattle_rect.y += rattle.rattle_velocity.magnitude * sin(rattle.rattle_velocity.fuai) * RattleModel.RATTLE_INTERVAL
        }
        if rattle.rattle_velocity.angle - rattle.rattle_velocity.angle * 2 * RattleModel.RATTLE_INTERVAL <= 0{
            rattle.rattle_velocity.angle = 0
        }
        else{
            rattle.rattle_velocity.angle -= rattle.rattle_velocity.angle * 2 * RattleModel.RATTLE_INTERVAL
            rattle.rattle_rect.rotation += rattle.rattle_velocity.angle * RattleModel.RATTLE_INTERVAL
        }
        
        //if rattle
        
        return rattle
    }
    
    static func getImpactedRattles(rattle1 : RattleModel, rattle2: RattleModel) -> (RattleModel, RattleModel){
        let distance = pow(pow((rattle1.rattle_rect.x - rattle2.rattle_rect.x), 2) + pow((rattle1.rattle_rect.y - rattle2.rattle_rect.y), 2), 0.5)
        
        var angleOfVelocity1 : CGFloat!
        var angleOfVelocity2 : CGFloat!
        

        
        angleOfVelocity1 = rattle1.rattle_velocity.fuai
        angleOfVelocity2 = rattle2.rattle_velocity.fuai
        rattle1.rattle_velocity.magnitude = RattleModel.RATTLE_MAX_SPEED
        if rattle1.rattle_rect.x - rattle2.rattle_rect.x > 0{
            rattle1.rattle_velocity.fuai = asin((rattle1.rattle_rect.y - rattle2.rattle_rect.y) / distance)
        }
        else{
            rattle1.rattle_velocity.fuai = pi - asin((rattle1.rattle_rect.y - rattle2.rattle_rect.y) / distance)
        }
        rattle2.rattle_velocity.magnitude = RattleModel.RATTLE_MAX_SPEED
        rattle2.rattle_velocity.fuai = pi + rattle1.rattle_velocity.fuai

        
        rattle1.rattle_velocity.angle = -sin((rattle1.rattle_velocity.fuai) - angleOfVelocity1) * RattleModel.RATTLE_MAX_ANGULARSPEED
        
        if angleOfVelocity2 != nil {
            rattle2.rattle_velocity.angle = -sin((rattle2.rattle_velocity.fuai) - angleOfVelocity2) * RattleModel.RATTLE_MAX_ANGULARSPEED
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
    
    static func getInitRattleRect(radius : CGFloat, bounds: RattleBounds, index: Int, count: Int) -> RattleRect{
        return RattleRect(x: radius + CGFloat(index % 3) * (bounds.width - 2 * radius) / 2, y : radius + CGFloat(index / 3) * (bounds.height - radius * 2) / CGFloat((count - 1) / 3), radius: radius, rotation: CGFloat(CommonUtils.getRandomNumber(1000)) / 1000 * 6.28)
    }
    
    static func getInitRattleVelocity() -> RattleVelocity {
        return RattleVelocity(magnitude: CGFloat(CommonUtils.getRandomNumber(1000)) / 1000 * RattleModel.RATTLE_MAX_SPEED, fuai: CGFloat(CommonUtils.getRandomNumber(100)) / 100 * 2 * pi, angle: 0)
    }
    
    static func setRattlesMove(_ rattles : [RattleModel]) -> [RattleModel]{
        for rattle in rattles {
            rattle.rattle_velocity.magnitude = RattleModel.RATTLE_MAX_SPEED
        }
        return rattles
    }
    
    
    
    
    
}
