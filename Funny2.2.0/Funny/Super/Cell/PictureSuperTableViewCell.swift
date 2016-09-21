//
//  PictureSuperTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 15/12/30.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class PictureSuperTableViewCell: UITableViewCell {

    var rowHeight: CGFloat!
    var _mainPictureImgaeV: UIImageView!
    var _backView: UIView!
    var _headView: ContentHeadView!
    var _userTextLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.none;
        self.backgroundColor = FunnyManager.manager.color(246.0, G: 246.0, B: 246.0);
        self.configSuperUI();
        self.configSecondSuperUI();
    }

    

    func configSuperUI() {
        _backView = UIView(frame: CGRect(x: 5.0, y: 5.0, width: WIDTH - 10.0, height: 0.0));
        _backView.backgroundColor = UIColor.white;
        self.contentView.addSubview(_backView);
        
        _headView = ContentHeadView(frame: CGRect(x: 10.0, y: 10.0, width: WIDTH - 20, height: 50.0));
        self.contentView.addSubview(_headView);
        
        _userTextLabel = UILabel(frame: CGRect(x: 15.0, y: 65.0, width: WIDTH - 25.0, height: 20.0));
        _userTextLabel.font = UIFont.systemFont(ofSize: ContentMainTextFont);
        _userTextLabel.numberOfLines = 0;
        self.contentView.addSubview(_userTextLabel);
        
        _mainPictureImgaeV = UIImageView(frame: CGRect(x: 10, y: _userTextLabel.frame.maxY + 5, width: WIDTH - 20, height: 0));
        self.contentView.addSubview(_mainPictureImgaeV);
        
    }

    func configSecondSuperUI() {
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
