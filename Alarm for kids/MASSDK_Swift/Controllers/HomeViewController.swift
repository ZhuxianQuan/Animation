//
//  HomeViewController.swift
//  Alarm For Children
//
//  Created by Huijing on 24/01/2017.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit
import MASSDK

var screenSize : CGSize!
class HomeViewController: BaseViewController , FloatingImageContentViewDelegate{


    @IBOutlet weak var starsView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    //Acceleration setting variables 
    var threshold:CGFloat = 0.0
    var shouldDragX = true
    var snapX : CGFloat = 1
    var timer = Timer()
    
    var mainTimer = Timer()
    var currentAcceleration: CGFloat = 0.0
    
    var loaded = false
    
    var floatingItems : [FloatingItemModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loaded = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        threshold = 0
        self.navigationController?.isNavigationBarHidden = false
        if loaded {
            screenSize = self.view.frame.size
            loaded = false
            setFloatingItems(Constants.BABY_RADIO_ALL)
            setupGustures()
        }
        
    }

    
    func setFloatingItems(_ index: Int) {
        mainTimer.invalidate()
        timer.invalidate()
        clearView()
        
        if index == Constants.BABY_RADIO_ALL{
            
            floatingItems = BabyRadioItems.getAllItems()
            
            var index = 0
            for item in floatingItems{
                let tagValue = (Int(index / 6) + 1) * 10 + (index % 6) +
                 1
                
                let floatingView = self.view.viewWithTag(tagValue) as! FloatingImageContentView
                
                floatingView.maxSizeOfWidth = CGFloat(Int((floatingItems.count - 1) / 6 + 1) * 375)
                floatingView.leftCoValue = getLeftCoValue(index)
                floatingView.initWith(item: item)
                if item.item_type == Constants.BABY_RADIO_SOUND{
                    floatingView.isCloud = Constants.BABY_RADIO_CLOUD
                }
                else if item.item_type == Constants.BABY_RADIO_MUSIC {
                    floatingView.isCloud = Constants.BABY_RADIO_STAR
                }
                floatingView.delegate = self
                
                index += 1
            }
        /*
            for page in 1...5{
                for index in 1...6{
                    NSLog("\(page) - \(index)")
                    let tagValue = page * 10 + index
                    let floatingView = self.view.viewWithTag(tagValue) as! FloatingImageContentView
                    floatingView.leftCoValue = getLeftCoValue(page , index)
                    floatingView.initWith(image: UIImage(named: "image_\(tagValue)")!)
                    floatingView.delegate = self
                    if (index == 3 || index == 4) && page == 1{
                        floatingView.isCloud = Constants.BABY_RADIO_STAR
                    }
                    else if  (index == 3 || index == 6) && page == 2{
                        floatingView.isCloud = Constants.BABY_RADIO_STAR
                    }
                    else if (index == 1 || index == 4) && page == 3{
                        floatingView.isCloud = Constants.BABY_RADIO_STAR
                    }
                    else if (index == 1 || index == 2) && page == 4{
                        floatingView.isCloud = Constants.BABY_RADIO_STAR
                    }
                    else if (index == 3 || index == 4) && page == 5{
                        floatingView.isCloud = Constants.BABY_RADIO_STAR
                    }
                    else{
                        floatingView.isCloud = Constants.BABY_RADIO_CLOUD
                    }
                }
            }
 */
        }
        else if index == Constants.BABY_RADIO_MUSIC{
            floatingItems = BabyRadioItems.getMusic()
            var index = 0
            for item in floatingItems{
                let tagValue = (Int(index / 6) + 1) * 10 + (index % 6) +
                1
                
                let floatingView = self.view.viewWithTag(tagValue) as! FloatingImageContentView
                
                floatingView.maxSizeOfWidth = CGFloat(Int((floatingItems.count - 1) / 6 + 1) * 375)
                floatingView.leftCoValue = getLeftCoValue(index)
                floatingView.initWith(item: item)
                if item.item_type == Constants.BABY_RADIO_SOUND{
                    floatingView.isCloud = Constants.BABY_RADIO_CLOUD
                }
                else if item.item_type == Constants.BABY_RADIO_MUSIC {
                    floatingView.isCloud = Constants.BABY_RADIO_STAR
                }
                floatingView.delegate = self
                
                index += 1
            }
        }
        else if index == Constants.BABY_RADIO_SOUND{
            floatingItems = BabyRadioItems.getSounds()
            var index = 0
            for item in floatingItems{
                let tagValue = (Int(index / 6) + 1) * 10 + (index % 6) +
                1
                
                let floatingView = self.view.viewWithTag(tagValue) as! FloatingImageContentView
                
                floatingView.maxSizeOfWidth = CGFloat(Int((floatingItems.count - 1) / 6 + 1) * 375)
                floatingView.leftCoValue = getLeftCoValue(index)
                floatingView.initWith(item: item)
                if item.item_type == Constants.BABY_RADIO_SOUND{
                    floatingView.isCloud = Constants.BABY_RADIO_CLOUD
                }
                else if item.item_type == Constants.BABY_RADIO_MUSIC {
                    floatingView.isCloud = Constants.BABY_RADIO_STAR
                }
                floatingView.delegate = self
                
                index += 1
            }
        }
        mainTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(moveBackgroudImages), userInfo: nil, repeats: true)
    }
    
    func clearView(){
        for page in 1...5{
            for index in 1...6{
                let floatingView = self.view.viewWithTag(page * 10 + index)
                if floatingView != nil
                {
                    let subViews = floatingView?.subviews
                    if subViews != nil{
                        for subview in subViews!{
                            subview.removeFromSuperview()
                        }
                    }
                }
            }
        }
    }
    
    func getLeftCoValue(_ index: Int) -> CGFloat{
        var leftCoValue : CGFloat = 0
        switch Int(index / 6) {
        case 1 - 1:
            switch index % 6 {
            case 1 - 1:
                leftCoValue = 34
                break
            case 2 - 1:
                leftCoValue = 426
                break
            case 3 - 1:
                leftCoValue = 152
                break
            case 4 - 1:
                leftCoValue = 519
                break
            case 5 - 1:
                leftCoValue = 361
                break
            case 6 - 1:
                leftCoValue = 80
                break
            default:
                break
            }
            break
        case 2 - 1:
            switch index % 6 {
            case 1 - 1:
                leftCoValue = 770
                break
            case 2 - 1:
                leftCoValue = 1170
                break
            case 3 - 1:
                leftCoValue = 850
                break
            case 4 - 1:
                leftCoValue = 1175
                break
            case 5 - 1:
                leftCoValue = 815
                break
            case 6 - 1:
                leftCoValue = 1220
                break
            default:
                break
            }
            break
        case 3 - 1:
            
            switch index % 6 {
            case 1 - 1:
                leftCoValue = 1568
                break
            case 2 - 1:
                leftCoValue = 1924
                break
            case 3 - 1:
                leftCoValue = 1550
                break
            case 4 - 1:
                leftCoValue = 2014
                break
            case 5 - 1:
                leftCoValue = 1850
                break
            case 6 - 1:
                leftCoValue = 1570
                break
            default:
                break
            }
        case 4 - 1:
            
            switch index % 6 {
            case 1 - 1:
                leftCoValue = 2385
                break
            case 2 - 1:
                leftCoValue = 2705
                break
            case 3 - 1:
                leftCoValue = 2327
                break
            case 4 - 1:
                leftCoValue = 2713
                break
            case 5 - 1:
                leftCoValue = 2433
                break
            case 6 - 1:
                leftCoValue = 2713
                break
            default:
                break
            }
            break
        case 5 - 1:
            
            switch index % 6 {
            case 1 - 1:
                leftCoValue = 3034
                break
            case 2 - 1:
                leftCoValue = 3426
                break
            case 3 - 1:
                leftCoValue = 3119
                break
            case 4 - 1:
                leftCoValue = 3485
                break
            case 5 - 1:
                leftCoValue = 3421
                break
            case 6 - 1:
                leftCoValue = 3079
                break
            default:
                break
            }
        default:
            break
        }
        
        return leftCoValue / 2
    }

    func moveBackgroudImages(){
        
        for page in 1...5{
            for index in 1...6{
                let tagValue = page * 10 + index
                let floatingView = self.view.viewWithTag(tagValue) as! FloatingImageContentView
                floatingView.animateView()
                
            }
        }
    }

    @IBAction func selectSegmentedControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == Constants.BABY_RADIO_SOUND{
            setFloatingItems(Constants.BABY_RADIO_SOUND)
        }
        else if sender.selectedSegmentIndex == Constants.BABY_RADIO_ALL{
            setFloatingItems(Constants.BABY_RADIO_ALL)
        }
        else if sender.selectedSegmentIndex == Constants.BABY_RADIO_MUSIC{
            setFloatingItems(Constants.BABY_RADIO_MUSIC)
        }
    }
    func moveFaseBackgroundImages(){
        
        for page in 1...5{
            for index in 1...6{
                let tagValue = page * 10 + index
                let floatingView = self.view.viewWithTag(tagValue) as! FloatingImageContentView
                floatingView.animateAccelateView()
                
            }
        }
    }

    func imageTapped(_ floatingView: FloatingImageContentView) {
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: "BabyRadioViewController") as! BabyRadioViewController
        
        if floatingView.isCloud == Constants.BABY_RADIO_CLOUD{
            viewController.itemStatus = Constants.BABY_RADIO_CLOUD
        }
        else{
            viewController.itemStatus = Constants.BABY_RADIO_STAR
        }
        viewController.item = floatingView.floatingItem
        viewController.floatingItems = floatingItems
    
        if Settings.baby_sound_isplaying == Constants.BABY_SOUND_PLAYING{
            let userInfo = [Constants.KEY_AUDIO_FILENAME : floatingView.floatingItem.item_title]
            notificationCenter.post(name: NSNotification.Name(rawValue: Constants.ORDER_PLAY_AUDIO), object: nil, userInfo: userInfo)
        }
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }

    //Mark - Show Menu
    @IBAction func menuButtonTapped(_ sender: Any) {

    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        MASManager.sharedInstance.showGuideWithMasterTouchView()
    }

    //Mark - Add Pan Gesture Recognizer

    func setupGustures(){
        let pan = UIPanGestureRecognizer(target: self, action: #selector(HomeViewController.pan(_:)))
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
            
            threshold = 0
        case .failed:
            print("failed")
        }
    }

    func startAccelerator()
    {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(0.01 / currentAcceleration), target: self, selector: #selector(moveFaseBackgroundImages), userInfo: nil, repeats: true)
    }

    func stopAccelerator(){
        timer.invalidate()
    }
}
