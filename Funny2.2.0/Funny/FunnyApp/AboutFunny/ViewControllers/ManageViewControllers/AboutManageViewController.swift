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

    fileprivate var lockView: NumLockView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        NotificationCenter.default.addObserver(self, selector: #selector(self.managePasswordIsRight), name: NSNotification.Name(rawValue: PASSWORDISRIGHT), object: nil);
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default);
        self.navigationController?.navigationBar.shadowImage = nil;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self);
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Manage";
        lockView = NumLockView(frame: CGRect.zero);
        lockView.backgroundColor = FunnyManager.manager.color(29.0, G: 50.0, B: 55.0);
        lockView.smallViewBorderColor = FunnyManager.manager.color(93.0, G: 187.0, B: 210.0);
        lockView.btnBorderColor = FunnyManager.manager.color(93.0, G: 187.0, B: 210.0);
        lockView.onlyOnePW = true;
        
//        //self
        lockView.password = self.passwordString();
        
        self.view.addSubview(lockView);
        
        let context = LAContext();
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            let vc = AboutMPViewController(nibName: "AboutMPViewController", bundle: nil);
            unowned let blockSelf = self
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: NSLocalizedString("Touch ID密码", comment: ""), reply: { (success, error) in
                if success {
                    DispatchQueue.main.async(execute: { 
                        blockSelf.navigationController?.pushViewController(vc, animated: true);
                    })
                }else{
                    if Int32(error!._code) == kLAErrorUserFallback {
                        //
                    }else if Int32(error!._code) == kLAErrorUserCancel {
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

    fileprivate func passwordString() ->String {
        let format = DateFormatter();
        format.dateFormat = "yy";
        let str1 = format.string(from: Date());
        
        format.dateFormat = "dd";
        let str2 = format.string(from: Date());
        
        return str1 + str2;
    }
}
