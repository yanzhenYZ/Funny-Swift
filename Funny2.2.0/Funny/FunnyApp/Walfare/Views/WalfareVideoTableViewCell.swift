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
            mainImageView.y = _userTextLabel.frame.maxY + 4.0;
            mainImageView.sd_setImage(with: URL(string: model.vpic_small), placeholderImage:HeadImage);
            let maxMainImageY = mainImageView.frame.maxY
            progressView.y = maxMainImageY;
            playButton.frame = CGRect(x: mainImageView.maxX - 70, y: mainImageView.maxY - 62, width: 70, height: 62);
            
            shareTitle = model.wbody;
            shareURL = model.vsource_url;
            
            _backView.height = maxMainImageY + 4.0;
            rowHeight = maxMainImageY + 8.0;
        }
    }
 
    override func configSuperUI() {
        
        _backView = UIView(frame: CGRect(x: 5.0, y: 5.0, width: WIDTH - 10.0, height: 0.0));
        _backView.backgroundColor = UIColor.white;
        self.contentView.addSubview(_backView);
        
        creatTimeLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 200, height: 25));
        creatTimeLabel.font = UIFont.systemFont(ofSize: 13.0);
        self.contentView.addSubview(creatTimeLabel);
        
        _userTextLabel = UILabel(frame: CGRect(x: 10, y: 40, width: WIDTH - 20, height: 0));
        _userTextLabel.font = UIFont.systemFont(ofSize: ContentMainTextFont);
        _userTextLabel.numberOfLines = 0;
        self.contentView.addSubview(_userTextLabel);
        
        mainImageView = UIImageView(frame: CGRect(x: 10.0, y: _userTextLabel.frame.maxY + 10.0, width: WIDTH - 20.0, height: (WIDTH - 20.0) / 4 * 3));
        mainImageView.contentMode = UIViewContentMode.scaleAspectFill;
        mainImageView.clipsToBounds = true;
        self.contentView.addSubview(mainImageView);
        
        progressView = UIProgressView(frame: CGRect(x: 10.0, y: mainImageView.frame.maxY, width: WIDTH - 20.0, height: 2.0));
        progressView.progress = 0.0;
        self.contentView.addSubview(progressView);
        
        playButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 70.0, height: 70.0));
        playButton.backgroundColor = UIColor.clear;
        playButton.setBackgroundImage(UIImage(named: "play_start"), for: UIControlState());
        playButton.setBackgroundImage(UIImage(named: "play_pause"), for: .selected);
        playButton.addTarget(self, action: #selector(self.playButtonClick(_:)), for: UIControlEvents.touchUpInside);
        self.contentView.addSubview(playButton);
    }
    
}
