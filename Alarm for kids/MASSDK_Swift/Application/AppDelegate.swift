//
//  AppDelegate.swift
//  Alarm For Children
//
//  Created by Huijing on 24/01/2017.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit
import MASSDK



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.


        //MASManager.sharedInstance.menu
        let menu_babyRadio = MASMenuItem(name: "Baby Radio", iconImage: UIImage(named: "icon_baby_radio")!, target: self, 	selector: "babyRadioTapped")

        let menu_soundTimer = MASMenuItem(name: "Sound Timer", iconImage: UIImage(named: "icon_sound_timer")!, target: self, 	selector: "soundTimerTapped")
        let menu_babyMode = MASMenuItem(name: "Baby Mode", iconImage: UIImage(named: "icon_baby_mode")!, target: self, 	selector: "babyModeTapped")
        let menu_eventLog = MASMenuItem(name: "Event Log", iconImage: UIImage(named: "icon_event_log")!, target: self, 	selector: "eventLogTapped")
        let menu_babyTips = MASMenuItem(name: "Baby Tips", iconImage: UIImage(named: "icon_baby_tips")!, target: self, 	selector: "babyTipsTapped")
        let menu_skyRattle = MASMenuItem(name: "Sky Rattle", iconImage: UIImage(named: "icon_sky_rattle")!, target: self, 	selector: "skyLattleTapped")
        let menu_animalNoise = MASMenuItem(name: "Animal Noises", iconImage: UIImage(named: "icon_animal_noise")!, target: self, selector: "animalNoisesTapped")

        let menuItems = [menu_babyRadio, menu_soundTimer, menu_babyMode,menu_eventLog,menu_babyTips,menu_skyRattle, menu_animalNoise]
        //let menuGameItems = [menu_skyRattle, menu_animalNoise]

        //set menu background color
        MASManager.sharedInstance.menuBackgroundColor = UIColor(colorLiteralRed: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
        //set menu title color
        MASManager.sharedInstance.menuCellFontColor = UIColor.darkGray
        MASManager.sharedInstance.menuHeaderCellFontColor = UIColor.darkGray
        MASManager.sharedInstance.hidePromotions = false

        MASManager.sharedInstance.menuHeaderCellFontColor = UIColor.darkGray
        
    
        MASManager.sharedInstance.menuCellBackgroundColor = UIColor(colorLiteralRed: 233.0/255.0, green: 236.0/255.0, blue: 236.0/255.0, alpha: 1)//UIColor(colorLiteralRed: 178.0/255.0, green: 204.0/255.0, blue: 229.0/255.0, alpha: 1)
        //MASManager.sharedInstance.menuba
        MASManager.sharedInstance.showMenuHeader = true
        //MASManager.sharedInstance.menuBackgroundColor = UIColor.groupTableViewBackground
        
        MASManager.setup("AppHashYouReceived", appId: "AppIdFromItunesConnect", trackingIdentifier: "ProvidedTrackingIdentifier", menuItems: menuItems, releaseServer: true)
        MASManager.setup("AppHashYouReceived", appId: "AppIdFromItunesConnect", trackingIdentifier: "ProvidedTrackingIdentifier", menuItems: menuItems, releaseServer: true)
        

        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let navigationController = MASNavigationController(rootViewController: viewController)
        navigationController.navigationBar.barTintColor = UIColor(colorLiteralRed: 233.0/255.0, green: 236.0/255.0, blue: 236.0/255.0, alpha: 1)

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = navigationController
        self.window!.makeKeyAndVisible()
        //MASManager.sharedInstance.setFront(viewController: UIViewController(), animated: true, completion: nil)

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
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
        MASManager.sharedInstance.setFront(viewController: viewController, animated: true, completion: nil)

    }
    func animalNoisesTapped(){
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AnimalNoisesViewController") as! AnimalNoisesViewController
        MASManager.sharedInstance.setFront(viewController: viewController, animated: true, completion: nil)
    }
    
    
}

