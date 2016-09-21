//
//  NoteLockViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/18.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit
import LocalAuthentication

class NoteLockViewController: SuperSecondViewController {

    fileprivate var lockView: NumLockView!
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.notePasswordIsRight), name: NSNotification.Name(rawValue: PASSWORDISRIGHT), object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.notePasswordIsWrong), name: NSNotification.Name(rawValue: PASSWORDISWRONG), object: nil);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self);
    }
    override func viewDidLoad() {
        
        self.title = "备忘录";
        // Do any additional setup after loading the view.
        lockView = NumLockView(frame: CGRect.zero);
        lockView.backgroundColor = FunnyManager.manager.color(40.0, G: 34.0, B: 37.0);
        lockView.smallViewBorderColor = FunnyManager.manager.color(89.0, G: 76.0, B: 102.0);
        lockView.btnBorderColor = FunnyManager.manager.color(89.0, G: 76.0, B: 102.0);
        
        let pwStr = UserDefaults.standard.object(forKey: NOTEPASSWORD) as? String;
        if pwStr != nil {
            lockView.password = pwStr;
        }
        self.view.addSubview(lockView);
        super.viewDidLoad()
        
        let context = LAContext();
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            let vc = NoteShowViewController(nibName: "NoteShowViewController", bundle: nil);
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

    func notePasswordIsRight() {
        let vc = NoteShowViewController(nibName: "NoteShowViewController", bundle: nil);
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    func notePasswordIsWrong() {
        
    }
   
}
let NOTEPASSWORD = "notePassword";
