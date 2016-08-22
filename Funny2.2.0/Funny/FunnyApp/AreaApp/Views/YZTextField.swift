//
//  YZTextField.swift
//  Funny
//
//  Created by yanzhen on 16/1/8.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class YZTextField: UITextField {

    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(bounds.origin.x + 10, bounds.origin.y, bounds.size.width, bounds.size.height);
    }
    
    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(bounds.origin.x + 10, bounds.origin.y, bounds.size.width, bounds.size.height);
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(bounds.origin.x + 10, bounds.origin.y, bounds.size.width, bounds.size.height);
    }
    
    override func awakeFromNib() {
        self.layer.masksToBounds = true;
        self.layer.cornerRadius = 6.0;
    }
}
