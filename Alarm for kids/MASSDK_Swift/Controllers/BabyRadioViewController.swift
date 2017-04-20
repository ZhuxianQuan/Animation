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
    
    @IBOutlet weak var playStatusImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var selectedIndex = 0
    var item: FloatingItemModel!
    //let volumeView = MPVolumeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        selectedIndex = CommonUtils.getIndex(item:  item, from: floatingItems)
  
        //volumeSlider.alpha = 0.00001
        titleLabel.text = NSLocalizedString("Baby Radio", comment: "")
        setTitle(item)
        let myVolumeView = MPVolumeView(frame: volumeParentView.bounds)
        volumeParentView.addSubview(myVolumeView)
        slidernoiseLevel.value = myVolumeView.volumeSlider.value * 1000
        myVolumeView.volumeSlider.addTarget(self, action: #selector(changeVolumeOutSide), for: .valueChanged)
        
        notificationCenter.addObserver(self, selector: #selector(setTimeStrings), name: Notification.Name(rawValue: Constants.ORDER_REMAINTIME_CHANGED), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(pauseAudio), name: NSNotification.Name(rawValue: Constants.ORDER_PAUSE_AUDIO_BYTIMER), object: nil)
        
    }
    
    
    func setTimeStrings()
    {
        if AppDelegate.remainTime > 0{
            btnTimer.setTitle(NSLocalizedString("SOUND TIMER", comment: "") + ": " + getRemainTimeString(AppDelegate.remainTime), for: .normal)
        }
        else{
            btnTimer.setTitle(NSLocalizedString("SOUND TIMER", comment: "") + ": " + NSLocalizedString("OFF", comment: ""), for: .normal)
        }
    }
    
    func pauseAudio() {
        playStatusImageView.image = UIImage(named: "icon_play")
        setChildStatus()
        setTimerButtonStatus()
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
        
        setChildStatus()
        setTimerButtonStatus()
        
        setButtonStatus()
        
            if itemStatus == Constants.BABY_RADIO_CLOUD{
                imvBaby.image = UIImage(named: "child_sleeping")
            }
            else if itemStatus == Constants.BABY_RADIO_STAR{
                imvBaby.image = UIImage(named: "child_sleeping_star")

            }

        //}
        
        if Settings.baby_sound_isplaying == Constants.BABY_SOUND_PLAYING{
            playStatusImageView.image = UIImage(named: "play_pause")
        }
        else{
            
            playStatusImageView.image = UIImage(named: "icon_play")
        }
        
        
    }
    
    func setButtonStatus() {
        if (Settings.getAirplaneStatus()){
            
            btnBabyMode.backgroundColor = Constants.COLOR_BUTTON_SELECTED
            btnBabyMode.setTitle(NSLocalizedString("BABY MODE", comment: "") + ": " + NSLocalizedString("ON", comment: ""), for: .normal)
        }
        else{
            btnBabyMode.backgroundColor = Constants.COLOR_BUTTON_UNSELECTED
            btnBabyMode.setTitle(NSLocalizedString("BABY MODE", comment: "") + ": " + NSLocalizedString("OFF", comment: ""), for: .normal)
        }
    }
    
    func setChildStatus() {
        if itemStatus == Constants.BABY_RADIO_CLOUD{
            /*if Settings.baby_crying_status == Constants.BABY_CRYING_SLEEPING {
             imvBaby.image = UIImage(named: "child_sleeping")
             }
             else if Settings.baby_crying_status == Constants.BABY_CRYING_CRYING {
             imvBaby.image = UIImage(named: "child_crying")
             }
             else if Settings.baby_crying_status == Constants.BABY_CRYING_MORECRYING {
             imvBaby.image = UIImage(named: "child_morecrying")
             }*/
            
            if Settings.baby_sound_isplaying == Constants.BABY_SOUND_PLAYING{
                imvBaby.image = UIImage(named: "child_sleeping")
            }
            else {
                imvBaby.image = UIImage(named: "child_morecrying")
            }
            
        }
        else{
            /*if Settings.baby_crying_status == Constants.BABY_CRYING_SLEEPING{
             imvBaby.image = UIImage(named: "child_sleeping_star")
             }
             else if Settings.baby_crying_status == Constants.BABY_CRYING_CRYING{
             imvBaby.image = UIImage(named: "child_crying_star")
             }
             else if Settings.baby_crying_status == Constants.BABY_CRYING_MORECRYING{
             imvBaby.image = UIImage(named: "child_morecrying_star")
             }*/
            if Settings.baby_sound_isplaying == Constants.BABY_SOUND_PLAYING{
                imvBaby.image = UIImage(named: "child_sleeping_star")
            }
            else {
                imvBaby.image = UIImage(named: "child_morecrying_star")
            }
            
        }
    }
    
    override func appDidEnterForeground() {
        setButtonStatus()
    }
    
    func setTimerButtonStatus() {
        
        if (AppDelegate.remainTime > 0)
        {
            btnTimer.backgroundColor = Constants.COLOR_BUTTON_SELECTED
        }
        else{
            btnTimer.backgroundColor = Constants.COLOR_BUTTON_UNSELECTED
        }
        setTimeStrings()

    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        if Settings.baby_sound_isplaying == Constants.BABY_SOUND_PLAYING{
            Settings.baby_sound_isplaying = Constants.BABY_SOUND_UNPLAYING
            //.setImage(UIImage(named: "icon_play"), for: .normal)
            playStatusImageView.image = UIImage(named: "icon_play")
        }
        else{
            
            Settings.baby_sound_isplaying = Constants.BABY_SOUND_PLAYING
            //sender.setImage(UIImage(named: "play_pause"), for: .normal)
            playStatusImageView.image = UIImage(named: "play_pause")
        }
        playSound(item)
        setChildStatus()
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
        itemTitle.text = NSLocalizedString(item.item_title, comment: "")
    }
    @IBAction func prevButtonTapped(_ sender: Any) {
        if selectedIndex == 0{
            selectedIndex = floatingItems.count - 1
        }
        else {
            selectedIndex -= 1
        }
        btnNext.isHidden = false
        Settings.baby_sound_isplaying = Constants.BABY_SOUND_PLAYING
        item = floatingItems[selectedIndex]
        setTitle(item)
        playSound(item)
        setChildStatus()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if selectedIndex == floatingItems.count - 1 {
            //btnNext.isHidden = true
            selectedIndex = 0
        }
        else{
            selectedIndex += 1
        }
        btnPrev.isHidden = false
        Settings.baby_sound_isplaying = Constants.BABY_SOUND_PLAYING
        
        item = floatingItems[selectedIndex]
        setTitle(item)
        playSound(item)
        setChildStatus()
        
        
    }
    
    @IBAction func volumeChanged(_ sender: UISlider) {
        
        (volumeParentView.subviews[0] as! MPVolumeView).volumeSlider.setValue(sender.value / 1000, animated: false)
    
    }
    
    func changeVolumeOutSide(_ sender: UISlider) {
        if !slidernoiseLevel.isTracking {
            slidernoiseLevel.value = sender.value * 1000
        }
    }
    
}



extension MPVolumeView {
    var volumeSlider:UISlider {
        /*self.showsRouteButton = false
        self.showsVolumeSlider = false*/        //self.alpha = 0.0001
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

