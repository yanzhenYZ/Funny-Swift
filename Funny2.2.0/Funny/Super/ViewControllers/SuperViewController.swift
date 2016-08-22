//
//  SuperViewController.swift
//  Funny
//
//  Created by yanzhen on 16/4/6.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit
import AudioToolbox

class SuperViewController: UIViewController {

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.netStatusChange), name: kReachabilityChangedNotification, object: nil);
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kReachabilityChangedNotification, object: nil);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configSuperUI();
    }
    
    func configSuperUI() {
        let superBtn = UIButton(type: UIButtonType.System);
        superBtn.frame = CGRectMake(0, 0, 40, 40);
        let imageS = UIImage(named: "weibo_profile_s")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        superBtn.setImage(imageS, forState: UIControlState.Normal);
        superBtn.addTarget(self, action: #selector(self.aboutMy), forControlEvents: UIControlEvents.TouchUpInside);
        let superRightItem = UIBarButtonItem(customView: superBtn);
        self.navigationItem.rightBarButtonItem = superRightItem;
    }
    
    func aboutMy() {
        let vc = AboutMyViewController();
        vc.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    func netStatusChange() {
        let netStatus = appDelegate.netStatus();
        if netStatus != ReachableViaWiFi {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            let hud = MBProgressHUD.showMessage("WIFI中断,请退出程序");
            hud.labelColor = UIColor.redColor();
            hud.hide(true, afterDelay: 2.0);
        }
    }
}
