//
//  YZTextField.swift
//  Funny
//
//  Created by yanzhen on 16/1/8.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class YZTextField: UITextField {

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height);
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height);
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height);
    }
    
    override func awakeFromNib() {
        self.layer.masksToBounds = true;
        self.layer.cornerRadius = 6.0;
    }
}
