//
//  RattlesView.swift
//  MASSDK_Swift
//
//  Created by Big Shark on 12/03/2017.
//  Copyright © 2017 MasterApp. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation


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
    
    var motionManager = CMMotionManager()
    
    var timer : Timer!
    
    var threshold = CGPoint.zero
    
    var selectedView : UIView?
    
    var player : AVAudioPlayer?
    
    
    
    var intervalCount : CGFloat = 0
    
    
    func initRattleView(images : [UIImage]){
        //set rattle bounds
        self.emptyView()
        if timer != nil {
            if timer.isValid{
                timer.invalidate()
            }
        }
        
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
        
        motionManager.accelerometerUpdateInterval = 0.01
        motionManager.startAccelerometerUpdates(to: .main, withHandler: {
            accelerateData , error in
            if (accelerateData?.acceleration.x)! > 0.2 || (accelerateData?.acceleration.y)! > 0.2 || (accelerateData?.acceleration.z)! > 0.2 {
                self.moveRattles()
            }
            
        })        
        
        
    }
    
    func setTimer(){
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(RattleModel.RATTLE_INTERVAL), target: self, selector: #selector(getNextRattles), userInfo: nil, repeats: true)
    }
    
    func moveRattles() {
        rattles = RattleUtils.setRattlesMove(rattles)
    }
    
    func playAudio(_ filename : String){
        
        let url = URL(string: Bundle.main.path(forResource: filename, ofType: nil)!)
        do {
            player = try AVAudioPlayer(contentsOf: url!)
            guard let player = player else { return }
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
        
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
                        let deltaX = p.x - threshold.x
                        let deltaY = p.y - threshold.y
                        let delta = pow(pow(deltaX, 2) + pow(deltaY, 2), 0.5)
                        
                        if intervalCount > 0 && delta > 0{
                            if RattleUtils.getCorner(rattleRect: rattle.rattle_rect, bounds: rattleBounds) == 0{
                                //rattle.rattle_rect.x = (p.x) / screenSize.width
                                //rattle.rattle_rect.y = (p.y) / screenSize.width
                                //rattle.rattle_velocity.vx
                                rattle.rattle_velocity.magnitude = 0.5 * RattleModel.RATTLE_MAX_SPEED //rattle.rattle_velocity.vx + RattleModel.RATTLE_MAX_SPEED * (deltaX / intervalCount) / screenSize.width
                                if deltaX > 0{
                                    rattle.rattle_velocity.fuai = asin(deltaY / delta)
                                }
                                else{
                                    rattle.rattle_velocity.fuai = 3.14159265359 - asin(deltaY / delta)
                                }
                            
                            }
                            threshold = p
                        }
                        intervalCount = 0
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
        intervalCount += 1
        let nextObject = RattleUtils.getNewRattles(rattles, bounds: rattleBounds)
        rattles = nextObject.0
        for rattle in rattles{
            setRattle(rattle)
        }
        if nextObject.1.count > 0 {
            playAudio("right.mp3")
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
