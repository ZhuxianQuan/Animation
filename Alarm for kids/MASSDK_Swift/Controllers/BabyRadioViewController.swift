//
//  BabyStatusViewController.swift
//  Alarm For Children
//
//  Created by Huijing on 25/01/2017.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit
import MediaPlayer

class BabyRadioViewController: BaseViewController{
    
    var itemStatus = 0
    
    var floatingItems :  [FloatingItemModel] = []

    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var imvBaby: UIImageView!
    @IBOutlet weak var btnTimer: UIButton!
    @IBOutlet weak var btnBabyMode: UIButton!
    
    @IBOutlet weak var slidernoiseLevel: UISlider!
    
    @IBOutlet weak var btnPlay: UIButton!
    
    @IBOutlet weak var itemTitle: UILabel!
    
    @IBOutlet weak var volumeParentView: UIView!
    
    var selectedIndex = 0
    var item: FloatingItemModel!
    //let volumeView = MPVolumeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        selectedIndex = CommonUtils.getIndex(item:  item, from: floatingItems)
  
        //volumeSlider.alpha = 0.00001
        if selectedIndex == 0{
            btnPrev.isHidden = true
        }
        else if selectedIndex == floatingItems.count - 1 {
            btnNext.isHidden = true
        }
        setTitle(item)
        let myVolumeView = MPVolumeView(frame: volumeParentView.bounds)
        volumeParentView.addSubview(myVolumeView)
        slidernoiseLevel.value = myVolumeView.volumeSlider.value
        myVolumeView.volumeSlider.addTarget(self, action: #selector(changeVolumeOutSide), for: .valueChanged)

        
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
    @IBAction func playButtonTapped(_ sender: UIButton) {
        if Settings.baby_sound_isplaying == Constants.BABY_SOUND_PLAYING{
            Settings.baby_sound_isplaying = Constants.BABY_SOUND_UNPLAYING
            sender.setImage(UIImage(named: "icon_play"), for: .normal)
        }
        else{
            
            Settings.baby_sound_isplaying = Constants.BABY_SOUND_PLAYING
            sender.setImage(UIImage(named: "play_pause"), for: .normal)
        }
        playSound(item)
    }
    
    func playSound(_ item: FloatingItemModel) {
        if Settings.baby_sound_isplaying == Constants.BABY_SOUND_PLAYING{
            let userInfo = [Constants.KEY_AUDIO_FILENAME : item.item_title]
            notificationCenter.post(name: NSNotification.Name(rawValue: Constants.ORDER_PLAY_AUDIO), object: nil, userInfo: userInfo)
            
        }
        else{
            notificationCenter.post(name: NSNotification.Name(rawValue: Constants.ORDER_PAUSE_AUDIO), object: nil, userInfo: nil)
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
    
    func setTitle(_ item : FloatingItemModel) {
        itemTitle.text = item.item_title
    }
    @IBAction func prevButtonTapped(_ sender: Any) {
        btnNext.isHidden = false
        selectedIndex -= 1
        item = floatingItems[selectedIndex]
        setTitle(item)
        playSound(item)
        if selectedIndex == 0{
            btnPrev.isHidden = true
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        btnPrev.isHidden = false
        
        selectedIndex += 1
        item = floatingItems[selectedIndex]
        setTitle(item)
        playSound(item)
        
        if selectedIndex == floatingItems.count - 1 {
            btnNext.isHidden = true
        }
    }
    
    @IBAction func volumeChanged(_ sender: UISlider) {
        
        (volumeParentView.subviews[0] as! MPVolumeView).volumeSlider.setValue(sender.value, animated: false)
    
    }
    
    func changeVolumeOutSide(_ sender: UISlider) {
        slidernoiseLevel.value = sender.value
    }
    
}



extension MPVolumeView {
    var volumeSlider:UISlider {
        /*self.showsRouteButton = false
        self.showsVolumeSlider = false*/
        //self.alpha = 0.0001
        var slider = UISlider()
        for subview in self.subviews {
            if subview.isKind(of: UISlider.self){
                slider = subview as! UISlider
                slider.isContinuous = false
                (subview as! UISlider).value = AVAudioSession.sharedInstance().outputVolume
                return slider
            }
        }
        return slider
    }
}

