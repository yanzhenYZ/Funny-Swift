//
//  ExtensionButton.swift
//  Funny
//
//  Created by yanzhen on 16/10/12.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class ExtensionButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.imageView?.layer.masksToBounds = true;
        self.imageView?.layer.cornerRadius = 12.0;
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12.0);
        self.titleLabel?.textAlignment = .center;
        self.setTitleColor(UIColor.black, for: .normal);
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        let width = self.frame.size.width;
        self.imageView?.frame = CGRect(x: 0, y: 0, width: 60, height: 60);
        self.imageView?.center = CGPoint(x: width * 0.5, y: 37.5);
         self.titleLabel?.frame = CGRect(x: 0, y: 65.0 + 5.0, width: width, height: 20);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
