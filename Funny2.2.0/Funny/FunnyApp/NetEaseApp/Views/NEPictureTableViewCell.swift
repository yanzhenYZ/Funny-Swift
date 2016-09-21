//
//  NEPictureTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 16/1/4.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class NEPictureTableViewCell: UITableViewCell {

    @IBOutlet fileprivate weak var onlyImageView: UIImageView!
    @IBOutlet fileprivate weak var subTitleLabel: UILabel!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    
    var model: NetEaseModel! {
        didSet{
            titleLabel.text = model.title;
            subTitleLabel.text = model.digest;
            onlyImageView.sd_setImage(with: URL(string: model.imgsrc), placeholderImage: SmallImage);
        }
    }
}
