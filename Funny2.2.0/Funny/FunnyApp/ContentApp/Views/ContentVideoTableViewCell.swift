//
//  ContentVideoTableViewCell.swift
//  Test
//
//  Created by yanzhen on 15/12/24.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

let ContentMainTextFont: CGFloat = 20.0;
let ContentUserNameFont: CGFloat = 14.0;
let ContentCreatTimeFont: CGFloat = 13.0;
let ContentOtherTextFont: CGFloat = 17.0;
class ContentVideoTableViewCell: VideoSuperTableViewCell {

    var smallView: ContentOtherUserView!
    
    override func configSuperSecondUI() {
        smallView = ContentOtherUserView(frame: CGRectMake(10.0, CGRectGetMaxY(mainImageView.frame)+10, WIDTH - 20.0, 0));
        self.contentView.addSubview(smallView);
        self.noShare = true;
    }
    
    var groupModel: ContentVideoModel! {
        didSet{
            _headView.headImageView(groupModel.avatar_url, name: groupModel.name, time: groupModel.create_time);
            
            if groupModel.text.isEmpty {
                _userTextLabel.frame = CGRectMake(15.0, 65.0, WIDTH - 25.0, 0);
            }else{
                _userTextLabel.text = groupModel.text;
                let newSize = FunnyManager.manager.LabelSize(groupModel.text, width: WIDTH - 25.0, font: ContentMainTextFont)
                _userTextLabel.height = newSize.height;
            }
            var originW = groupModel.width.integerValue;
            if originW == 0 {
                originW = 1;
            }
            
            shareURL = groupModel.url;
            shareTitle = groupModel.text;
            
            let originH = groupModel.height.integerValue;
            let scale = mainImageView.frame.size.width / CGFloat(originW);
            let imageHeight = CGFloat(originH) * scale;
            mainImageView.frame = CGRectMake(10.0, CGRectGetMaxY(_userTextLabel.frame)+10, WIDTH-20, imageHeight);
            let mainImageURL = NSURL(string: groupModel.imageURL);
            mainImageView.sd_setImageWithURL(mainImageURL, placeholderImage:BigImage);
            
            playButton.frame = CGRectMake(mainImageView.maxX - 70, mainImageView.maxY - 62, 70, 62);
            progressView.frame = CGRectMake(10.0, CGRectGetMaxY(mainImageView.frame), WIDTH - 20.0, 2.0);
            
            _backView.height = CGRectGetMaxY(mainImageView.frame)+9;
            rowHeight = CGRectGetMaxY(_backView.frame) + 2.5;
        }
    }
    
    var commentModel: ContentVideoCommentsModel! {
        didSet{
            if commentModel.avatar_url == nil {
                commentModel.avatar_url = "http://imgsrc.baidu.com/forum/w=580/sign=4a2ae49304087bf47dec57e1c2d1575e/f66bf21fbe096b63a19b85880a338744eaf8ac12.jpg"
            }
            smallView.otherUserView(CGRectGetMaxY(mainImageView.frame)+10, urlString:commentModel.avatar_url, name: commentModel.user_name, text: commentModel.text);
            _backView.height = CGRectGetMaxY(smallView.frame)+5;
            rowHeight = CGRectGetMaxY(_backView.frame) + 2.5;
        }
    }
}
