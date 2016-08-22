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

    private func configUI() {
        let tipLabel = UILabel(frame: CGRectMake(0.0, 0.0, 37.0, 18.0));
        tipLabel.backgroundColor = FunnyManager.manager.color(251.0, G: 95.0, B: 136.0);
        tipLabel.textAlignment = NSTextAlignment.Center;
        tipLabel.textColor = UIColor.whiteColor();
        tipLabel.font = UIFont.systemFontOfSize(12.0);
        tipLabel.text = "神评论";
        self.addSubview(tipLabel);
        
        _otherheadImageView = UIImageView(frame: CGRectMake(10.0, 30.0, 25.0, 25.0));
        FunnyManager.manager.cornerRadian(_otherheadImageView);
        self.addSubview(_otherheadImageView);
        
        _otherNameLabel = UILabel(frame: CGRectMake(40.0, 30.0, 200.0, 25.0));
        _otherNameLabel.font = UIFont.systemFontOfSize(15.0);
        self.addSubview(_otherNameLabel);
        
        _otherTextLabel = UILabel(frame: CGRectMake(40.0, 60.0, WIDTH - 70.0, 0.0));
        _otherTextLabel.numberOfLines = 0;
        _otherTextLabel.font = UIFont.systemFontOfSize(ContentOtherTextFont);
        self.addSubview(_otherTextLabel);
    }
    
    func otherUserView(originY: CGFloat,urlString: String,name: String, text: String){
        self.frame.origin.y = originY;
        _otherheadImageView.sd_setImageWithURL(NSURL(string: urlString), placeholderImage: HeadImage);
        _otherNameLabel.text = name;
        _otherTextLabel.text = text;
        let newSize = FunnyManager.manager.LabelSize(text, width: WIDTH - 68.0, font: ContentOtherTextFont);
        _otherTextLabel.frame = CGRectMake(40.0, 60.0, WIDTH - 68.0, newSize.height);
        self.frame.size.height = newSize.height + 85.0;
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
