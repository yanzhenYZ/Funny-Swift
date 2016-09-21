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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        NotificationCenter.default.addObserver(self, selector: #selector(self.netStatusChange), name: NSNotification.Name.reachabilityChanged, object: nil);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.reachabilityChanged, object: nil);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configSuperUI();
    }
    
    func configSuperUI() {
        let superBtn = UIButton(type: UIButtonType.system);
        superBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 40);
        let imageS = UIImage(named: "weibo_profile_s")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
        superBtn.setImage(imageS, for: UIControlState());
        superBtn.addTarget(self, action: #selector(self.aboutMy), for: UIControlEvents.touchUpInside);
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
            hud?.labelColor = UIColor.red;
            hud?.hide(true, afterDelay: 2.0);
        }
    }
}
