//
//  SkyRattleViewController.swift
//  Alarm For Children
//
//  Created by Huijing on 25/01/2017.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit


class SkyRattleViewController: BaseViewController {

    
    @IBOutlet weak var rattlesView: RattlesView!
    var noiseStatus = 1
    
    //Acceleration setting variables
    var threshold:CGFloat = 0.0
    var shouldDragX = true
    var snapX : CGFloat = 1
    var timer = Timer()
    var currentAcceleration: CGFloat = 0.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRattlesView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        rattlesView.setTimer()
    }
    
    func setRattlesView(){
        var images : [UIImage] = []
        for index in 4...5 {
            images.append(UIImage(named: "skyrattle_\(index)")!) //\(index)
        }
        //for index in 9...10 {
        images.append(UIImage(named: "skyrattle_10")!)
        images.append(UIImage(named: "skyrattle_13")!) //\(index)
        //}
        rattlesView.initRattleView(images: images)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        rattlesView.timer.invalidate()
    }
    
    
    
}
/*
extension SkyRattleViewController : UIAccelerometerDelegate {
    
}*/



