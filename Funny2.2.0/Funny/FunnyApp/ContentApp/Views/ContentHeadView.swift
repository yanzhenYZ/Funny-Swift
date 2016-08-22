//
//  ContentHeadView.swift
//  Funny
//
//  Created by yanzhen on 15/12/28.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class ContentHeadView: UIView {
    
    var headImageView: UIImageView!
    var nameLabel: UILabel!
    var creatTimeLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.clearColor();
        self.configUI();
        
    }

    func configUI() {
            headImageView = UIImageView(frame: CGRectMake(0.0, 0.0, 50.0, 50.0));
            FunnyManager.manager.cornerRadian(headImageView);
            self.addSubview(headImageView);
        
            nameLabel = UILabel(frame: CGRectMake(60.0, 5.0, 200.0, 20.0));
            nameLabel.font=UIFont.systemFontOfSize(ContentOtherTextFont);
            self.addSubview(nameLabel);
        
            creatTimeLabel = UILabel(frame: CGRectMake(60.0, 25.0, 200.0, 20.0));
            creatTimeLabel.font = UIFont.systemFontOfSize(ContentCreatTimeFont);
            self.addSubview(creatTimeLabel);
    }
    
//MARK - HeadView
    /**           内涵段子_User               */
    func headImageView(urlString: String, name: String, time: NSNumber){
        headImageView.sd_setImageWithURL(NSURL(string: urlString), placeholderImage: HeadImage);
        nameLabel.text = name;
        creatTimeLabel.text = FunnyManager.manager.dateWithTimeInterval(time.intValue);
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
