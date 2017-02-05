//
//  AppDelegate.swift
//  MASSDK_Swift
//
//  Created by Martin Púčik on 05/05/16.
//  Copyright © 2016 MasterApp. All rights reserved.
//

import UIKit

// Import MASSDK
import MASSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // Create Menu Items
        /*let item1 = MASMenuItem(name: "Item 1", iconImage: UIImage(), target: self, selector: "item1Tapped")
        
        // Init MASManager
        MASManager.setup("YourAppHashString", appId: "appID", trackingIdentifier: "trackindIdentifierYouReceived", menuItems: [item1], releaseServer: true)
        
        // Manually set root view controller
        let navigationController = MASNavigationController(rootViewController: ViewController())*/
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - MASSDK
    func item1Tapped() {
        debugPrint("Item 1 from Menu was tapped.")
    }
}

