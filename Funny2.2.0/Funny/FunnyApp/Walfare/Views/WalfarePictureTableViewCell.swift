//
//  WalfarePictureTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 15/12/30.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class WalfarePictureTableViewCell: WalfareSuperTableViewCell {

    var mainImageView: UIImageView!
    
    override func configSecondSuperUI() {
        mainImageView = UIImageView(frame: CGRectMake(10, CGRectGetMaxY(mainTextLabel.frame)+5, WIDTH-20, 0));
        self.contentView.addSubview(mainImageView);
    }
    
     var model: WalfarePictureModel! {
        didSet{
            creatTimeLabel.text = FunnyManager.manager.dateWithTimeInterval(Int32(Int(model.update_time)!));
            mainTextLabel.text = model.wbody;
            
            let newSize = FunnyManager.manager.LabelSize(model.wbody, width: WIDTH - 20, font: ContentMainTextFont);
            mainTextLabel.height = newSize.height;
            
            mainImageView.y = CGRectGetMaxY(mainTextLabel.frame) + 4.0;
            let scale=CGFloat(Int(model.wpic_m_width)!) / CGFloat(WIDTH-20);
            let height=CGFloat(Int(model.wpic_m_height)!) / scale;
            mainImageView.height = height;
            mainImageView.sd_setImageWithURL(NSURL(string: model.wpic_middle), placeholderImage: BigImage);
            
            backView.height = CGRectGetMaxY(mainImageView.frame) + 4;
            rowHeight = CGRectGetMaxY(mainImageView.frame) + 8;
            
        }
    }
}
