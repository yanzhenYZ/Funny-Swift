//
//  VideoWindow.swift
//  Funny
//
//  Created by yanzhen on 16/7/29.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class VideoWindow: UIWindow {

    private var videoView: UIView?
    private var beginPoint: CGPoint!
    private var scale: CGFloat! = 1.0
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.clipsToBounds = true;
        let pin = UIPinchGestureRecognizer(target: self, action: #selector(self.pinGestureAction(_:)));
        self.addGestureRecognizer(pin);
    }
    
    func pinGestureAction(pin: UIPinchGestureRecognizer) {
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
        self.transform = CGAffineTransformScale(self.transform, scale, scale);
        pin.scale = 1.0;
        if pin.state == .Ended {
            self.resetFrame();
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeWindowView(view: UIView) {
        if videoView == view {
            return;
        }
        videoView = view;
        self.frame = view.frame;
        if self.subviews.count > 0 {
            for (_,value) in self.subviews.enumerate() {
                value.removeFromSuperview();
            }
        }
        self.addSubview(view);
    }
    
    
//MARK: - Touch
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        beginPoint = self.myPoint(touches);
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let nowPoint = self.myPoint(touches);
        let offsetX = nowPoint.x - beginPoint.x;
        let offsetY = nowPoint.y - beginPoint.y;
        let centerX = self.center.x + offsetX;
        let centerY = self.center.y + offsetY;
        self.center = CGPointMake(centerX, centerY);
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.resetFrame();
    }
    
    private func resetFrame() {
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
        
        UIView.animateWithDuration(0.25) {
            self.center = CGPointMake(centerX, centerY);
        }
    }
    
    private func myPoint(touches: Set<NSObject>) ->CGPoint{
        let t = touches as NSSet;
        let touch = t.anyObject() as! UITouch;
        return touch.locationInView(self);
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        videoView?.frame = self.bounds;
    }
}
