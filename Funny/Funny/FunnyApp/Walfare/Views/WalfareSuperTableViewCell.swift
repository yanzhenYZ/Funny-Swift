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
        self.selectionStyle = .none;
        self.backgroundColor = FunnyManager.manager.color(246.0, G: 246.0, B: 246.0);
        self.configSuperUI();
        self.configSecondSuperUI();
    }

    func configSuperUI() {
        backView = UIView(frame: CGRect(x: 5.0, y: 5.0, width: WIDTH - 10.0, height: 0.0));
        backView.backgroundColor = UIColor.white;
        self.contentView.addSubview(backView);
        
        creatTimeLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 200, height: 25));
        creatTimeLabel.font = UIFont.systemFont(ofSize: 13.0);
        self.contentView.addSubview(creatTimeLabel);
        
        mainTextLabel = UILabel(frame: CGRect(x: 10, y: 40, width: WIDTH - 20, height: 0));
        mainTextLabel.font = UIFont.systemFont(ofSize: ContentMainTextFont);
        mainTextLabel.numberOfLines = 0;
        self.contentView.addSubview(mainTextLabel);
    }
    
    func configSecondSuperUI() {
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
