//
//  WalfareVideoTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 15/12/30.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class WalfareVideoTableViewCell: VideoSuperTableViewCell {

    var creatTimeLabel: UILabel!
    
    var model: WalfareVideoModel! {
        didSet {
            creatTimeLabel.text = FunnyManager.manager.dateWithTimeInterval(Int32(Int(model.update_time)!));
            _userTextLabel.text = model.wbody;
            
            let newSize = FunnyManager.manager.LabelSize(model.wbody, width: WIDTH - 20, font: ContentMainTextFont);
            _userTextLabel.frame.size.height = newSize.height;
            mainImageView.y = CGRectGetMaxY(_userTextLabel.frame) + 4.0;
            mainImageView.sd_setImageWithURL(NSURL(string: model.vpic_small), placeholderImage:HeadImage);
            let maxMainImageY = CGRectGetMaxY(mainImageView.frame)
            progressView.y = maxMainImageY;
            playButton.frame = CGRectMake(mainImageView.maxX - 70, mainImageView.maxY - 62, 70, 62);
            
            shareTitle = model.wbody;
            shareURL = model.vsource_url;
            
            _backView.height = maxMainImageY + 4.0;
            rowHeight = maxMainImageY + 8.0;
        }
    }
 
    override func configSuperUI() {
        
        _backView = UIView(frame: CGRectMake(5.0, 5.0, WIDTH - 10.0, 0.0));
        _backView.backgroundColor = UIColor.whiteColor();
        self.contentView.addSubview(_backView);
        
        creatTimeLabel = UILabel(frame: CGRectMake(10, 10, 200, 25));
        creatTimeLabel.font = UIFont.systemFontOfSize(13.0);
        self.contentView.addSubview(creatTimeLabel);
        
        _userTextLabel = UILabel(frame: CGRectMake(10, 40, WIDTH - 20, 0));
        _userTextLabel.font = UIFont.systemFontOfSize(ContentMainTextFont);
        _userTextLabel.numberOfLines = 0;
        self.contentView.addSubview(_userTextLabel);
        
        mainImageView = UIImageView(frame: CGRectMake(10.0, CGRectGetMaxY(_userTextLabel.frame) + 10.0, WIDTH - 20.0, (WIDTH - 20.0) / 4 * 3));
        mainImageView.contentMode = UIViewContentMode.ScaleAspectFill;
        mainImageView.clipsToBounds = true;
        self.contentView.addSubview(mainImageView);
        
        progressView = UIProgressView(frame: CGRectMake(10.0, CGRectGetMaxY(mainImageView.frame), WIDTH - 20.0, 2.0));
        progressView.progress = 0.0;
        self.contentView.addSubview(progressView);
        
        playButton = UIButton(frame: CGRectMake(0.0, 0.0, 70.0, 70.0));
        playButton.backgroundColor = UIColor.clearColor();
        playButton.setBackgroundImage(UIImage(named: "play_start"), forState: .Normal);
        playButton.setBackgroundImage(UIImage(named: "play_pause"), forState: .Selected);
        playButton.addTarget(self, action: #selector(self.playButtonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        self.contentView.addSubview(playButton);
    }
    
}
