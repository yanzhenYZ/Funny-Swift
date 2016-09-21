//
//  ContentOtherUserView.swift
//  Funny
//
//  Created by yanzhen on 15/12/28.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class ContentOtherUserView: UIView {

    var _otherheadImageView: UIImageView!
    var _otherNameLabel: UILabel!
    var _otherTextLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = FunnyManager.manager.color(246.0, G: 246.0, B: 256.0);
        self.clipsToBounds = true;
        self.configUI();
    }

    fileprivate func configUI() {
        let tipLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 37.0, height: 18.0));
        tipLabel.backgroundColor = FunnyManager.manager.color(251.0, G: 95.0, B: 136.0);
        tipLabel.textAlignment = NSTextAlignment.center;
        tipLabel.textColor = UIColor.white;
        tipLabel.font = UIFont.systemFont(ofSize: 12.0);
        tipLabel.text = "神评论";
        self.addSubview(tipLabel);
        
        _otherheadImageView = UIImageView(frame: CGRect(x: 10.0, y: 30.0, width: 25.0, height: 25.0));
        FunnyManager.manager.cornerRadian(_otherheadImageView);
        self.addSubview(_otherheadImageView);
        
        _otherNameLabel = UILabel(frame: CGRect(x: 40.0, y: 30.0, width: 200.0, height: 25.0));
        _otherNameLabel.font = UIFont.systemFont(ofSize: 15.0);
        self.addSubview(_otherNameLabel);
        
        _otherTextLabel = UILabel(frame: CGRect(x: 40.0, y: 60.0, width: WIDTH - 70.0, height: 0.0));
        _otherTextLabel.numberOfLines = 0;
        _otherTextLabel.font = UIFont.systemFont(ofSize: ContentOtherTextFont);
        self.addSubview(_otherTextLabel);
    }
    
    func otherUserView(_ originY: CGFloat,urlString: String,name: String, text: String){
        self.frame.origin.y = originY;
        _otherheadImageView.sd_setImage(with: URL(string: urlString), placeholderImage: HeadImage);
        _otherNameLabel.text = name;
        _otherTextLabel.text = text;
        let newSize = FunnyManager.manager.LabelSize(text, width: WIDTH - 68.0, font: ContentOtherTextFont);
        _otherTextLabel.frame = CGRect(x: 40.0, y: 60.0, width: WIDTH - 68.0, height: newSize.height);
        self.frame.size.height = newSize.height + 85.0;
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
