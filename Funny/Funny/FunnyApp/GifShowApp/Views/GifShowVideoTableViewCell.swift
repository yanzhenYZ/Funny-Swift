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
            mainImageView.frame = CGRect(x: 50.0, y: 70.0, width: WIDTH - 100.0, height: mainHeight);
            let maxMainY = mainImageView.maxY;
            progressView.frame = CGRect(x: 50.0, y: maxMainY, width: WIDTH - 100.0, height: 2.0);
            playButton.frame = CGRect(x: mainImageView.maxX - 70, y: maxMainY - 62, width: 70, height: 62);
            _backView.frame = CGRect(x: 5.0, y: 5.0, width: WIDTH - 10.0, height: maxMainY + 5);
            rowHeight = maxMainY + 7.5;
            
            var urlStr = model.main_url;
            if urlStr == nil {
                urlStr = "";
            }
            
            shareURL = model.main_mv_url;
            _headView.headImageView(urlStr!, name: model.user_name, time: FunnyManager.manager.timeIntervalWithDateString(model.time));
            mainImageView.sd_setImage(with: URL(string: model.thumbnail_url), placeholderImage: BigImage);
        }
    }
    
}
