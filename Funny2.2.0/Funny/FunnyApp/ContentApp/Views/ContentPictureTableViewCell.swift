//
//  ContentPictureTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 15/12/28.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class ContentPictureTableViewCell: PictureSuperTableViewCell {

    var smallView: ContentOtherUserView!
    
    var groupModel: ContentPictureGroupModel! {
        didSet{
            _headView.headImageView(groupModel.avatar_url, name: groupModel.name, time: groupModel.create_time);
            let newSize = FunnyManager.manager.LabelSize(groupModel.text, width: WIDTH - 25.0, font: ContentMainTextFont);
            _userTextLabel.text = groupModel.text;
            _userTextLabel.height = newSize.height;
            
            var originW=groupModel.r_width.intValue;
            if originW == 0 {
                originW = 1;
            }
            let originH = groupModel.r_height.intValue;
            let scale=_mainPictureImgaeV.frame.size.width / CGFloat(originW);
            let imageHeight = CGFloat(originH) * scale;
            _mainPictureImgaeV.frame = CGRectMake(10, CGRectGetMaxY(_userTextLabel.frame) + 5, WIDTH - 20, imageHeight);
            _mainPictureImgaeV.sd_setImageWithURL(NSURL(string: groupModel.url), placeholderImage: BigImage);
            _backView.height = CGRectGetMaxY(_mainPictureImgaeV.frame) + 5;
            rowHeight = CGRectGetMaxY(_mainPictureImgaeV.frame) + 7.5;
        }
    }

    var commentModel: ContentPictureCommentModel! {
        didSet{
            if commentModel.avatar_url == nil {
                commentModel.avatar_url = "http://imgsrc.baidu.com/forum/w=580/sign=4a2ae49304087bf47dec57e1c2d1575e/f66bf21fbe096b63a19b85880a338744eaf8ac12.jpg"
            }
            smallView.otherUserView(CGRectGetMaxY(_mainPictureImgaeV.frame) + 5, urlString: commentModel.avatar_url, name: commentModel.user_name, text: commentModel.text);
            _backView.frame = CGRectMake(5.0, 5.0, WIDTH - 10.0, CGRectGetMaxY(smallView.frame) + 5);
            self.rowHeight = CGRectGetMaxY(_backView.frame);
        }
    }
    
    override func configSecondSuperUI() {
        smallView = ContentOtherUserView(frame: CGRectMake(10.0, CGRectGetMaxY(_mainPictureImgaeV.frame)+10, WIDTH - 20.0, 0));
        self.contentView.addSubview(smallView);
    }
    
}
