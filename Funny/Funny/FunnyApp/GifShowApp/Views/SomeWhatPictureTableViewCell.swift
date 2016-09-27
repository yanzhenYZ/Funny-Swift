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
        _mainPictureImgaeV.isUserInteractionEnabled = true;
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
            
            let scale = (WIDTH - 20) / CGFloat(model.r_width.intValue);
            let height = CGFloat(model.r_height.intValue) * scale;
            _mainPictureImgaeV.frame = CGRect(x: 10, y: _userTextLabel.frame.maxY + 5, width: WIDTH - 20, height: height);
            if model.text.isEmpty {
                _mainPictureImgaeV.frame.origin.y = 65.0;
            }
            _mainPictureImgaeV.sd_setImage(with: URL(string: model.url), placeholderImage: BigImage);
            
            _backView.height = _mainPictureImgaeV.frame.maxY + 4.0;
            rowHeight = _mainPictureImgaeV.frame.maxY + 8.0;
        }
    }
    
    
    func longGestureAction(_ tap: UILongPressGestureRecognizer) {
        if tap.state != UIGestureRecognizerState.began {
            return;
        }
        let tapView = tap.view as! UIImageView;
        FunnyManager.manager.saveImage(tapView.image!);
    }
    
}
