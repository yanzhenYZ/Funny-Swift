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
            
            _backView.height = _userTextLabel.frame.maxY + 4.0;
            rowHeight = _userTextLabel.frame.maxY + 8.0;
        }
    }
    
}
