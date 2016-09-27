//
//  LockView.swift
//  Funny
//
//  Created by yanzhen on 16/1/7.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

protocol LockViewProtocol: NSObjectProtocol {
    func lockPasswordString(_ password: String);
}
class LockView: UIView {

    weak var delegate: LockViewProtocol?
    var btnsArray = [UIButton]()
    var movePoint: CGPoint! = CGPoint.zero
    
    override func draw(_ rect: CGRect) {
        if btnsArray.count <= 0 {
            return;
        }
        
        let path = UIBezierPath();
        for i in 0 ..< btnsArray.count {
            let btn = btnsArray[i];
            if i == 0 {
                path.move(to: btn.center);
            }else{
                path.addLine(to: btn.center);
            }
        }
        path.addLine(to: movePoint);
        UIColor.green.set();
        path.lineWidth = 3.0;
        path.lineJoinStyle = CGLineJoin.round;
        path.stroke();
    }
    
//MARK: - Touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isFirstDraw();
        let t = touches as NSSet;
        let touch = t.anyObject() as! UITouch;
        let point = touch.location(in: self);
        let touchButton = self.buttonWithPoint(point);
        if touchButton != nil && touchButton?.isSelected == false{
            touchButton?.isSelected = true;
            btnsArray.append(touchButton!);
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let t = touches as NSSet;
        let touch = t.anyObject() as! UITouch;
        movePoint = touch.location(in: self);
        let touchButton = self.buttonWithPoint(movePoint);
        if touchButton != nil && touchButton?.isSelected == false{
            touchButton?.isSelected = true;
            btnsArray.append(touchButton!);
        }
        self.setNeedsDisplay();

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isPasswordRight();
    }
    
//MARK: - private
    
    fileprivate func isPasswordRight() {
        if btnsArray.count <= 0 {
            return;
        }
        var passwordString = "";
        for (index,_) in btnsArray.enumerated() {
            let btn = btnsArray[index];
            passwordString += String(btn.tag - 10000);
        }
        
        delegate?.lockPasswordString(passwordString);
        self.renewOriginalStatus();
    }
    
    fileprivate func isFirstDraw() {
        self.renewOriginalStatus();
    }
    
    fileprivate func buttonWithPoint(_ point: CGPoint) ->UIButton? {
        for (_,value) in self.subviews.enumerated() {
            let btn = value as! UIButton;
            if btn.frame.contains(point){
                return btn;
            }
        }
        return nil;
    }
    
//MARK: - UI
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!;
        self.addBtns();
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        var col = 0;
        var row = 0;
        let btnWH = CGFloat(90);
        var btnX = CGFloat(0);
        var btnY = CGFloat(0);
        let space = (self.width - 3 * btnWH) / 4 as CGFloat;
        for i in 0 ..< self.subviews.count {
            col = i % 3;
            row = i / 3;
            let btn = self.subviews[i] as! UIButton;
            btnX = space + (space + btnWH) * CGFloat(col);
            btnY = (space + btnWH) * CGFloat(row) + 20.0;
            btn.frame = CGRect(x: btnX, y: btnY, width: btnWH, height: btnWH);
        }
    }
    
    fileprivate func addBtns() {
        for i in 0 ..< 9 {
            let btn = UIButton(type: .custom);
            btn.setImage(UIImage(named: "gesture_node_normal"), for: .normal);
            btn.setImage(UIImage(named: "gesture_node_highlighted"), for: .selected);
            btn.tag = 10000+i;
            btn.isUserInteractionEnabled = false;
            self.addSubview(btn);
        }
    }
//MARK: - public 
    func renewOriginalStatus() {
        if btnsArray.count > 0 {
            for (index,_) in btnsArray.enumerated() {
                let btn = btnsArray[index];
                btn.isSelected = false;
            }
            btnsArray.removeAll(keepingCapacity: false);
        }
        self.setNeedsDisplay();
    }
    
}
