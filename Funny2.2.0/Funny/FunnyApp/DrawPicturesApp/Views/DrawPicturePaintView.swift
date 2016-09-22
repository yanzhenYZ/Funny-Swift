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
    fileprivate var path: UIBezierPath!
    fileprivate var paths = [AnyObject]()
    
    override func draw(_ rect: CGRect) {
        if paths.count > 0 {
            for (_,value) in paths.enumerated() {
                if value is UIImage {
                    let image = value as! UIImage;
                    image.draw(at: CGPoint.zero);
                }else{
                    let onePath = value as! DrawPicturePath;
                    onePath.color.set();
                    onePath.stroke();
                }
            }
        }
    }
    
//MARK: - touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = self.myPoint(touches);
        let firstPath = DrawPicturePath(lineWidth: lineWidth, lineColor: lineColor, startPoint: point);
        path = firstPath;
        paths.append(firstPath);
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = self.myPoint(touches);
        path.addLine(to: point);
        self.setNeedsDisplay();
    }
    
    fileprivate func myPoint(_ touches: Set<NSObject>) ->CGPoint{
        let t = touches as NSSet;
        let touch = t.anyObject() as! UITouch;
        return touch.location(in: self);
    }
    
//MARK: - Out-Method
    
    func clearScreen() {
        paths.removeAll(keepingCapacity: false);
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
        lineColor = UIColor.black;
    }

    var image: UIImage! {
        didSet{
            paths.append(image);
            self.setNeedsDisplay();
        }
    }
}
