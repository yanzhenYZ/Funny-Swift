//
//  NumLockView.swift
//  Funny
//
//  Created by yanzhen on 16/1/19.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class NumLockView: UIView {

    var onlyOnePW: Bool = false
    var password: String!
    fileprivate var inputPasswordLabel: UILabel!
    fileprivate var smallView: UIView!
    fileprivate var btnView: UIView!
    fileprivate var btnsArray = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT));
        self.configUI();
    }

    func numBtnClick(_ btn: UIButton) {
        UIView.animate(withDuration: 0.05, animations: { () -> Void in
            btn.backgroundColor = FunnyManager.manager.color(115.0, G: 90.0, B: 113.0);
        }, completion: { (finished) -> Void in
            btn.backgroundColor = UIColor.clear;
        }) 
        self.addBtn(btn);
    }
    
    fileprivate func addBtn(_ btn: UIButton) {
        btnsArray.append(btn);
        if btnsArray.count > 4 {
            btnsArray.removeLast();
            return;
        }
        let color = FunnyManager.manager.color(112.0, G: 103.0, B: 130.0);
        for i: Int in 0 ..< btnsArray.count {
            let small = smallView.subviews[i];
            small.backgroundColor = color;
        }
        
        if btnsArray.count == 4 {
            self.isPasswordRight();
        }
     }
    
    fileprivate func isPasswordRight() {
        var str = "";
        for i: Int in 0 ..< btnsArray.count {
            let btn = btnsArray[i];
            str = str + btn.titleLabel!.text!;
        }
        
        var pStr1: String? = nil;
        var pStr2: String? = nil;
        if onlyOnePW {
            if password == nil {
                pStr1 = LOCKPASSWORD1;
                pStr2 = LOCKPASSWORD1;
            }else{
                pStr1 = password;
                pStr2 = password;
            }
        }else{
            if password == nil {
                pStr1 = LOCKPASSWORD1;
            }else{
                pStr1 = password;
            }
            pStr2 = LOCKPASSWORD2;
        }
        
        if str == pStr1 || str == pStr2 {
            self.backToIdentity();
            NotificationCenter.default.post(name: Notification.Name(rawValue: PASSWORDISRIGHT), object: nil);
            
        }else{
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.smallView.transform = CGAffineTransform(translationX: -20, y: 0);
            }, completion: { (finished) -> Void in
                self.smallView.transform = CGAffineTransform(translationX: 40, y: 0);
                UIView.animate(withDuration: 0.1, animations: { () -> Void in
                    self.smallView.transform = CGAffineTransform.identity;
                    }, completion: { (finished) -> Void in
                        NotificationCenter.default.post(name: Notification.Name(rawValue: PASSWORDISWRONG), object: nil);
                        self.backToIdentity();
                })
            })
        }
    
    }
    
    func backToIdentity() {
        self.btnsArray.removeAll(keepingCapacity: false);
        for i: Int in 0 ..< smallView.subviews.count {
            let small = smallView.subviews[i];
            small.backgroundColor = UIColor.clear;
        }
    }
//MARK: - UI
    fileprivate func configUI() {
        inputPasswordLabel = UILabel(frame: CGRect(x: 0, y: 80, width: 109, height: 25));
        inputPasswordLabel.center = CGPoint(x: WIDTH / 2, y: 92.5);
        inputPasswordLabel.text = "输入密码";
        inputPasswordLabel.textAlignment = NSTextAlignment.center;
        inputPasswordLabel.textColor = UIColor.white;
        inputPasswordLabel.font = UIFont.systemFont(ofSize: 18.0);
        inputPasswordLabel.backgroundColor = UIColor.clear;
        self.addSubview(inputPasswordLabel);
        
        smallView = UIView(frame: CGRect(x: 0, y: 125, width: 140, height: 30));
        smallView.center = CGPoint(x: WIDTH / 2, y: 140);
        smallView.backgroundColor = UIColor.clear;
        let smallViewWH: CGFloat! = 14.0;
        for i: Int in 0 ..< 4 {
            let startX = 12 + 34.0 * CGFloat(i);
            let sonView = UIView(frame: CGRect(x: startX, y: 8, width: smallViewWH, height: smallViewWH));
            sonView.layer.masksToBounds = true;
            sonView.layer.cornerRadius = sonView.width / 2;
            sonView.layer.borderWidth = 1.2;
            sonView.layer.borderColor = UIColor.blue.cgColor;
            smallView.addSubview(sonView);
        }
        self.addSubview(smallView);
        
        //space = 20;
        let BtnWH: CGFloat! = (WIDTH - 120.0) / 3;
        btnView = UIView(frame: CGRect(x: 0, y: 180, width: WIDTH, height: 4 * BtnWH + 60.0));
        btnView.backgroundColor = UIColor.clear;
        for j: Int in 0 ..< 10 {
            let startX = 40 + (BtnWH + 20) * CGFloat(j % 3);
            let startY = (BtnWH + 20) * CGFloat(j / 3);
            var btn:UIButton! = nil;
            if j == 9 {
                btn = UIButton(frame: CGRect(x: 0, y: startY, width: BtnWH, height: BtnWH));
                btn.center = CGPoint(x: WIDTH / 2, y: startY + BtnWH / 2);
                btn.setTitle("0", for: UIControlState());
            }else{
                btn = UIButton(frame: CGRect(x: startX, y: startY, width: BtnWH, height: BtnWH));
                btn.setTitle(String(j + 1), for: UIControlState());
            }
            btn.addTarget(self, action: #selector(self.numBtnClick(_:)), for: UIControlEvents.touchUpInside);
            btn.backgroundColor = UIColor.clear;
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 30.0);
            btn.layer.masksToBounds = true;
            btn.layer.cornerRadius = BtnWH / 2;
            btn.layer.borderWidth = 2;
            btn.layer.borderColor = UIColor.blue.cgColor;
            btnView.addSubview(btn);
        }
        self.addSubview(btnView);
        
    }
    
//MARK: - var
    var titleLabelColor: UIColor! {
        didSet{
            inputPasswordLabel.textColor = titleLabelColor;
        }
    }
//必须设置
    var smallViewBorderColor: UIColor! {
        didSet{
            for (_,value) in smallView.subviews.enumerated() {
                value.layer.borderColor = smallViewBorderColor.cgColor;
            }
        }
    }
    
    var btnBorderColor: UIColor! {
        didSet{
            for (_,value) in btnView.subviews.enumerated() {
               value.layer.borderColor = btnBorderColor.cgColor;
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

let LOCKPASSWORD1 = "1234";
let LOCKPASSWORD2 = "5250";
let PASSWORDISRIGHT = "notePasswordIsRight";
let PASSWORDISWRONG = "notePasswordIsWrong";
