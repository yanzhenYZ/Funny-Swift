//
//  DrawPicturePaintView.swift
//  Funny
//
//  Created by yanzhen on 16/1/18.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class DrawPicturePaintView: UIView {

    var lineWidth: CGFloat!
    var lineColor: UIColor!
    private var path: UIBezierPath!
    private var paths = [AnyObject]()
    
    override func drawRect(rect: CGRect) {
        if paths.count > 0 {
            for (_,value) in paths.enumerate() {
                if value.isKindOfClass(UIImage) {
                    let image = value as! UIImage;
                    image.drawAtPoint(CGPointZero);
                }else{
                    let onePath = value as! DrawPicturePath;
                    onePath.color.set();
                    onePath.stroke();
                }
            }
        }
    }
    
//MARK: - touch
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let point = self.myPoint(touches);
        let firstPath = DrawPicturePath(lineWidth: lineWidth, lineColor: lineColor, startPoint: point);
        path = firstPath;
        paths.append(firstPath);
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let point = self.myPoint(touches);
        path.addLineToPoint(point);
        self.setNeedsDisplay();
    }
    
    private func myPoint(touches: Set<NSObject>) ->CGPoint{
        let t = touches as NSSet;
        let touch = t.anyObject() as! UITouch;
        return touch.locationInView(self);
    }
    
//MARK: - Out-Method
    
    func clearScreen() {
        paths.removeAll(keepCapacity: false);
        self.setNeedsDisplay();
    }
    
    func undo() {
        if paths.count > 0 {
            self.paths.removeLast();
            self.setNeedsDisplay();
        }
    }
    
    func isDrawInView() ->Bool{
        if paths.count > 0 {
            return true;
        }
        return false;
    }
//MARK: - other
    override func awakeFromNib() {
        lineWidth = 2;
        lineColor = UIColor.blackColor();
    }

    var image: UIImage! {
        didSet{
            paths.append(image);
            self.setNeedsDisplay();
        }
    }
}
