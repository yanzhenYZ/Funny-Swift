//
//  BuDeJiePictureTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 15/12/29.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class BuDeJiePictureTableViewCell: PictureSuperTableViewCell {

    var model: BuDeJiePictureModel! {
        didSet {
            _headView.headImageView(model.profile_image, name: model.name, time: FunnyManager.manager.timeIntervalWithDateString(model.create_time));
            let newSize = FunnyManager.manager.LabelSize(model.text, width: WIDTH - 25.0, font: ContentMainTextFont);
            _userTextLabel.text = model.text;
            _userTextLabel.height = newSize.height;
            
            let scale = CGFloat(Int(model.width)!) / (WIDTH - 20.0);
            let height = CGFloat(Int(model.height)!) / scale;
            _mainPictureImgaeV.sd_setImageWithURL(NSURL(string: model.cdn_img), placeholderImage: BigImage);
            _mainPictureImgaeV.frame = CGRectMake(10.0, CGRectGetMaxY(_userTextLabel.frame) + 8.0, WIDTH - 20.0, height);
            
            let maxHeight = CGRectGetMaxY(_mainPictureImgaeV.frame);
            _backView.height = maxHeight + 4.0;
            rowHeight = maxHeight + 8.0;
        }
    }
}
