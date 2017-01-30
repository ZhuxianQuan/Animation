//
//  BabyStatusViewController.swift
//  Alarm For Children
//
//  Created by Huijing on 25/01/2017.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit

class BabyRadioViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backButtonTapped(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    @IBAction func gotoBabyModeTapped(_ sender: Any) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "BabyModeViewController") as! BabyModeViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction func gotoTimerButtonTapped(_ sender: Any) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "SoundTimerViewController") as! SoundTimerViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
