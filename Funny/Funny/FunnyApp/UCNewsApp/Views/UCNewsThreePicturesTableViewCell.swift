//
//  UCNewsThreePicturesTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 15/12/31.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class UCNewsThreePicturesTableViewCell: UITableViewCell {

    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var leftImageView: UIImageView!
    @IBOutlet fileprivate weak var middleImageView: UIImageView!
    @IBOutlet fileprivate weak var rightImageView: UIImageView!
    @IBOutlet fileprivate weak var bottomLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = UITableViewCellSelectionStyle.none;
        self.backgroundColor = FunnyManager.manager.color(246.0, G: 246.0, B: 246.0);

        
    }

    var model: UCNewsModel! {
        didSet{
            titleLabel.text = model.title;
            let time = model.publish_time.int64Value / 1000;
            bottomLabel.text = FunnyManager.manager.dateWithTimeInterval(Int32(time)) + "   " + model.origin_src_name;
            
            let dict1 = model.thumbnails[0] as! Dictionary<String,AnyObject>;
            let url1 = dict1["url"] as! String;
            leftImageView.sd_setImage(with: URL(string: url1), placeholderImage: SmallImage);
            
            let dict2 = model.thumbnails[1] as! Dictionary<String,AnyObject>;
            let url2 = dict2["url"] as! String;
            middleImageView.sd_setImage(with: URL(string: url2), placeholderImage: SmallImage);
            
            let dict3 = model.thumbnails[2] as! Dictionary<String,AnyObject>;
            let url3 = dict3["url"] as! String;
            rightImageView.sd_setImage(with: URL(string: url3), placeholderImage: SmallImage);
        }
    }
    
}
