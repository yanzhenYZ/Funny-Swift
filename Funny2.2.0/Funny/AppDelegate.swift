//
//  AppDelegate.swift
//  Funny
//
//  Created by yanzhen on 16/4/5.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit
//wxe3eede5106905cd7
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var videoWindow: VideoWindow!
    var reachability: Reachability?

    func showVideoWindow() {
        videoWindow.makeKeyAndVisible();
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow.init();
//        window?.windowLevel = UIWindowLevelAlert;
        window?.backgroundColor = UIColor.white;
        videoWindow = VideoWindow();
        videoWindow.backgroundColor = UIColor.clear;
        videoWindow.windowLevel = UIWindowLevelAlert + 1;
        
        let vc = RootViewController();
        let nvc = ExtentNavigationViewController(rootViewController:vc);
        window?.rootViewController = nvc;
        window?.makeKeyAndVisible();
        //
        WXApi.registerApp("wxe3eede5106905cd7");
        self.configUI();
        self.net();
        self.set3DTouch();
        return true
    }
    
    fileprivate func set3DTouch() {
        //icon决定了3DTouch文字所在的方向(左右)，不可以直接传空
        //let icon = UIApplicationShortcutIcon(templateImageName: "");
        let icon3 = UIApplicationShortcutIcon(type: .play);
        let icon2 = UIApplicationShortcutIcon(type: .captureVideo);
        let icon1 = UIApplicationShortcutIcon(type: .shuffle);
        let block : (String,UIApplicationShortcutIcon) -> UIApplicationShortcutItem = {title,icon in
            return UIApplicationShortcutItem(type: title, localizedTitle: title, localizedSubtitle: "", icon: icon, userInfo: nil);
        }
        let itemArray = [block("扫描二维码",icon1),block("内涵段子",icon2),block("快手",icon3)];
        UIApplication.shared.shortcutItems = itemArray;
    }
    
    fileprivate func configUI() {
        let appearance = UINavigationBar.appearance();
        appearance.tintColor = FunnyColor;
        appearance.titleTextAttributes = [NSForegroundColorAttributeName : FunnyColor];
    }
    
    fileprivate func net() {
        self.reachability = Reachability.forInternetConnection();
        self.reachability?.startNotifier();
    }
    
    func netStatus() -> NetworkStatus {
        return self.reachability!.currentReachabilityStatus();
    }
    
//MARK set get
    //    var text: String? {
    //        get {
    //            return label.text
    //        }
    //
    //        set {
    //            label.text = newValue
    //        }
    //    }
    
//MARK get
    //    var text: String {
    //        return label.text;
    //    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        FunnyManager.manager.clearMemory();
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        var vc: UIViewController?;
        if shortcutItem.type == "扫描二维码" {
            vc = QRStartScanViewController(isFromWindow: true);
        }else if shortcutItem.type == "快手"{
            vc = GifShowTabBarViewController();
        }else if shortcutItem.type == "内涵段子"{
            vc = ContentTabBarViewController();
        }
        if window?.rootViewController?.presentedViewController != nil {
            window?.rootViewController?.presentedViewController!.present(vc!, animated: true, completion: nil);
        }else{
            window?.rootViewController?.present(vc!, animated: true, completion: nil);
        }
    }
}

