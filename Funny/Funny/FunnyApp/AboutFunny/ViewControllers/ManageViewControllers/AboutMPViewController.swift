//
//  AboutMPViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/22.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class AboutMPViewController: UIViewController {

    fileprivate var segment: UISegmentedControl!
    @IBOutlet fileprivate weak var sureBtn: UIButton!
    @IBOutlet fileprivate weak var textField2: YZTextField!
    @IBOutlet fileprivate weak var textField1: YZTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configUI();
        
    }

    @IBAction func sureBtnClick(_ sender: AnyObject) {
        if textField1.text!.isEmpty || textField2.text!.isEmpty {
            return ;
        }
        if strlen(textField1.text!) == 4 && strlen(textField2.text!) == 4 {
            if textField1.text == textField2.text {
                let alert = UIAlertController(title: "恭喜", message: "密码修改成功", preferredStyle: UIAlertControllerStyle.alert);
                let cancel = UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel, handler: { (cancel) in
                    let user = UserDefaults.standard;
                    user.set(self.textField1.text, forKey: NOTEPASSWORD);
                    user.synchronize();
                    self.view.endEditing(true);
                    self.textField1.text = "";
                    self.textField2.text = "";
                });
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil);
                return;
            }
        }
        
        let alert = UIAlertController(title: "警告", message: "密码格式不正确", preferredStyle: UIAlertControllerStyle.alert);
        let cancel = UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel, handler: { (cancel) in
            self.textField1.text = "";
            self.textField2.text = "";
        });
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil);
    }
    
    func segmentAction(_ segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 1 {
            let vc = AboutModifyAreaViewController(nibName: "AboutModifyAreaViewController", bundle: nil);
            self.navigationController?.present(vc, animated: true, completion: { () -> Void in
                segment.selectedSegmentIndex = 0;
            })
        }
    }
    
    fileprivate func configUI() {
        sureBtn.layer.masksToBounds = true;
        sureBtn.layer.cornerRadius = 6.0;
        
        let itemsArray = ["Note","Area"];
        segment = UISegmentedControl(items: itemsArray);
        segment.frame = CGRect(x: 0, y: 0, width: 150, height: 30);
        segment.selectedSegmentIndex = 0;
        segment.addTarget(self, action: #selector(self.segmentAction(_:)), for: UIControlEvents.valueChanged);
        self.navigationItem.titleView = segment;
    }
}
