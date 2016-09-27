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
        smallView = ContentOtherUserView(frame: CGRect(x: 10.0, y: mainImageView.frame.maxY+10, width: WIDTH - 20.0, height: 0));
        self.contentView.addSubview(smallView);
//        self.noShare = true;
    }
    
    var groupModel: ContentVideoModel! {
        didSet{
            _headView.headImageView(groupModel.avatar_url, name: groupModel.name, time: groupModel.create_time);
            
            if groupModel.text.isEmpty {
                _userTextLabel.frame = CGRect(x: 15.0, y: 65.0, width: WIDTH - 25.0, height: 0);
            }else{
                _userTextLabel.text = groupModel.text;
                let newSize = FunnyManager.manager.LabelSize(groupModel.text, width: WIDTH - 25.0, font: ContentMainTextFont)
                _userTextLabel.height = newSize.height;
            }
            var originW = groupModel.width.intValue;
            if originW == 0 {
                originW = 1;
            }
            
            shareURL = groupModel.url;
            shareTitle = groupModel.text;
            
            let originH = groupModel.height.intValue;
            let scale = mainImageView.frame.size.width / CGFloat(originW);
            let imageHeight = CGFloat(originH) * scale;
            mainImageView.frame = CGRect(x: 10.0, y: _userTextLabel.frame.maxY+10, width: WIDTH-20, height: imageHeight);
            let mainImageURL = URL(string: groupModel.imageURL);
            mainImageView.sd_setImage(with: mainImageURL, placeholderImage:BigImage);
            
            playButton.frame = CGRect(x: mainImageView.maxX - 70, y: mainImageView.maxY - 62, width: 70, height: 62);
            progressView.frame = CGRect(x: 10.0, y: mainImageView.frame.maxY, width: WIDTH - 20.0, height: 2.0);
            
            _backView.height = mainImageView.frame.maxY+9;
            rowHeight = _backView.frame.maxY + 2.5;
        }
    }
    
    var commentModel: ContentVideoCommentsModel! {
        didSet{
            if commentModel.avatar_url == nil {
                commentModel.avatar_url = "http://imgsrc.baidu.com/forum/w=580/sign=4a2ae49304087bf47dec57e1c2d1575e/f66bf21fbe096b63a19b85880a338744eaf8ac12.jpg"
            }
            smallView.otherUserView(mainImageView.frame.maxY+10, urlString:commentModel.avatar_url, name: commentModel.user_name, text: commentModel.text);
            _backView.height = smallView.frame.maxY+5;
            rowHeight = _backView.frame.maxY + 2.5;
        }
    }
}
