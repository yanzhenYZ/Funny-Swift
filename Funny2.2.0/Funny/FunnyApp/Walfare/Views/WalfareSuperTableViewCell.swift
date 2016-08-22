//
//  WalfareSuperTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 15/12/30.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class WalfareSuperTableViewCell: UITableViewCell {

    var backView: UIView!
    var mainTextLabel: UILabel!
    var creatTimeLabel: UILabel!
    var rowHeight: CGFloat!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None;
        self.backgroundColor = FunnyManager.manager.color(246.0, G: 246.0, B: 246.0);
        self.configSuperUI();
        self.configSecondSuperUI();
    }

    func configSuperUI() {
        backView = UIView(frame: CGRectMake(5.0, 5.0, WIDTH - 10.0, 0.0));
        backView.backgroundColor = UIColor.whiteColor();
        self.contentView.addSubview(backView);
        
        creatTimeLabel = UILabel(frame: CGRectMake(10, 10, 200, 25));
        creatTimeLabel.font = UIFont.systemFontOfSize(13.0);
        self.contentView.addSubview(creatTimeLabel);
        
        mainTextLabel = UILabel(frame: CGRectMake(10, 40, WIDTH - 20, 0));
        mainTextLabel.font = UIFont.systemFontOfSize(ContentMainTextFont);
        mainTextLabel.numberOfLines = 0;
        self.contentView.addSubview(mainTextLabel);
    }
    
    func configSecondSuperUI() {
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
