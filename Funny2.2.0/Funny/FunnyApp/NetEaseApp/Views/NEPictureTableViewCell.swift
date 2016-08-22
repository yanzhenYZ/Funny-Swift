//
//  NEPictureTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 16/1/4.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class NEPictureTableViewCell: UITableViewCell {

    @IBOutlet weak var onlyImageView: UIImageView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var model: NetEaseModel! {
        didSet{
            titleLabel.text = model.title;
            subTitleLabel.text = model.digest;
            onlyImageView.sd_setImageWithURL(NSURL(string: model.imgsrc), placeholderImage: SmallImage);
        }
    }
}
