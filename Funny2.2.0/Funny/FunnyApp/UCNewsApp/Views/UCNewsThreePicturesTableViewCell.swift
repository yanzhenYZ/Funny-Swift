//
//  UCNewsThreePicturesTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 15/12/31.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class UCNewsThreePicturesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var middleImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var bottomLabel: UILabel!
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
            
            let dict1 = model.thumbnails[0] as! Dictionary<String,AnyObject>;
            let url1 = dict1["url"] as! String;
            leftImageView.sd_setImageWithURL(NSURL(string: url1), placeholderImage: SmallImage);
            
            let dict2 = model.thumbnails[1] as! Dictionary<String,AnyObject>;
            let url2 = dict2["url"] as! String;
            middleImageView.sd_setImageWithURL(NSURL(string: url2), placeholderImage: SmallImage);
            
            let dict3 = model.thumbnails[2] as! Dictionary<String,AnyObject>;
            let url3 = dict3["url"] as! String;
            rightImageView.sd_setImageWithURL(NSURL(string: url3), placeholderImage: SmallImage);
        }
    }
    
}
