//
//  TextSuperTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 15/12/30.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class TextSuperTableViewCell: UITableViewCell {

    var rowHeight: CGFloat!
    var _backView: UIView!
    var _headView: ContentHeadView!
    var _userTextLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None;
        self.backgroundColor = FunnyManager.manager.color(246.0, G: 246.0, B: 246.0);
        self.configSuperUI();
        self.configSuperSecondUI();
    }

    func configSuperSecondUI() {
        
    }
    
    func configSuperUI() {
        _backView = UIView(frame: CGRectMake(5.0, 5.0, WIDTH - 10.0, 0.0));
        _backView.backgroundColor = UIColor.whiteColor();
        self.contentView.addSubview(_backView);
        
        _headView = ContentHeadView(frame: CGRectMake(10.0, 10.0, WIDTH - 20, 50.0));
        self.contentView.addSubview(_headView);
        
        _userTextLabel = UILabel(frame: CGRectMake(15.0, 65.0, WIDTH - 25.0, 0.0));
        _userTextLabel.font = UIFont.systemFontOfSize(ContentMainTextFont);
        _userTextLabel.numberOfLines = 0;
        self.contentView.addSubview(_userTextLabel);
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
