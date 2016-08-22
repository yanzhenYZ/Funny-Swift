//
//  SuperScreenPartShotView.swift
//  test
//
//  Created by yanzhen on 15/12/23.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

typealias ScreenShotPartBlock = (rect: CGRect, shot: Bool) -> Void

class SuperScreenPartShotView: UIView {
    var block: ScreenShotPartBlock?
    var shapeLayer: CAShapeLayer?
    var shotRect: CGRect?
    var startPoint: CGPoint?
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.configUI();
        
    }

    private func configUI() {
        self.prepareShapeLayer();
        self.prepareUI();
        let pan=UIPanGestureRecognizer(target: self, action: #selector(self.panAction(_:)));
        self.addGestureRecognizer(pan);
    }
    
    private func prepareShapeLayer() {
        shapeLayer=CAShapeLayer();
        shapeLayer?.lineWidth=2.0;
        shapeLayer?.strokeColor=UIColor.redColor().CGColor;
        shapeLayer?.fillColor=UIColor.grayColor().colorWithAlphaComponent(0.15).CGColor;
        shapeLayer?.lineDashPattern=[5,5];
        shotRect = CGRectInset(self.bounds, 20.0, 150.0);
        let path=CGPathCreateWithRect(shotRect!, nil);
        shapeLayer?.path=path;
        self.layer.addSublayer(shapeLayer!);
    
    }
    
    func panAction(pan: UIPanGestureRecognizer) {
        //static var startPoint
        if pan.state == UIGestureRecognizerState.Began{
            shapeLayer?.path=nil;
            startPoint=pan.locationInView(self);
            if startPoint?.x <= 20.0 {
                startPoint?.x=1.0;
            }
            
        }else if pan.state == UIGestureRecognizerState.Changed
        {
            let currentPoint=pan.locationInView(self);
            let x=startPoint!.x;
            let y=startPoint!.y;
            shotRect=CGRectMake(CGFloat(x), CGFloat(y), CGFloat(currentPoint.x)-CGFloat(x), CGFloat(currentPoint.y)-CGFloat(y));
            let path=CGPathCreateWithRect(shotRect!, nil);
            shapeLayer?.path=path;
        }
    }
    
    func cancelBtnClick() {
        block!(rect: CGRectZero, shot: false);
    }
    
    func sureBtnAction() {

        let myRect=CGRectMake(shotRect!.origin.x, shotRect!.origin.y, shotRect!.size.width, shotRect!.size.height)
        block!(rect: myRect, shot: true);
    }
    
    func initBlock(myBlock: ScreenShotPartBlock?){
        block=myBlock;
    }
    
    private func prepareUI() {
        let smallView=UIView(frame: CGRectMake(10.0, self.bounds.size.height-35.0, WIDTH-20, 35.0));
        smallView.backgroundColor=UIColor.redColor();
        smallView.layer.cornerRadius=5.0;
        self.addSubview(smallView);
        //
        let sureBtn=UIButton(frame: CGRectMake(self.bounds.size.width-60.0, self.bounds.size.height-30.0, 40.0, 25.0));
        sureBtn.setTitle("确定", forState: UIControlState.Normal);
        sureBtn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal);
        sureBtn.addTarget(self, action: #selector(self.sureBtnAction), forControlEvents: UIControlEvents.TouchUpInside);
        self.addSubview(sureBtn);
        
        let cancelBtn=UIButton(frame: CGRectMake(20.0, self.bounds.size.height-30.0, 40.0, 25.0));
        cancelBtn.setTitle("取消", forState: UIControlState.Normal);
        cancelBtn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal);
        cancelBtn.addTarget(self, action: #selector(self.cancelBtnClick), forControlEvents: UIControlEvents.TouchUpInside);
        self.addSubview(cancelBtn);
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
