//
//  BabyStatusViewController.swift
//  Alarm For Children
//
//  Created by Huijing on 25/01/2017.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit

class BabyRadioViewController: BaseViewController {
    
    var itemStatus = 0
    

    @IBOutlet weak var imvBaby: UIImageView!
    @IBOutlet weak var btnTimer: UIButton!
    @IBOutlet weak var btnBabyMode: UIButton!
    
    @IBOutlet weak var slidernoiseLevel: UISlider!
    
    @IBOutlet weak var btnPlay: UIButton!
    
    @IBOutlet weak var itemTitle: UILabel!
    
    var item : FloatingItemModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        itemTitle.text = item.item_title
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
        initView()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func initView(){
        if itemStatus == Constants.BABY_RADIO_CLOUD{
            if Settings.baby_crying_status == Constants.BABY_CRYING_SLEEPING{
                imvBaby.image = UIImage(named: "child_sleeping")
            }
            else if Settings.baby_crying_status == Constants.BABY_CRYING_CRYING{
                imvBaby.image = UIImage(named: "child_crying")
            }
            else if Settings.baby_crying_status == Constants.BABY_CRYING_MORECRYING{
                imvBaby.image = UIImage(named: "child_morecrying")
            }
            
        }
        else{
            if Settings.baby_crying_status == Constants.BABY_CRYING_SLEEPING{
                imvBaby.image = UIImage(named: "child_sleeping_star")
            }
            else if Settings.baby_crying_status == Constants.BABY_CRYING_CRYING{
                imvBaby.image = UIImage(named: "child_crying_star")
            }
            else if Settings.baby_crying_status == Constants.BABY_CRYING_MORECRYING{
                imvBaby.image = UIImage(named: "child_morecrying_star")
            }
            
        }
        
        if (Settings.baby_monitor)
        {
            btnTimer.backgroundColor = Constants.COLOR_BUTTON_SELECTED
        }
        else{
            btnTimer.backgroundColor = Constants.COLOR_BUTTON_UNSELECTED
            
        }
        if (Settings.baby_mode_status == Constants.BABY_MODE_ON){
            
            btnBabyMode.backgroundColor = Constants.COLOR_BUTTON_SELECTED
        }
        else{
            
            btnBabyMode.backgroundColor = Constants.COLOR_BUTTON_UNSELECTED
            if itemStatus == Constants.BABY_RADIO_CLOUD{
                imvBaby.image = UIImage(named: "child_sleeping")
            }
            else if itemStatus == Constants.BABY_RADIO_STAR{
                imvBaby.image = UIImage(named: "child_sleeping_star")

            }

        }
        
        if Settings.baby_sound_isplaying == Constants.BABY_SOUND_PLAYING{
            btnPlay.setImage(UIImage(named: "play_pause"), for: .normal)
        }
        else{
            btnPlay.setImage(UIImage(named: "icon_play"), for: .normal)
        }
        
        
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    @IBAction func gotoBabyModeTapped(_ sender: Any) {
        
        //if (itemStatus == Constants.BABY_RADIO_STAR){
            let viewController = storyboard?.instantiateViewController(withIdentifier: "BabyModeViewController") as! BabyModeViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        //}
    }

    @IBAction func gotoTimerButtonTapped(_ sender: Any) {
        
        //if (itemStatus == Constants.BABY_RADIO_STAR){
            let viewController = storyboard?.instantiateViewController(withIdentifier: "SoundTimerViewController") as! SoundTimerViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        //}
    }
}
