//
//  AboutModifyAreaViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/22.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class AboutModifyAreaViewController: UIViewController,LockViewProtocol {

    @IBOutlet fileprivate weak var lockView: LockView!
    fileprivate var num: Int! = 0
    fileprivate var passordStr: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        lockView.delegate = self;
    }

    @IBAction func Restart(_ sender: AnyObject) {
        num = 0;
    }
    
    func lockPasswordString(_ password: String) {
        if num == 0 {
           passordStr = password;
            num = 1;
        }else{
            if passordStr == password {
                num = 100;
                
                let alert = UIAlertController(title: "恭喜", message: "密码修改成功", preferredStyle: UIAlertControllerStyle.alert);
                let cancel = UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel, handler: { (cancel) in
                    if self.num == 100 {
                        self.num = 0;
                        UserDefaults.standard.set(self.passordStr, forKey: AREAPASSWORD);
                        UserDefaults.standard.synchronize();
                        self.dismiss(animated: true, completion: nil);
                    }
                });
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil);
            }else{
                num = 0;
                let alert = UIAlertController(title: "警告", message: "两次密码不同，请重新开始", preferredStyle: UIAlertControllerStyle.alert);
                let cancel = UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel, handler: { (cancel) in
                    
                });
                alert.addAction(cancel);
                self.present(alert, animated: true, completion: nil);
            }
        }
        
    }
    
    @IBAction func exitVC(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil);
    }
    
}
