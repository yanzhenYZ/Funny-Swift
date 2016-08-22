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
    var inputPasswordLabel: UILabel!
    var smallView: UIView!
    var btnView: UIView!
    var btnsArray = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: CGRectMake(0, 0, WIDTH, HEIGHT));
        self.configUI();
    }

    func numBtnClick(btn: UIButton) {
        UIView.animateWithDuration(0.05, animations: { () -> Void in
            btn.backgroundColor = FunnyManager.manager.color(115.0, G: 90.0, B: 113.0);
        }) { (finished) -> Void in
            btn.backgroundColor = UIColor.clearColor();
        }
        self.addBtn(btn);
    }
    
    private func addBtn(btn: UIButton) {
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
    
    private func isPasswordRight() {
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
            NSNotificationCenter.defaultCenter().postNotificationName(PASSWORDISRIGHT, object: nil);
            
        }else{
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.smallView.transform = CGAffineTransformMakeTranslation(-20, 0);
            }, completion: { (finished) -> Void in
                self.smallView.transform = CGAffineTransformMakeTranslation(40, 0);
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.smallView.transform = CGAffineTransformIdentity;
                    }, completion: { (finished) -> Void in
                        NSNotificationCenter.defaultCenter().postNotificationName(PASSWORDISWRONG, object: nil);
                        self.backToIdentity();
                })
            })
        }
    
    }
    
    func backToIdentity() {
        self.btnsArray.removeAll(keepCapacity: false);
        for i: Int in 0 ..< smallView.subviews.count {
            let small = smallView.subviews[i];
            small.backgroundColor = UIColor.clearColor();
        }
    }
//MARK: - UI
    private func configUI() {
        inputPasswordLabel = UILabel(frame: CGRectMake(0, 80, 109, 25));
        inputPasswordLabel.center = CGPointMake(WIDTH / 2, 92.5);
        inputPasswordLabel.text = "输入密码";
        inputPasswordLabel.textAlignment = NSTextAlignment.Center;
        inputPasswordLabel.textColor = UIColor.whiteColor();
        inputPasswordLabel.font = UIFont.systemFontOfSize(18.0);
        inputPasswordLabel.backgroundColor = UIColor.clearColor();
        self.addSubview(inputPasswordLabel);
        
        smallView = UIView(frame: CGRectMake(0, 125, 140, 30));
        smallView.center = CGPointMake(WIDTH / 2, 140);
        smallView.backgroundColor = UIColor.clearColor();
        let smallViewWH: CGFloat! = 14.0;
        for i: Int in 0 ..< 4 {
            let startX = 12 + 34.0 * CGFloat(i);
            let sonView = UIView(frame: CGRectMake(startX, 8, smallViewWH, smallViewWH));
            sonView.layer.masksToBounds = true;
            sonView.layer.cornerRadius = sonView.width / 2;
            sonView.layer.borderWidth = 1.2;
            sonView.layer.borderColor = UIColor.blueColor().CGColor;
            smallView.addSubview(sonView);
        }
        self.addSubview(smallView);
        
        //space = 20;
        let BtnWH: CGFloat! = (WIDTH - 120.0) / 3;
        btnView = UIView(frame: CGRectMake(0, 180, WIDTH, 4 * BtnWH + 60.0));
        btnView.backgroundColor = UIColor.clearColor();
        for j: Int in 0 ..< 10 {
            let startX = 40 + (BtnWH + 20) * CGFloat(j % 3);
            let startY = (BtnWH + 20) * CGFloat(j / 3);
            var btn:UIButton! = nil;
            if j == 9 {
                btn = UIButton(frame: CGRectMake(0, startY, BtnWH, BtnWH));
                btn.center = CGPointMake(WIDTH / 2, startY + BtnWH / 2);
                btn.setTitle("0", forState: UIControlState.Normal);
            }else{
                btn = UIButton(frame: CGRectMake(startX, startY, BtnWH, BtnWH));
                btn.setTitle(String(j + 1), forState: UIControlState.Normal);
            }
            btn.addTarget(self, action: #selector(self.numBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside);
            btn.backgroundColor = UIColor.clearColor();
            btn.titleLabel?.font = UIFont.systemFontOfSize(30.0);
            btn.layer.masksToBounds = true;
            btn.layer.cornerRadius = BtnWH / 2;
            btn.layer.borderWidth = 2;
            btn.layer.borderColor = UIColor.blueColor().CGColor;
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
            for (_,value) in smallView.subviews.enumerate() {
                value.layer.borderColor = smallViewBorderColor.CGColor;
            }
        }
    }
    
    var btnBorderColor: UIColor! {
        didSet{
            for (_,value) in btnView.subviews.enumerate() {
               value.layer.borderColor = btnBorderColor.CGColor;
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