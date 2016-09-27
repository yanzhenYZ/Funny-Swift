//
//  LayerDelegate.swift
//  Funny
//
//  Created by yanzhen on 16/9/18.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class LayerDelegate: NSObject, CALayerDelegate {

    var rightSpace: CGFloat! = 0
    var left: Bool = false
    
    func draw(_ layer: CALayer, in ctx: CGContext) {
        UIGraphicsPushContext(ctx);
        var x = WIDTH - 90.0;
        if rightSpace > 0 {
            x = WIDTH - rightSpace;
        }
        let dict:Dictionary<String,AnyObject> = [NSForegroundColorAttributeName: FunnyColor,NSFontAttributeName: UIFont.init(name: "IowanOldStyle-BoldItalic", size: 18.0)!];
        let str: NSString = "Y&Z TV";
        if left {
            str.draw(in: CGRect(x: 5, y: 5, width: 120, height: 40), withAttributes: dict);
        }else{
            str.draw(in: CGRect(x: x, y: 0, width: 120, height: 40), withAttributes: dict);
        }
        UIGraphicsPopContext();
    }

    
}
