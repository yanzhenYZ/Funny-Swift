//
//  AboutManageViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/21.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit
import LocalAuthentication

class AboutManageViewController: UIViewController {

    private var lockView: NumLockView!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.managePasswordIsRight), name: PASSWORDISRIGHT, object: nil);
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default);
        self.navigationController?.navigationBar.shadowImage = nil;
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Manage";
        lockView = NumLockView(frame: CGRectZero);
        lockView.backgroundColor = FunnyManager.manager.color(29.0, G: 50.0, B: 55.0);
        lockView.smallViewBorderColor = FunnyManager.manager.color(93.0, G: 187.0, B: 210.0);
        lockView.btnBorderColor = FunnyManager.manager.color(93.0, G: 187.0, B: 210.0);
        lockView.onlyOnePW = true;
        
//        //self
        lockView.password = self.passwordString();
        
        self.view.addSubview(lockView);
        
        let context = LAContext();
        if context.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: nil) {
            let vc = AboutMPViewController(nibName: "AboutMPViewController", bundle: nil);
            unowned let blockSelf = self
            context.evaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, localizedReason: NSLocalizedString("Touch ID密码", comment: ""), reply: { (success, error) in
                if success {
                    dispatch_async(dispatch_get_main_queue(), { 
                        blockSelf.navigationController?.pushViewController(vc, animated: true);
                    })
                }else{
                    if Int32(error!.code) == kLAErrorUserFallback {
                        //
                    }else if Int32(error!.code) == kLAErrorUserCancel {
                        //手动取消
                    }else{
                        //失败
                    }
                }
            })
        }
        
    }

    func managePasswordIsRight() {
        let vc = AboutMPViewController(nibName: "AboutMPViewController", bundle: nil);
        self.navigationController?.pushViewController(vc, animated: true);
    }

    private func passwordString() ->String {
        let format = NSDateFormatter();
        format.dateFormat = "yy";
        let str1 = format.stringFromDate(NSDate());
        
        format.dateFormat = "dd";
        let str2 = format.stringFromDate(NSDate());
        
        return str1 + str2;
    }
}
