//
//  UCNewsPictureTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 15/12/31.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class UCNewsPictureTableViewCell: UITableViewCell {

    @IBOutlet private weak var onlyImageView: UIImageView!
    
    @IBOutlet private weak var bottomLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyle.None;
        self.backgroundColor = FunnyManager.manager.color(246.0, G: 246.0, B: 246.0);
    }

    var model: UCNewsModel! {
        didSet{
            titleLabel.text = model.title;
            let time = model.publish_time.longLongValue / 1000;
            bottomLabel.text = FunnyManager.manager.dateWithTimeInterval(Int32(time)) + "   " + model.origin_src_name;
            let dict = model.thumbnails[0] as! Dictionary<String,AnyObject>;
            let url = dict["url"] as! String;
            onlyImageView.sd_setImageWithURL(NSURL(string: url), placeholderImage: SmallImage);
        }
    }
    
}
