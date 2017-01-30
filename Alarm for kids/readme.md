# 📖 MASSDK framework 3.0.12

This is Swift 3 build of MASSDK, radmefile not fully updated, please use common sense and new Swift 3 syntax.

## Requirements

- iOS 8.0 and higher
- [`CryptoSwift`](https://github.com/krzyzanowskim/CryptoSwift) library - we recommend to use `Cocoapods` to integrate this library in your project ( add `pod 'CryptoSwift'` into your `Podfile` ) 
- - [`SnapKit`](https://github.com/SnapKit/SnapKit) library - we recommend to use `Cocoapods` to integrate this library in your project ( add `pod 'SnapKit'` into your `Podfile` ) 


### Data requirements for MASSDK setup

* Hash string of your app -> provided by Us
* App ID from iTunes Connect -> for debug purposes use string `appID`
* Tracking Identifier string -> provided by Us

###Change log
For more info read the whole document.

* 3.0.12:
    * `MASManager.sharedInstance.hideRegistration: Bool` Set this to true to disable login/registration popup window after inapp purchase

* 3.0.11:
    * storeVC button disabled state changed to enabled. Button was disabled before price was loaded, but apple has a problem with this.

* 3.0.10: 
    * inside bug fix, url request could fail

* 3.0.9:
    * new error description for users, to make registering better.
    * tweaks in store VC, if the price is not loaded, buttons are inactive.

* 3.0.8:
	* setFront method changed. Added completion call, please, do next things after the completion is done. Easy usage: 
```
MASManager.sharedInstance.setFront(viewController: someViewController, animated: true, completion: {
    doSomething() //load add maybe?
})
```

	* `menuOpened: Bool` added. Before displaying ADS, please check that Hamburger menu is not opened like this: if (!MASManager.sharedInstance.menuOpened) { }

* 3.0.7:
    * open new VC with hamburger navigation controller still active also from obj-c `[MASManager sharedInstance] setFrontWithViewController: viewController];`

* 3.0.6:
    * bug fix, about could crash if the server data were not complete

* 3.0.5:
    * NEW convinient functions!
    * use `MASManager.sharedInstance.setFront(viewController: ViewController())` to open new menu item and still show the hamburger menu
    * use `MASManager.sharedInstance.showStoreView()` to open MAS store view controller

* 3.0.4: 
    * Update for new XCode 8.1 (Swift 3.0.1 would not open old SDK built in 3.0)

* 3.0.3: 
    * Framework build for simulator! Yay!
    * Bugfix, About VC could crash if the received data were not correct.

* 3.0.2:
    * MASManager.sharedInstance.setup() method changed back to MASManager.setup(), please edit your source code in AppDelegate file
    * Bug fix where user transaction was not saved properly after user logges in with MasterAppID after inapp purchase after guideViewController opened.

* 3.0:
    * Status bar color can be changed in Hamburger menu. use MASManager.sharedInstance.statusBarColor = UIColor()

* NEW SWIFT 3:
	* Please, don't forget that documentation is not edited yet for new SDK. There are no example projects yet. Usage should be the same as old Swift 2 code.

* 0.4.1-3:
    * Forgot password option in login screen added.

* 0.4.0:
    * Started adding accessibility labels, to be used in UI testing.

* 0.3.48:
    * Fixed bug where app might crash after opening Menu while internet connection was temporary unavailable.

* 0.3.47:
    * Added call MASManager.sharedInstance.loginWithKeychain(completion: (succes: Bool, error: NSError?)->()) for developers to be able to re-login user and refresh token (0.3.44), login details are deleted if user logs out.

* 0.3.45-46:
    * Fixed bug where app might crash while setting custom font in objC due to XCode swift optimization bug.

* 0.3.44:
    * MASManager.getToken() -> String? function added.
    * MASManager.sharedInstance.baseAddress changed to public

* 0.3.43:
    * Maintenance release

* 0.3.42:
    * Notification is sent after user buys IAP succesfully through MAS SDK store view controller

* 0.3.41:
	* Reade updated. New code snippet of initial setup. (Chapter Usage, point 4)
	* MASIAPManager is accesible now
	* Bug fix: Promotion banner could become inactive and had no buttons to close.
	* After user log in, there is new notification posted.

* 0.3.40:
    * Menu Header Image was displayed in the status bar. Moved down, so status bar is not covering the image/banner any more.

* 0.3.38:
    * Small edits.

* 0.3.37:
    * After buing product, guidePostVC is shown instead of registrationVC

* 0.3.36:
	* `MASManager setup` added `Bool` for `releaseServer`. Set this to `true`.
	* Registration and Login screen. You can show login or registration guidepost screen by calling `MASManager.sharedInstance.showGuideWithMasterTouchView()` and login only by calling `MASManager.sharedInstance.loginUserWithMasterTouchLoginView()`
	* Bug fix: AboutVC could crash if there was no displayed adds and MasterTouchLogo was turned off.


## Installation

1. Add [`CryptoSwift`](https://github.com/krzyzanowskim/CryptoSwift) in to your project. We recommend using `Cocoapods`
2. Add [`SnapKit`](https://github.com/SnapKit/SnapKit) in to your project. We recommend using `Cocoapods`
3. Use this repository `https://gitlab.com/MAS_SDK/massdk.git` as submodule for your project. ( `git submodule add https://gitlab.com/MAS_SDK/massdk.git`)
4. Add `MASSDK.framework` from submodule repository to your project bundle.
5. Add `MASSDK.framework` to Embedded Binaries for your target.

	![](Assets/Screen3.png)

5. Set Embedded Content Contains Swift Code to **`Yes`** in your target Build Settings

	![](Assets/Screen4.png)



### Example projects

In folder `Examples` you can find `Swfit` and `Obj-C` example projects with imported `MASSDK.framework` and working setup.

## Usage

There are few steps to do, before the MASSDK framework is ready to work.

#### Setup

1. Import MASSDK Framework into your `AppDelegate.swift` or `AppDelegate.m`

	Swift: `import MASSDK`
	
	Obj-C: `#import <MASSDK/MASSDK-Swift.h>`

2. Create custom shortcuts for your app

	Swift:

	`let shortcut = MASMenuItem(name: "Shortcut", iconImage: UIImage(named: "Shortcut"), target: self, 	selector: "shortcutTapped")`

	`let shortcut2 = MASMenuItem(name: "Shortcut 2", iconImage: UIImage(named: "Shortcut2"), target: self, selector: "shortcut2Tapped")`

	Obj-C
	
	`MASMenuItem *shortcut = [[MASMenuItem alloc]initWithName:@"Shortcut" iconImage:[UIImage named:@"Shortcut"] target:self selector:@"shortcutTapped"];
`

	`MASMenuItem *shortcut2 = [[MASMenuItem alloc]initWithName:@"Shortcut 2" iconImage:[UIImage named:@"Shortcut2"] target:self selector:@"shortcut2Tapped"];
`
	
3.	Setup `MASManager` in your AppDelegate

	Swift:

	`MASManager.setup("AppHashYouReceived", appId: "AppIdFromItunesConnect", trackingIdentifier: "ProvidedTrackingIdentifier", menuItems: [shortcut, shortcut2], releaseServer: true)`
	
	Obj-C:
	
	`[MASManager setup:@"AppHashYouReceived" appId: @"AppIdFromItunesConnect" trackingIdentifier: @"ProvidedTrackingIdentifier" menuItems: @[shortcut1, shortcut2] releaseServer:YES];
`
	
	- where you will be providied with from us `AppHashYouReceived`
	- where you can use string `"appID"` (or `@"appID"` for Obj-C) for testing purposes for `AppIdFromItunesConnect` 
	- where `ProvidedTrackingIdentifier` is ID you will be provided
	- `releaseServer` 
      * For Fiverr: set to `true` or `YES`
      * For Master developers: should be set to `false` or `NO` and before releasing application has to be set to `true` or `YES`
	

4. Embed your Initial View Controller in subclass of `MASNavigationController`. 

- You can do it from code like this:

	Swift:
	
	`let navigationController = MASNavigationController(rootViewController: YourViewController())`
	
	Obj-C:
	
	`MASNavigationController *navigationController = [[MASNavigationController alloc] initWithRootViewController: [YourViewController new]];
`
The final code should look like this:

	Swift: `AppDelegate.swift`
	
	```
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {  
	      
        MASManager.setup("AppHashYouReceived", appId: "AppIdFromItunesConnect", trackingIdentifier: "ProvidedTrackingIdentifier", menuItems: [], releaseServer: true)    
            
        let viewController = ViewController()
        let navigationController = MASNavigationController(rootViewController: viewController)        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.rootViewController = navigationController
        self.window!.makeKeyAndVisible()
        return true 
        }
	```      
	Obj-C: `AppDelegate.m`

	```	
	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [MASManager setup:@"AppHashYouReceived" appId: @"AppIdFromItunesConnect" trackingIdentifier: @"ProvidedTrackingIdentifier" menuItems: @[] releaseServer:YES];
    
    ViewController* vc = [[ViewController alloc] init];
    UINavigationController *navController;
    navController = [[MASNavigationController alloc]initWithRootViewController:vc];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    return YES;
	}
	```        

- or in your Storyboard file just Embed your Initial View Controller in UINavigationController and subclass it in `MASNavigationController` class.
	
![](Assets/Screen1.png)
		
		
- and in `Indentity Inspector` you set up class for UINavigationController:
	
![](Assets/Screen2.png)	
	
----


#### Navigation in menu

If you need to open new menu item and still see hamburger menu on the new opened screen, use 

Swift:

```
MASManager.sharedInstance.setFront(viewController: UIViewController(), animated: Bool? = true, completion: (()->())?)
```

Obj-C:

```
   [[MASManager sharedInstance] setFrontWithViewController:someViewController completion:^{
        //completionCode
    }];
```

This will do custom transition from one ViewController to new ViewController, using our custom transition, you can turn of the transition by setting `animated: false`

#### Customization

You can customize following parts of `MASSDK`


##### Menu Colors

`MASManager.sharedInstance.statusBarColor` ➡️ Status bar color in hamburger menu, if not set, its clear

`MASManager.sharedInstance.menuBackgroundColor` ➡️ Menu Background Color

`MASManager.sharedInstance.menuCellBackgroundColor` ➡️ Menu Cell Background Color

`MASManager.sharedInstance.menuCellFontColor` ➡️ Font Color in Menu Cell

`MASManager.sharedInstance.menuCellFont` ➡️ Font in Menu Cell

`MASManager.sharedInstance.menuHeaderCellFont` ➡️ Font in Menu Section Header (e.g. Quick links)

`MASManager.sharedInstance.menuHeaderCellFontColor` ➡️ Font Color in Menu Section Header

----

##### Menu Header Image

`MASManager.sharedInstance.showMenuHeader` ➡️ This flag will show/hide Header Image in Menu. This is implicitly set to `false`. Change this if you have been provided with Header Image.

----

##### Master Touch App

`MASManager.sharedInstance.isMasterTouch` ➡️ If you have been instructed that your app is not going to be released under Master Touch, set this to `false`.

----

##### Custom About Navigation Controller

To customize `UINavigationController` in About page, you need to set:

* `MASManager.sharedInstance.customAboutNavigation` to `true`

You can customize colors and font by setting these properties:

* `MASManager.sharedInstance.navigationBarColor`
* `MASManager.sharedInstance.navigationBarTintColor`
* `MASManager.sharedInstance.navigationBarTitleColor`
* `MASManager.sharedInstance.navigationBarTitleFont`


----

#### Naming Conventions

Following names were used for naming graphical assets inside MASSDK. If you want to or you were instructed to change default images of Menu or About page, please, name your images according this conventions and add images to your's app bundle.

- About Icon: `MASAbout`
- Menu Icon: `MASMenu`
- Rate Icon: `MASRate`
- Share Icon: `MASShare`
- Menu Header Image: `MASHeader`
- Logo in About: `MASLogo`
- Promotion Image: `MASTesla`


----
# Ads

If you are showing full screen advertisment, always make sure the menu is not opened at that given time!

You can get this information from
Swift:

```
MASManager.sharedInstance.menuOpened: Bool
```

Obj-C: 

```
[MASManager sharedInstance].menuOpened : Bool
```

`menuOpened` is `true` when the menu is shown, you can only show ad when the `menuOpened` is `false`.

# Reacting for MASSDK Events

**MASSDK** needs embeding app to react for multiple messages to work correctly. Please implement these as follows: 

## Promotions

**MASSDK** may show an promotion banner in Side Menu. After user decide to enter promotion purchase, following message will be invoked:

`MASNotification.PromoBuy`

Please, add an observer for this notification, like:

* Swift
	`NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HandlerClass.promoBuyTapped), name: MASNotification.PromoBuy.rawValue, object: nil)`

* Obj-C 
	`[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(promoBuyTapped:) name:@"MASPromoBuyNotification" object:nil];`

As a reaction to this notification, show a new `ViewController` to user with In-App purchase. 

## In-App purchases

MASSDK provides a complete flow of in-app purchase. You can use this flow by setting:

* Swift
	* `MASManager.sharedInstance.inAppIdentifier = "cz.master.inAppID"`
	* `MASManager.sharedInstance.inAppInfoText = "Info text"`
* Obj-C
	* `[MASManager sharedInstance].inAppIdentifier = @"cz.master.inAppID";`
	* `[MASManager sharedInstance].inAppInfoText = @"Info text";`

This ensures that the correct behaviour will happen after you click on the banner and select BUY button. But you also have to give user a chance to get into the storeViewController somewhow else. (eg. a button in settings or tab bar.)

* Swift
	
	```
	MASManager.sharedInstance.showStoreView()
	```

* Obj-C:

	```
	[MASManager sharedInstance] showStoreView];
	```
	

If you need to implement custom In-app flow, keep reading.

In-App purchases are supposed to run in separate `ViewController` (let's say `StoreViewController`).

You will need In-App product identifier (String).

1. First, initialize MASIAPManager
	* `MASIAPManager(withIdentifier productIdentifier: String, withDelegate delegate: MASIAPManagerDelegate)`
2. Get In-App product price
	* `iapManager.getPrice()`
	* `MASIAPManagerDelegate` has 2 delegate methods to serve you an response:
		*   `func didLoadPriceForProduct(localePriceString: String)`
    	*	`func didFailToLoadProductPrice(withError error: NSError)`
3. Call buy product method in MASIAPManager after user's Buy Button tap
	* `iapManager.buyProduct()`
	* `MASIAPManagerDelegate` has 2 delegate methods to serve you state of In-App purchase:
		*  `func transactionFailed()` - In-App purchase failed. Show fail alert to user.
    	*	`func transactionSucceeded()` - In-App purchase was successfull. You need to show the registration/login view in this method. (see below)

###### Restore Purchases
Due to Apple requirement, all _non-consumable_ In-Apps must include __Restore Purchases__ button. To restore purchases, call:

* `iapManager.restorePurchase()`
	* `MASIAPManagerDelegate` has a delegate method to serve you state of In-App restore:
		* `func nothingToRestore()`
	* Successfull or failed state are served trought these methods:
		*  `func transactionFailed()` - In-App restore failed. Show fail alert to user.
    	*	`func transactionSucceeded()` - In-App restore was successfull. You need to show the registration/login view in this method. (see below)
	
	
## Handling User Login/Registration

If you need to login or register user, you have to use our methods to open Login screen or GuidePost screen like this:

* Swift
	* login or register: `MASManager.sharedInstance.showGuideWithMasterTouchView()`
	* login: `MASManager.sharedInstance.loginUserWithMasterTouchLoginView()`
* Obj-C
	`TODO`
	
After user is succesfully logged in or registered there is notification posted so you can react. (For example to check user state and update UI accordingly)

* Swift:
	`NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didLogIn), name: MASNotification.UserLoggedIn.rawValue, object: nil)`
	
* Obj-C:
	`[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLogIn:) name:@"MASUserLoggedIn" object:nil];`

There is also similar notification after user paid the application:

* Swift:
    `... name: MASNotification.UserPaid.rawValue ...`

* Obj-C:
    `... name:@"MASUserLoggedIn" ...`

## Author

MasterApp Solutions
