//
//  HomeViewController.swift
//  Alarm For Children
//
//  Created by Huijing on 24/01/2017.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit
import MASSDK

class HomeViewController: BaseViewController , FloatingImageContentViewDelegate{

    @IBOutlet weak var headerCloudView: FloatingImageContentView!
    @IBOutlet weak var bottom3CloudView: FloatingImageContentView!
    @IBOutlet weak var bottom2ContentView: FloatingImageContentView!
    @IBOutlet weak var bottom1ContentView: FloatingImageContentView!

    @IBOutlet weak var jazzAndHappinessView: FloatingImageContentView!
    @IBOutlet weak var fireView: FloatingImageContentView!
    @IBOutlet weak var forestView: FloatingImageContentView!
    @IBOutlet weak var sunnyView: FloatingImageContentView!
    @IBOutlet weak var littleIdeaView: FloatingImageContentView!
    @IBOutlet weak var happinessView: FloatingImageContentView!

    @IBOutlet weak var starsView: UIView!

    //Acceleration setting variables 
    var threshold:CGFloat = 0.0
    var shouldDragX = true
    var snapX : CGFloat = 1
    var timer = Timer()
    var currentAcceleration: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        setClouds()
        setupGustures()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Mark - Set Animating Clouds

    func setClouds(){

        headerCloudView.initWith(image: UIImage(named: "cloud_header")!)
        headerCloudView.isUserInteractionEnabled = false
        bottom1ContentView.initWith(image: UIImage(named: "cloud_bottom_1")!)
        bottom1ContentView.isUserInteractionEnabled = false


        bottom2ContentView.initWith(image: UIImage(named: "cloud_bottom_2")!)
        bottom2ContentView.isUserInteractionEnabled = false

        bottom3CloudView.initWith(image: UIImage(named: "cloud_bottom_3")!)
        bottom3CloudView.isUserInteractionEnabled = false



        jazzAndHappinessView.initWith(image: UIImage(named: "image_jazzcomedy")!)
        jazzAndHappinessView.tag = 1;
        jazzAndHappinessView.delegate = self

        fireView.initWith(image: UIImage(named: "image_fire")!)
        fireView.delegate = self
        fireView.tag = 2

        forestView.initWith(image: UIImage(named: "image_forest")!)
        forestView.delegate = self
        forestView.tag = 3


        sunnyView.initWith(image: UIImage(named: "image_sunny")!)
        sunnyView.delegate = self
        sunnyView.tag = 4

        littleIdeaView.initWith(image: UIImage(named: "image_little_idea")!)
        littleIdeaView.delegate = self
        littleIdeaView.tag = 5

        happinessView.initWith(image: UIImage(named: "image_happiness")!)
        happinessView.delegate = self
        happinessView.tag = 6

        _ = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(moveBackgroudImages), userInfo: nil, repeats: true)
    }

    func moveBackgroudImages(){

        headerCloudView.animateView()
        bottom1ContentView.animateView()
        bottom2ContentView.animateView()
        bottom3CloudView.animateView()
        jazzAndHappinessView.animateView()
        fireView.animateView()
        forestView.animateView()
        sunnyView.animateView()
        littleIdeaView.animateView()
        happinessView.animateView()
    }

    func moveFaseBackgroundImages(){
        headerCloudView.animateAccelateView()
        bottom1ContentView.animateAccelateView()
        bottom2ContentView.animateAccelateView()
        bottom3CloudView.animateAccelateView()
        jazzAndHappinessView.animateAccelateView()
        fireView.animateAccelateView()
        forestView.animateAccelateView()
        sunnyView.animateAccelateView()
        littleIdeaView.animateAccelateView()
        happinessView.animateAccelateView()
    }

    func imageTapped(_ index: Int) {

    }

    //Mark - Show Menu
    @IBAction func menuButtonTapped(_ sender: Any) {
        /*if self.revealViewController() != nil{
            self.revealViewController().revealToggle(sender)
        }*/
        
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
