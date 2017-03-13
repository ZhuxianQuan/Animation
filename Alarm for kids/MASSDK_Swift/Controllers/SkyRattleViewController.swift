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
        
        // Do any additional setup after loading the view.
        setRattlesView()
    }
    
    func setRattlesView(){
        var images : [UIImage] = []
        for index in 3...8 {
            images.append(UIImage(named: "skyrattle_\(index)")!)
        }
        rattlesView.initRattleView(images: images)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
   
    
}

