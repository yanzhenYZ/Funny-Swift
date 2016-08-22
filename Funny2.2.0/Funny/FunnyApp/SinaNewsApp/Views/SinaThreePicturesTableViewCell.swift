//
//  SinaThreePicturesTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 16/1/5.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class SinaThreePicturesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var middleImageView: UIImageView!
    
    var model: SinaNewsModel! {
        didSet{
            titleLab.text = model.title;
            
            let listArray = model.pics["list"] as! Array<AnyObject>;
            let image1 = listArray[0]["kpic"] as! String;
            let image2 = listArray[1]["kpic"] as! String;
            let image3 = listArray[2]["kpic"] as! String;
            
            leftImageView.sd_setImageWithURL(NSURL(string: image1), placeholderImage: SmallImage);
            middleImageView.sd_setImageWithURL(NSURL(string: image2), placeholderImage: SmallImage);
            rightImageView.sd_setImageWithURL(NSURL(string: image3), placeholderImage: SmallImage);
        }
    }
}
