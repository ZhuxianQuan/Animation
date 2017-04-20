//
//  AppDelegate.swift
//  Alarm For Children
//
//  Created by Huijing on 24/01/2017.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit
import MASSDK
import AVFoundation



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //variables for audio play
    var player : AVAudioPlayer?
    var isRepeated = false
    var currentPlayerTime : TimeInterval!
    var currentPlayingAudioName = ""
    
    
    
    var soundTimer = Timer()
    static var remainTime = 0
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setMASSDK()
        addObservers()
        //set sleep mode
        UIApplication.shared.isIdleTimerDisabled = true
        
        //location manager define
        
        return true
    }
    
    
    func setMASSDK() {
        
        //MASManager.sharedInstance.menu
        
        let menu_babyRadio = MASMenuItem(name: NSLocalizedString("Baby Radio", comment: ""), iconImage: UIImage(named: "icon_baby_radio")!, target: self, 	selector: "babyRadioTapped")
        
        let menu_soundTimer = MASMenuItem(name: NSLocalizedString("Sound Timer", comment: ""), iconImage: UIImage(named: "icon_sound_timer")!, target: self, 	selector: "soundTimerTapped")
        let menu_babyMode = MASMenuItem(name: NSLocalizedString("Baby Mode", comment: ""), iconImage: UIImage(named: "icon_baby_mode")!, target: self, 	selector: "babyModeTapped")
        let menu_eventLog = MASMenuItem(name: NSLocalizedString("Event Log", comment: ""), iconImage: UIImage(named: "icon_event_log")!, target: self, 	selector: "eventLogTapped")
        let menu_babyTips = MASMenuItem(name: NSLocalizedString("Baby Tips", comment: ""), iconImage: UIImage(named: "icon_baby_tips")!, target: self, 	selector: "babyTipsTapped")
        let menu_skyRattle = MASMenuItem(name: NSLocalizedString("Sky Rattle", comment: ""), iconImage: UIImage(named: "icon_sky_rattle")!, target: self, 	selector: "skyLattleTapped")
        let menu_animalNoise = MASMenuItem(name: NSLocalizedString("Animal Noises", comment: ""), iconImage: UIImage(named: "icon_animal_noise")!, target: self, selector: "animalNoisesTapped")
        
        let menuItems = [menu_babyRadio, menu_soundTimer, menu_babyMode,menu_eventLog,menu_babyTips,menu_skyRattle, menu_animalNoise]
        //let menuGameItems = [menu_skyRattle, menu_animalNoise]
        
        //set menu background color
        MASManager.sharedInstance.menuBackgroundColor = UIColor(colorLiteralRed: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
        //set menu title color
        MASManager.sharedInstance.menuSectionTitlesShow = true
        MASManager.sharedInstance.menuCellFontColor = UIColor.darkGray
        MASManager.sharedInstance.menuHeaderCellFontColor = UIColor.darkGray
        MASManager.sharedInstance.hidePromoBanner = false
        
        MASManager.sharedInstance.menuHeaderCellFontColor = UIColor.darkGray
        
        
        MASManager.sharedInstance.menuCellBackgroundColor = UIColor(colorLiteralRed: 233.0/255.0, green: 236.0/255.0, blue: 236.0/255.0, alpha: 1)//UIColor(colorLiteralRed: 178.0/255.0, green: 204.0/255.0, blue: 229.0/255.0, alpha: 1)
        //MASManager.sharedInstance.menuba
        MASManager.sharedInstance.showMenuHeader = true
        //MASManager.sharedInstance.menuBackgroundColor = UIColor.groupTableViewBackground
        
        MASManager.setup("AppHashYouReceived", appId: "AppIdFromItunesConnect", trackingIdentifier: "3uy4brshqnmzptwdk27jev559gdcbax6", menuItems: menuItems, releaseServer: true)
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let navigationController = MASNavigationController(rootViewController: viewController)
        navigationController.navigationBar.barTintColor = UIColor(colorLiteralRed: 233.0/255.0, green: 236.0/255.0, blue: 236.0/255.0, alpha: 1)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = navigationController
        self.window!.makeKeyAndVisible()
        //MASManager.sharedInstance.setFront(viewController: UIViewController(), animated: true, completion: nil)
        
    }
    
    func addObservers() {
        //add play observers
        
        NotificationCenter.default.addObserver(self, selector: #selector(playAudio(_:)), name: NSNotification.Name(rawValue: Constants.ORDER_PLAY_AUDIO), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pauseAudio), name: NSNotification.Name(rawValue: Constants.ORDER_PAUSE_AUDIO), object: nil)
        
        //add timer observers
        
        NotificationCenter.default.addObserver(self, selector: #selector(startTimer), name: NSNotification.Name(rawValue: Constants.ORDER_TIMER_START), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopTimer), name: NSNotification.Name(rawValue: Constants.ORDER_TIMER_STOP), object: nil)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        if soundTimer.isValid{
            soundTimer.invalidate()
            if AppDelegate.remainTime == 0 {
                pauseAudio()
            }
            else {
                activateTimer()
            }
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        if soundTimer.isValid{
            soundTimer.invalidate()
            if AppDelegate.remainTime == 0 {
                pauseAudio()
            }
            else {
                activateTimer()
            }
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.APP_DID_ENTER_FOREGROUND), object: nil, userInfo: nil)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func babyRadioTapped(){
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        MASManager.sharedInstance.setFront(viewController: viewController, animated: true, completion: nil)

    }
    
    func soundTimerTapped(){
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SoundTimerViewController") as! SoundTimerViewController
        MASManager.sharedInstance.setFront(viewController: viewController, animated: true, completion: nil)
    
    }
    func babyModeTapped(){
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "BabyModeViewController") as! BabyModeViewController
        MASManager.sharedInstance.setFront(viewController: viewController, animated: true, completion: nil)
    }
    func eventLogTapped(){

        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "EventLogViewController") as! EventLogViewController
        MASManager.sharedInstance.setFront(viewController: viewController, animated: true, completion: nil)
    }
    func babyTipsTapped(){
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "BabyTipsViewController") as! BabyTipsViewController
        MASManager.sharedInstance.setFront(viewController: viewController, animated: true, completion: nil)

    }
    func skyLattleTapped(){
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SkyRattleViewController") as! SkyRattleViewController
        pauseAudio()
        MASManager.sharedInstance.setFront(viewController: viewController, animated: true, completion: nil)

    }
    func animalNoisesTapped(){
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AnimalNoisesViewController") as! AnimalNoisesViewController
        pauseAudio()
        MASManager.sharedInstance.setFront(viewController: viewController, animated: true, completion: nil)
    }    
    
}

extension AppDelegate : AVAudioPlayerDelegate{
    
    func playAudio(_ notification: Notification) {
        
        guard let filename = notification.userInfo?[Constants.KEY_AUDIO_FILENAME] else {
            return
        }
        
        if player != nil && (player?.isPlaying)! {
            if currentPlayingAudioName == filename as! String{
                return
            }
            else
            {
                player?.pause()
                let event = EventModel()
                event.eventTime = getGlobalTime()
                event.eventType = EventModel.EVENT_SOUND_STOP
                event.eventContent = NSLocalizedString(currentPlayingAudioName, comment: "") + NSLocalizedString(" stopped by User", comment: "")
                SetDataToFMDB.saveEvent(event)
            }
        }
        if currentPlayingAudioName == filename as! String{
            player?.play()
            if !isRepeated {
                let event = EventModel()
                event.eventTime = getGlobalTime()
                event.eventType = EventModel.EVENT_SOUND_START
                event.eventContent = NSLocalizedString(currentPlayingAudioName, comment: "") + NSLocalizedString(" started by User", comment: "")
                
                SetDataToFMDB.saveEvent(event)
            }
            isRepeated = false
            return
        }
        
        currentPlayingAudioName = filename as! String
        
        if !isRepeated {
            let event = EventModel()
            event.eventTime = getGlobalTime()
            event.eventType = EventModel.EVENT_SOUND_START
            event.eventContent = NSLocalizedString(currentPlayingAudioName, comment: "") + NSLocalizedString(" started by User", comment: "")
            
            SetDataToFMDB.saveEvent(event)
        }
        isRepeated = false
        
        
        guard let audioFileUrlString = Bundle.main.path(forResource: "sound_" + currentPlayingAudioName.lowercased().replacingOccurrences(of: " ", with: "_") + ".wav", ofType: nil) else {
            return
        }
        guard let url = URL(string: audioFileUrlString) else {
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            guard let player = player else { return }
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.duckOthers)

            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    
    
    func pauseAudio() {
        if player != nil {
            currentPlayerTime = player?.currentTime
            player?.pause()
            let event = EventModel()
            event.eventTime = getGlobalTime()
            event.eventType = EventModel.EVENT_SOUND_STOP
            event.eventContent = currentPlayingAudioName + " stopped by User"
            SetDataToFMDB.saveEvent(event)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.ORDER_PAUSE_AUDIO_BYTIMER), object: nil)
        }
    }
    
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        let userInfo = [Constants.KEY_AUDIO_FILENAME : currentPlayingAudioName]
        isRepeated = true
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.ORDER_PLAY_AUDIO), object: nil, userInfo: userInfo)
    }
}


extension AppDelegate {
    
    func startTimer(){
        //if soundTimer
        if soundTimer.isValid {
            soundTimer.invalidate()
        }
        activateTimer()
    }
    
    func activateTimer() {
        if AppDelegate.remainTime > 0{
            soundTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerUpdated), userInfo: nil, repeats: true)
        }
    }
    
    func timerUpdated() {
        AppDelegate.remainTime -= 1
        NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.ORDER_REMAINTIME_CHANGED), object: nil)
        if AppDelegate.remainTime == 0{
            stopTimer()
            Settings.baby_sound_isplaying = Constants.BABY_SOUND_UNPLAYING
            pauseAudio()
        }
    }
    
    
    func stopTimer(){
        AppDelegate.remainTime = 0
        soundTimer.invalidate()
        //Settings.baby_sound_isplaying = Constants.BABY_SOUND_UNPLAYING
        //pauseAudio()
    }
    
    
    
    
}

