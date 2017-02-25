//
//  SkyRattleViewController.swift
//  Alarm For Children
//
//  Created by Huijing on 25/01/2017.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit

class SkyRattleViewController: BaseViewController {

    
    @IBOutlet weak var animalsView: UIView!
    var imageModels: [ImageModel] = []
    
    var noiseStatus = 1
    
    //Acceleration setting variables
    var threshold:CGFloat = 0.0
    var shouldDragX = true
    var snapX : CGFloat = 1
    var timer = Timer()
    var currentAcceleration: CGFloat = 0.0

    let screenSize = UIScreen.main.bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        setImageModels()
        addImages()
        
        
        setupGustures()
        
        _ = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(moveImages), userInfo: nil, repeats: true)
        
    }
    
    func addImages(){
        
        var index = 100
        for imageModel in imageModels{
            
            let animationImageView = ImageAnimationView()
            
            animationImageView.initWith(imageModel, parentHeight: screenSize.height - 70)
            animationImageView.tag = index
            animalsView.addSubview(animationImageView)
            index += 1
            
        }
    }
    
    func setImageModels(){
        imageModels = []
        var imageModel = ImageModel()
        imageModel.topRatio = 100 / 1194
        imageModel.left = 30 / 2
        imageModel.image = UIImage(named: "skyrattle_1")
        imageModels.append(imageModel)
        imageModel = ImageModel()
        imageModel.topRatio = 90 / 1194
        imageModel.left = 468 / 2
        imageModel.image = UIImage(named: "skyrattle_2")
        imageModels.append(imageModel)
        imageModel = ImageModel()
        imageModel.topRatio = 160 / 1194
        imageModel.left = 324 / 2
        imageModel.image = UIImage(named: "skyrattle_3")
        imageModels.append(imageModel)
        imageModel = ImageModel()
        imageModel.topRatio = 336 / 1194
        imageModel.left = 43 / 2
        imageModel.image = UIImage(named: "skyrattle_4")
        imageModels.append(imageModel)
        imageModel = ImageModel()
        imageModel.topRatio = 332 / 1194
        imageModel.left = 516 / 2
        imageModel.image = UIImage(named: "skyrattle_5")
        imageModels.append(imageModel)
        imageModel = ImageModel()
        imageModel.topRatio = 490 / 1194
        imageModel.left = 312 / 2
        imageModel.image = UIImage(named: "skyrattle_6")
        imageModels.append(imageModel)
        imageModel = ImageModel()
        imageModel.topRatio = 632 / 1194
        imageModel.left = 30 / 2
        imageModel.image = UIImage(named: "skyrattle_7")
        imageModels.append(imageModel)
        imageModel = ImageModel()
        imageModel.topRatio = 604 / 1194
        imageModel.left = 560 / 2
        imageModel.image = UIImage(named: "skyrattle_8")
        imageModels.append(imageModel)
        imageModel = ImageModel()
        imageModel.topRatio = 726 / 1194
        imageModel.left = 297 / 2
        imageModel.image = UIImage(named: "skyrattle_9")
        imageModels.append(imageModel)
        imageModel = ImageModel()
        imageModel.topRatio = 822 / 1194
        imageModel.left = 526 / 2
        imageModel.image = UIImage(named: "skyrattle_10")
        imageModels.append(imageModel)
        imageModel = ImageModel()
        imageModel.topRatio = 856 / 1194
        imageModel.left = 106 / 2
        imageModel.image = UIImage(named: "skyrattle_11")
        imageModels.append(imageModel)
        imageModel = ImageModel()
        imageModel.topRatio = 1040 / 1194
        imageModel.left = 422 / 2
        imageModel.image = UIImage(named: "skyrattle_12")
        imageModels.append(imageModel)
        imageModel = ImageModel()
        imageModel.topRatio = 1065 / 1194
        imageModel.left = 30 / 2
        imageModel.image = UIImage(named: "skyrattle_13")
        imageModels.append(imageModel)
    }
    
    func moveImages(){
        var index = 100
        while index < 100 + imageModels.count {
            let animationImageView = self.animalsView.viewWithTag(index) as! ImageAnimationView
            animationImageView.animateView()
            index += 1
        }
    }
    
    func moveAccelerateImages(){
        var index = 100
        while index < 100 + imageModels.count {
            let animationImageView = self.animalsView.viewWithTag(index) as! ImageAnimationView
            animationImageView.animateAccelateView()
            index += 1
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //Mark - Add Pan Gesture Recognizer
    
    func setupGustures(){
        let pan = UIPanGestureRecognizer(target: self, action: #selector(SkyRattleViewController.pan(_:)))
        pan.maximumNumberOfTouches = 1
        pan.minimumNumberOfTouches = 1
        self.view.addGestureRecognizer(pan)
    }
    
    func pan(_ rec: UIPanGestureRecognizer){
        let p:CGPoint = rec.location(in: self.view)
        
        
        switch rec.state {
        case .began:
            print("began")
            
        case .changed:
            if threshold == 0
            {
                threshold = p.x
            }
            NSLog("\(threshold) == \(p.x)")
            if (p.x < threshold){
                currentAcceleration = threshold - p.x
                threshold = p.x
                startAccelerator()
            }
            else{
                timer.invalidate()
            }
            
        case .ended:
            print("ended")
            threshold = 0
            stopAccelerator()
            
        case .possible:
            print("possible")
        case .cancelled:
            print("cancelled")
        case .failed:
            print("failed")
        }
    }
    
    
    
    func startAccelerator()
    {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(0.01 / currentAcceleration), target: self, selector: #selector(moveAccelerateImages), userInfo: nil, repeats: true)
    }
    
    func stopAccelerator(){
        timer.invalidate()
    }
    

}
