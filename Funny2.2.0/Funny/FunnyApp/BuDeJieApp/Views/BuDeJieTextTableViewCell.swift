//
//  BuDeJieTextTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 15/12/29.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class BuDeJieTextTableViewCell: TextSuperTableViewCell {
    
    var model: BuDeJieTextModel! {
        didSet {
            _headView.headImageView(model.profile_image, name: model.name, time: FunnyManager.manager.timeIntervalWithDateString(model.create_time));
            let newSize = FunnyManager.manager.LabelSize(model.text, width: WIDTH - 25.0, font: ContentMainTextFont);
            _userTextLabel.text = model.text;
            _userTextLabel.height =  newSize.height;
            
            _backView.height = CGRectGetMaxY(_userTextLabel.frame) + 4.0;
            rowHeight = CGRectGetMaxY(_userTextLabel.frame) + 8.0;
        }
    }
    
}
