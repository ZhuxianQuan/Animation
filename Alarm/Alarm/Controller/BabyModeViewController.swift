//
//  BabyModeViewController.swift
//  Alarm For Children
//
//  Created by Huijing on 25/01/2017.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit

class BabyModeViewController: BaseViewController {

    @IBOutlet weak var btnBabyModeStatus: UIButton!
    var babyModeStatus = true

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (babyModeStatus){
            btnBabyModeStatus.backgroundColor = UIColor(colorLiteralRed: 72.0 / 255.0, green: 142.0 / 255.0 , blue: 42.0 / 255.0, alpha: 1)
            btnBabyModeStatus.setTitle("START", for: .normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func babyModeStatusButtonTapped(_ sender: Any) {
        babyModeStatus = !babyModeStatus
        if babyModeStatus{
            btnBabyModeStatus.backgroundColor = UIColor(colorLiteralRed: 72.0 / 255.0, green: 142.0 / 255.0 , blue: 42.0 / 255.0, alpha: 1)
            btnBabyModeStatus.setTitle("START", for: .normal)
        }
        else{
            btnBabyModeStatus.backgroundColor = UIColor(colorLiteralRed: 173.0 / 255.0, green: 37.0 / 255.0 , blue: 36.0 / 255.0, alpha: 1)
            btnBabyModeStatus.setTitle("STOP", for: .normal)

        }
    }

}
