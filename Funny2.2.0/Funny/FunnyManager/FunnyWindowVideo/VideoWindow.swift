//
//  VideoWindow.swift
//  Funny
//
//  Created by yanzhen on 16/7/29.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class VideoWindow: UIWindow {

    fileprivate var videoView: UIView?
    fileprivate var beginPoint: CGPoint!
    fileprivate var scale: CGFloat! = 1.0
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.clipsToBounds = true;
        let pin = UIPinchGestureRecognizer(target: self, action: #selector(self.pinGestureAction(_:)));
        self.addGestureRecognizer(pin);
    }
    
    func pinGestureAction(_ pin: UIPinchGestureRecognizer) {
        scale = pin.scale;
        if scale > 1.0 {
            if self.width * scale > WIDTH {
                scale = WIDTH / self.width;
            }
        }else{
            if self.width * scale < 200.0 {
                scale = 200.0 / self.width;
            }
        }
        self.transform = self.transform.scaledBy(x: scale, y: scale);
        pin.scale = 1.0;
        if pin.state == .ended {
            self.resetFrame();
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeWindowView(_ view: UIView) {
        if videoView == view {
            return;
        }
        videoView = view;
        self.frame = view.frame;
        if self.subviews.count > 0 {
            for (_,value) in self.subviews.enumerated() {
                value.removeFromSuperview();
            }
        }
        self.addSubview(view);
    }
    
    
//MARK: - Touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        beginPoint = self.myPoint(touches);
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let nowPoint = self.myPoint(touches);
        let offsetX = nowPoint.x - beginPoint.x;
        let offsetY = nowPoint.y - beginPoint.y;
        let centerX = self.center.x + offsetX;
        let centerY = self.center.y + offsetY;
        self.center = CGPoint(x: centerX, y: centerY);
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resetFrame();
    }
    
    fileprivate func resetFrame() {
        var centerX = self.center.x;
        var centerY = self.center.y;
        if(centerX < self.width / 2)
        {
            centerX = self.width / 2;
        }
        else if( centerX > WIDTH - self.width / 2)
        {
            centerX = WIDTH - self.width / 2;
        }
        
        if(centerY < self.height / 2)
        {
            centerY = self.height / 2;
        }
        else if(centerY > HEIGHT - self.height / 2)
        {
            centerY = HEIGHT - self.height / 2;
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.center = CGPoint(x: centerX, y: centerY);
        }) 
    }
    
    fileprivate func myPoint(_ touches: Set<NSObject>) ->CGPoint{
        let t = touches as NSSet;
        let touch = t.anyObject() as! UITouch;
        return touch.location(in: self);
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        videoView?.frame = self.bounds;
    }
}
