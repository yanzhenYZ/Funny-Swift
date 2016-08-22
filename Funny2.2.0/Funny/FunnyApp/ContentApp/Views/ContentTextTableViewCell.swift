//
//  ContentTextTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 15/12/28.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class ContentTextTableViewCell: TextSuperTableViewCell {
   
    var smallView: ContentOtherUserView!

    var groupModel: ContextTextGroupModel! {
        didSet{
            let user = groupModel.user;
            _headView.headImageView(user["avatar_url"] as! String, name: user["name"] as! String, time: groupModel.create_time);
            let newSize = FunnyManager.manager.LabelSize(groupModel.text, width: WIDTH - 25.0, font: ContentMainTextFont);
            _userTextLabel.text = groupModel.text;
            _userTextLabel.height = newSize.height;
            _backView.height = CGRectGetMaxY(_userTextLabel.frame) + 5;
            self.rowHeight = CGRectGetMaxY(_backView.frame);
        }
    }
    
    var textModel:ContentTextModel! {
        didSet{
            if textModel.avatar_url == nil {
                textModel.avatar_url = "http://imgsrc.baidu.com/forum/w=580/sign=4a2ae49304087bf47dec57e1c2d1575e/f66bf21fbe096b63a19b85880a338744eaf8ac12.jpg"
            }
            smallView.otherUserView(CGRectGetMaxY(_userTextLabel.frame) + 5, urlString: textModel.avatar_url, name: textModel.user_name, text: textModel.text);
            _backView.height = CGRectGetMaxY(smallView.frame) + 5;
            self.rowHeight = CGRectGetMaxY(_backView.frame);
        }
    }
    
    override func configSuperSecondUI() {
        smallView = ContentOtherUserView(frame: CGRectMake(10.0, CGRectGetMaxY(_userTextLabel.frame)+10, WIDTH - 20.0, 0));
        self.contentView.addSubview(smallView);
    }
    
}
