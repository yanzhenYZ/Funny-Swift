//
//  CALayerDelegate.swift
//  Funny
//
//  Created by yanzhen on 16/4/15.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class CALayerDelegate: NSObject {
    
    var rightSpace: CGFloat!
    var left: Bool = false
    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        UIGraphicsPushContext(ctx);
        var x = WIDTH - 90.0;
        if rightSpace > 0 {
            x = WIDTH - rightSpace;
        }
        let dict:Dictionary<String,AnyObject> = [NSForegroundColorAttributeName: FunnyColor,NSFontAttributeName: UIFont.init(name: "IowanOldStyle-BoldItalic", size: 18.0)!];
        let str: NSString = "Y&Z TV";
        if left {
            str.drawInRect(CGRectMake(5, 5, 120, 40), withAttributes: dict);
        }else{
            str.drawInRect(CGRectMake(x, 0, 120, 40), withAttributes: dict);
        }
        UIGraphicsPopContext();
    }
    
}
