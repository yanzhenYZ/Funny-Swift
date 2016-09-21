//
//  SuperScreenPartShotView.swift
//  test
//
//  Created by yanzhen on 15/12/23.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
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

fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}


typealias ScreenShotPartBlock = (_ rect: CGRect, _ shot: Bool) -> Void

class SuperScreenPartShotView: UIView {
    var block: ScreenShotPartBlock?
    var shapeLayer: CAShapeLayer?
    var shotRect: CGRect?
    var startPoint: CGPoint?
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.configUI();
        
    }

    fileprivate func configUI() {
        self.prepareShapeLayer();
        self.prepareUI();
        let pan=UIPanGestureRecognizer(target: self, action: #selector(self.panAction(_:)));
        self.addGestureRecognizer(pan);
    }
    
    fileprivate func prepareShapeLayer() {
        shapeLayer=CAShapeLayer();
        shapeLayer?.lineWidth=2.0;
        shapeLayer?.strokeColor=UIColor.red.cgColor;
        shapeLayer?.fillColor=UIColor.gray.withAlphaComponent(0.15).cgColor;
        shapeLayer?.lineDashPattern=[5,5];
        shotRect = self.bounds.insetBy(dx: 20.0, dy: 150.0);
        let path=CGPath(rect: shotRect!, transform: nil);
        shapeLayer?.path=path;
        self.layer.addSublayer(shapeLayer!);
    
    }
    
    func panAction(_ pan: UIPanGestureRecognizer) {
        //static var startPoint
        if pan.state == UIGestureRecognizerState.began{
            shapeLayer?.path=nil;
            startPoint=pan.location(in: self);
            if startPoint?.x <= 20.0 {
                startPoint?.x=1.0;
            }
            
        }else if pan.state == UIGestureRecognizerState.changed
        {
            let currentPoint=pan.location(in: self);
            let x=startPoint!.x;
            let y=startPoint!.y;
            shotRect=CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(currentPoint.x)-CGFloat(x), height: CGFloat(currentPoint.y)-CGFloat(y));
            let path=CGPath(rect: shotRect!, transform: nil);
            shapeLayer?.path=path;
        }
    }
    
    func cancelBtnClick() {
        block!(CGRect.zero, false);
    }
    
    func sureBtnAction() {

        let myRect=CGRect(x: shotRect!.origin.x, y: shotRect!.origin.y, width: shotRect!.size.width, height: shotRect!.size.height)
        block!(myRect, true);
    }
    
    func initBlock(_ myBlock: ScreenShotPartBlock?){
        block=myBlock;
    }
    
    fileprivate func prepareUI() {
        let smallView=UIView(frame: CGRect(x: 10.0, y: self.bounds.size.height-35.0, width: WIDTH-20, height: 35.0));
        smallView.backgroundColor=UIColor.red;
        smallView.layer.cornerRadius=5.0;
        self.addSubview(smallView);
        //
        let sureBtn=UIButton(frame: CGRect(x: self.bounds.size.width-60.0, y: self.bounds.size.height-30.0, width: 40.0, height: 25.0));
        sureBtn.setTitle("确定", for: UIControlState());
        sureBtn.setTitleColor(UIColor.blue, for: UIControlState());
        sureBtn.addTarget(self, action: #selector(self.sureBtnAction), for: UIControlEvents.touchUpInside);
        self.addSubview(sureBtn);
        
        let cancelBtn=UIButton(frame: CGRect(x: 20.0, y: self.bounds.size.height-30.0, width: 40.0, height: 25.0));
        cancelBtn.setTitle("取消", for: UIControlState());
        cancelBtn.setTitleColor(UIColor.blue, for: UIControlState());
        cancelBtn.addTarget(self, action: #selector(self.cancelBtnClick), for: UIControlEvents.touchUpInside);
        self.addSubview(cancelBtn);
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
