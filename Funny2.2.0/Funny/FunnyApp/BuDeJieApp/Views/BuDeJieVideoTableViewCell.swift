//
//  BuDeJieVideoTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 15/12/29.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class BuDeJieVideoTableViewCell: VideoSuperTableViewCell {

    var model: BuDeJieVideoModel! {
        didSet {
            _headView.headImageView(model.profile_image, name: model.name, time: FunnyManager.manager.timeIntervalWithDateString(model.create_time));
            let newSize = FunnyManager.manager.LabelSize(model.text, width: WIDTH - 25.0, font: ContentMainTextFont);
            _userTextLabel.text = model.text;
            _userTextLabel.height = newSize.height;
            
            shareTitle = model.text;
            shareURL = model.videouri;
            
            let scale = CGFloat(Int(model.width)!) / (WIDTH - 20.0);
            let height = CGFloat(Int(model.height)!) / scale;
            mainImageView.sd_setImageWithURL(NSURL(string: model.bimageuri), placeholderImage: BigImage);
            mainImageView.frame = CGRectMake(10.0, _userTextLabel.maxY + 10.0, WIDTH - 20.0, height);
            playButton.frame = CGRectMake(mainImageView.maxX - 70, mainImageView.maxY - 62, 70, 62);
            progressView.y = mainImageView.maxY;
            _backView.height = mainImageView.maxY + 6.0;
            rowHeight = mainImageView.maxY + 10.0;
        }
    }
}
