//
//  AnimalNoisesViewController.swift
//  Alarm For Children
//
//  Created by Huijing on 25/01/2017.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit

class AnimalNoisesViewController: BaseViewController {
    
    @IBOutlet weak var animalsView: AnimalsView!
    var animalImages: [AnimalNoiseModel] = []
    
    var noiseStatus = 1
    
    //Acceleration setting variables
    var threshold:CGFloat = 0.0
    var shouldDragX = true
    var snapX : CGFloat = 1
    var timer = Timer()
    var currentAcceleration: CGFloat = 0.0
    var currentDirection = true


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setAnimalImages()
        animalsView.initWith(animals: animalImages)
        setupGustures()
        _ = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(moveImages), userInfo: nil, repeats: true)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        animalsView.pauseAudio()
    }
    
    func moveImages(){
        animalsView.animateView()
    }
    
    func moveAccelerateImages(){
        animalsView.animateAccelateView(currentDirection)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setAnimalImages()
    {
        animalImages = AnimalNoises.getAnimalNoises()
    }
    
    
    //Mark - Add Pan Gesture Recognizer
    
    func setupGustures(){
        let pan = UIPanGestureRecognizer(target: self, action: #selector(AnimalNoisesViewController.pan(_:)))
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
                self.currentDirection = true
                startAccelerator()
            }
            else{
                currentAcceleration = -threshold + p.x
                self.currentDirection = false
                threshold = p.x
                startAccelerator()
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
