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
        self.backgroundColor = UIColor.clear;
        self.configUI();
        
    }

    func configUI() {
            headImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0));
            FunnyManager.manager.cornerRadian(headImageView);
            self.addSubview(headImageView);
        
            nameLabel = UILabel(frame: CGRect(x: 60.0, y: 5.0, width: 200.0, height: 20.0));
            nameLabel.font=UIFont.systemFont(ofSize: ContentOtherTextFont);
            self.addSubview(nameLabel);
        
            creatTimeLabel = UILabel(frame: CGRect(x: 60.0, y: 25.0, width: 200.0, height: 20.0));
            creatTimeLabel.font = UIFont.systemFont(ofSize: ContentCreatTimeFont);
            self.addSubview(creatTimeLabel);
    }
    
//MARK - HeadView
    /**           内涵段子_User               */
    func headImageView(_ urlString: String, name: String, time: NSNumber){
        headImageView.sd_setImage(with: URL(string: urlString), placeholderImage: HeadImage);
        nameLabel.text = name;
        creatTimeLabel.text = FunnyManager.manager.dateWithTimeInterval(time.int32Value);
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
