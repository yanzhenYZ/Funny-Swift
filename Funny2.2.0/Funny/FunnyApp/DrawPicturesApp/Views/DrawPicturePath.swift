//
//  DrawPicturePath.swift
//  Funny
//
//  Created by yanzhen on 16/1/18.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class DrawPicturePath: UIBezierPath {
    
    var color: UIColor!
    
    init(lineWidth: CGFloat, lineColor: UIColor, startPoint: CGPoint) {
        super.init();
        self.lineWidth = lineWidth;
        self.color = lineColor;
        self.move(to: startPoint);
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
