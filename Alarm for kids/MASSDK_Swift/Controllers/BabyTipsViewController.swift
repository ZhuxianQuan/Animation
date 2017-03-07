//
//  BabyTipsViewController.swift
//  Alarm For Children
//
//  Created by Huijing on 25/01/2017.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit

class BabyTipsViewController: BaseViewController {

    @IBOutlet weak var prevImageView: UIImageView!
    @IBOutlet weak var nextImageView: UIImageView!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    @IBOutlet weak var statusSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tipTitle: UILabel!
    @IBOutlet weak var tipContent: UITextView!
    
    
    var safetySelected = 0
    var sleepingSelected = 0
    
    let safetyTips = BabyTips.getSafetyTips()
    let sleepingTips = BabyTips.getSleepingTips()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setText(selected: 0, status: 0)
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
    @IBAction func prevButtonTapped(_ sender: Any) {
        if statusSegmentedControl.selectedSegmentIndex == 1{
            safetySelected -= 1
            setText(selected: safetySelected, status: 1)
        }
        else{
            sleepingSelected -= 1
            setText(selected: sleepingSelected, status: 0)
        }
        
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if statusSegmentedControl.selectedSegmentIndex == 1{
            safetySelected += 1
            setText(selected: safetySelected, status: 1)
        }
        else{
            sleepingSelected += 1
            setText(selected: sleepingSelected, status: 0)
        }
    }
    
    @IBAction func selectStatus(_ sender: Any) {
        
        nextButton.isHidden = false
        nextImageView.isHidden = false
        prevButton.isHidden = false
        prevImageView.isHidden = false
        if statusSegmentedControl.selectedSegmentIndex == 0 {
            setText(selected: sleepingSelected, status: 0)
        }
        else{
            setText(selected: safetySelected, status: 1)
        }
    }
    
    func setText(selected: Int, status: Int){
        if status == 1 {
            tipTitle.text = safetyTips[selected].tip_title
            tipContent.text = safetyTips[selected].tip_content
            if selected == 0{
                prevButton.isHidden = true
                prevImageView.isHidden = true
            }
            
            if selected == 1 {
                prevButton.isHidden = false
                prevImageView.isHidden = false
            }
            
            if selected == safetyTips.count - 1 {
                nextButton.isHidden = true
                nextImageView.isHidden = true
            }
            
            if selected == safetyTips.count - 2{
                nextButton.isHidden = false
                nextImageView.isHidden = false
            }
            
        }
        else{
            tipTitle.text = sleepingTips[selected].tip_title
            tipContent.text = sleepingTips[selected].tip_content
            if selected == 0{
                prevButton.isHidden = true
                prevImageView.isHidden = true
            }
            
            if selected == 1 {
                prevButton.isHidden = false
                prevImageView.isHidden = false
            }
            
            if selected == safetyTips.count - 1 {
                nextButton.isHidden = true
                nextImageView.isHidden = true
            }
            
            if selected == safetyTips.count - 2{
                nextButton.isHidden = false
                nextImageView.isHidden = false
            }
        }
    }
}
