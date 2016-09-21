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
            
            var originW=groupModel.r_width.int32Value;
            if originW == 0 {
                originW = 1;
            }
            let originH = groupModel.r_height.int32Value;
            let scale=_mainPictureImgaeV.frame.size.width / CGFloat(originW);
            let imageHeight = CGFloat(originH) * scale;
            _mainPictureImgaeV.frame = CGRect(x: 10, y: _userTextLabel.frame.maxY + 5, width: WIDTH - 20, height: imageHeight);
            _mainPictureImgaeV.sd_setImage(with: URL(string: groupModel.url), placeholderImage: BigImage);
            _backView.height = _mainPictureImgaeV.frame.maxY + 5;
            rowHeight = _mainPictureImgaeV.frame.maxY + 7.5;
        }
    }

    var commentModel: ContentPictureCommentModel! {
        didSet{
            if commentModel.avatar_url == nil {
                commentModel.avatar_url = "http://imgsrc.baidu.com/forum/w=580/sign=4a2ae49304087bf47dec57e1c2d1575e/f66bf21fbe096b63a19b85880a338744eaf8ac12.jpg"
            }
            smallView.otherUserView(_mainPictureImgaeV.frame.maxY + 5, urlString: commentModel.avatar_url, name: commentModel.user_name, text: commentModel.text);
            _backView.frame = CGRect(x: 5.0, y: 5.0, width: WIDTH - 10.0, height: smallView.frame.maxY + 5);
            self.rowHeight = _backView.frame.maxY;
        }
    }
    
    override func configSecondSuperUI() {
        smallView = ContentOtherUserView(frame: CGRect(x: 10.0, y: _mainPictureImgaeV.frame.maxY+10, width: WIDTH - 20.0, height: 0));
        self.contentView.addSubview(smallView);
    }
    
}
