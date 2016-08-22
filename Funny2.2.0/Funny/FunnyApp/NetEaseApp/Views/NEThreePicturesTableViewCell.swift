//
//  NEThreePicturesTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 16/1/4.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class NEThreePicturesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftImageView: UIImageView!
    
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var middleImageView: UIImageView!
    
    var model: NetEaseModel! {
        didSet{
            titleLabel.text = model.title;
            leftImageView.sd_setImageWithURL(NSURL(string: model.imgsrc), placeholderImage: SmallImage);
            
            print(model.imgextra);
            let middleImageURL = model.imgextra[0]["imgsrc"] as! String;
            middleImageView.sd_setImageWithURL(NSURL(string: middleImageURL), placeholderImage: SmallImage);
            
            let rightImageURL = model.imgextra[1]["imgsrc"] as! String;
            rightImageView.sd_setImageWithURL(NSURL(string: rightImageURL), placeholderImage: SmallImage);
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
