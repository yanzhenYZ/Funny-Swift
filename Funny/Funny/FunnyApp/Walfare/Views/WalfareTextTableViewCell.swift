//
//  WalfareTextTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 15/12/30.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class WalfareTextTableViewCell: WalfareSuperTableViewCell {

    var model: WalfareTextModel! {
        didSet {
            creatTimeLabel.text = FunnyManager.manager.dateWithTimeInterval(Int32(Int(model.update_time)!));
            mainTextLabel.text = model.wbody;
            
            let newSize = FunnyManager.manager.LabelSize(model.wbody, width: WIDTH - 20, font: ContentMainTextFont);
            mainTextLabel.height = newSize.height;
            backView.height = mainTextLabel.frame.maxY + 4.0;
            rowHeight = mainTextLabel.frame.maxY + 8.0;
        }
    }

}
