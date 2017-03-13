//
//  RattlesView.swift
//  MASSDK_Swift
//
//  Created by Big Shark on 12/03/2017.
//  Copyright © 2017 MasterApp. All rights reserved.
//

import UIKit

class RattlesView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var rattles : [RattleModel] = []
    var rattleBounds : RattleBounds!
    var width : CGFloat!
    var height: CGFloat!
    
    
    var timer : Timer!
    
    var threshold = CGPoint.zero
    
    var selectedView : UIView?
    
    func initRattleView(images : [UIImage]){
        //set rattle bounds
        setRattleBounds()
        
        //init Rattle Views 
        rattles = RattleUtils.initRattles(images, frameWidth: screenSize.width, bounds: rattleBounds)
        for rattle in rattles{
            let rattleView = RattleView()
            addSubview(rattleView)
            rattleView.initView()
            rattleView.setView(rattle)
            rattleView.tag = getRattleViewTag(rattle.rattle_tag)
            rattleView.setView(rattle)
        }
        
        // add gestures
        setupGustures()
        
        
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(RattleModel.RATTLE_INTERVAL), target: self, selector: #selector(getNextRattles), userInfo: nil, repeats: true)
    }
    
    
    
    func setupGustures(){
        let pan = UIPanGestureRecognizer(target: self, action: #selector(HomeViewController.pan(_:)))
        pan.maximumNumberOfTouches = 1
        pan.minimumNumberOfTouches = 1
        self.addGestureRecognizer(pan)
    }
    
    
    func pan(_ rec: UIPanGestureRecognizer){
        let p:CGPoint = rec.location(in: self)
        
        
        switch rec.state {
        case .began:
            print("began")
            
            selectedView = self.hitTest(p, with: nil)
            if !(selectedView?.isKind(of: RattleView.self))! {
                selectedView = nil
            }
            if selectedView != nil {
                
                self.bringSubview(toFront: selectedView!)
            }
        case .changed:
            
            if threshold == CGPoint.zero
            {
                threshold = p
            }
            
            let subView = self.hitTest(p, with: nil)
            if subView != nil{
                if selectedView != nil && subView == selectedView{
                    let tag = selectedView!.tag
                    let rattleTag = getRattleTagFromViewTag(tag)
                    if rattleTag >= 0{
                        let rattle = rattles[rattleTag]
                        
                        if RattleUtils.getCorner(rattleRect: RattleRect(x: (p.x) / screenSize.width, y: (p.y) / screenSize.width, radius: rattle.rattle_rect.radius, rotation: 0), bounds: rattleBounds) == 0{
                            rattle.rattle_rect.x = (p.x) / screenSize.width
                            rattle.rattle_rect.y = (p.y) / screenSize.width
                        
                        }
                    }
                }
            }
            
        case .ended:
            print("ended")
            threshold = CGPoint.zero
            selectedView = nil
            
        case .possible:
            print("possible")
        case .cancelled:
            print("cancelled")
            threshold = CGPoint.zero
            selectedView = nil
        case .failed:
            print("failed")
        }
    }
    
    func setRattleBounds(){
        width  =  frame.size.width
        height = frame.size.height
        rattleBounds = RattleBounds(width: 1, height: height / width)
    }
    
    func getNextRattles(){
        rattles = RattleUtils.getNewRattles(rattles, bounds: rattleBounds)
        for rattle in rattles{
            setRattle(rattle)
        }
    }
    
    func setRattle(_ rattle: RattleModel){
        (self.viewWithTag(getRattleViewTag(rattle.rattle_tag)) as! RattleView).moveView(rattle)
    }
    
    func getRattleViewTag(_ rattleTag: Int) -> Int{
        return 10 * rattleTag + 10
    }
    
    func getRattleTagFromViewTag(_ tag: Int) -> Int {
        return (tag - 10) / 10
    }
    
}


extension RattlesView : UIAccelerometerDelegate{
    
}
