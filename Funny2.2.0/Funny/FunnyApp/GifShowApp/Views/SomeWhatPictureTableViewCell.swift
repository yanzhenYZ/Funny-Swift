//
//  SomeWhatPictureTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 15/12/28.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class SomeWhatPictureTableViewCell: PictureSuperTableViewCell {

    override func configSecondSuperUI() {
        _mainPictureImgaeV.userInteractionEnabled = true;
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longGestureAction(_:)));
        longGesture.minimumPressDuration = 1.0;
        _mainPictureImgaeV.addGestureRecognizer(longGesture);
    }
    
    
    var model: SomeWhatPictureModel! {
        didSet {
            _headView.headImageView(model.avatar_url, name: model.name, time: model.create_time);
            let newSize = FunnyManager.manager.LabelSize(model.text, width: WIDTH-25, font: ContentMainTextFont);
            _userTextLabel.height = newSize.height;
            _userTextLabel.text = model.text;
            
            let scale = (WIDTH - 20) / CGFloat(model.r_width.integerValue);
            let height = CGFloat(model.r_height.integerValue) * scale;
            _mainPictureImgaeV.frame = CGRectMake(10, CGRectGetMaxY(_userTextLabel.frame) + 5, WIDTH - 20, height);
            if model.text.isEmpty {
                _mainPictureImgaeV.frame.origin.y = 65.0;
            }
            _mainPictureImgaeV.sd_setImageWithURL(NSURL(string: model.url), placeholderImage: BigImage);
            
            _backView.height = CGRectGetMaxY(_mainPictureImgaeV.frame) + 4.0;
            rowHeight = CGRectGetMaxY(_mainPictureImgaeV.frame) + 8.0;
        }
    }
    
    
    func longGestureAction(tap: UILongPressGestureRecognizer) {
        if tap.state != UIGestureRecognizerState.Began {
            return;
        }
        let tapView = tap.view as! UIImageView;
        FunnyManager.manager.saveImage(tapView.image!);
    }
    
}
