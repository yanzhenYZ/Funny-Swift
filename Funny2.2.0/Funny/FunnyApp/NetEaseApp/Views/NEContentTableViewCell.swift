//
//  NEContentTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 16/1/4.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class NEContentTableViewCell: UITableViewCell {

    var rowHeight: CGFloat!
    var mainTextLabel: UILabel!
    var backView: UIView!
    var model: NetEaseModel! {
        didSet{
            mainTextLabel.text = model.digest;
            let newSize = FunnyManager.manager.LabelSize(model.digest, width: WIDTH-30, font: ContentMainTextFont);
            mainTextLabel.height = newSize.height;
            backView.height = newSize.height + 10.0;
            rowHeight = newSize.height + 20;
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None;
        self.backgroundColor = FunnyManager.manager.color(246.0, G: 246.0, B: 246.0);
        self.configUI();
    }

    private func configUI() {
        backView = UIView(frame: CGRectMake(10, 10, WIDTH-20, 0));
        backView.backgroundColor = UIColor.whiteColor();
        self.contentView.addSubview(backView);
        
        mainTextLabel = UILabel(frame: CGRectMake(5, 5, WIDTH-30, 0));
        mainTextLabel.numberOfLines = 0;
        mainTextLabel.font = UIFont.systemFontOfSize(ContentMainTextFont);
        backView.addSubview(mainTextLabel);
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

}
