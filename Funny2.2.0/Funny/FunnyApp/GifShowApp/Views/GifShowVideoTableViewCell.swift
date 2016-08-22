//
//  GifShowVideoTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 15/12/28.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class GifShowVideoTableViewCell: VideoSuperTableViewCell {
    
    var model: GifShowVideoModel! {
        didSet {
            let mainHeight = (WIDTH - 100) / 3 * 4;
            rightSpace = 170.0;
            mainImageView.frame = CGRectMake(50.0, 70.0, WIDTH - 100.0, mainHeight);
            let maxMainY = mainImageView.maxY;
            progressView.frame = CGRectMake(50.0, maxMainY, WIDTH - 100.0, 2.0);
            playButton.frame = CGRectMake(mainImageView.maxX - 70, maxMainY - 62, 70, 62);
            _backView.frame = CGRectMake(5.0, 5.0, WIDTH - 10.0, maxMainY + 5);
            rowHeight = maxMainY + 7.5;
            
            var urlStr = model.main_url;
            if urlStr == nil {
                urlStr = "";
            }
            
            shareURL = model.main_mv_url;
            _headView.headImageView(urlStr, name: model.user_name, time: FunnyManager.manager.timeIntervalWithDateString(model.time));
            mainImageView.sd_setImageWithURL(NSURL(string: model.thumbnail_url), placeholderImage: BigImage);
        }
    }
    
}
