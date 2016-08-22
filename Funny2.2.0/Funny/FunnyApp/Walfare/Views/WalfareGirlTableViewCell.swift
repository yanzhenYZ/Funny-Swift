//
//  WalfareGirlTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 15/12/30.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class WalfareGirlTableViewCell: WalfarePictureTableViewCell {

    override func configSecondSuperUI() {
        mainImageView = UIImageView(frame: CGRectMake(10, CGRectGetMaxY(mainTextLabel.frame)+5, WIDTH-20, 0));
        mainImageView.userInteractionEnabled = true;
        self.contentView.addSubview(mainImageView);
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longGestureAction(_:)));
        longGesture.minimumPressDuration = 1.0;
        mainImageView.addGestureRecognizer(longGesture);
    }
    
    func longGestureAction(tap: UILongPressGestureRecognizer) {
        if tap.state != UIGestureRecognizerState.Began {
            return;
        }
        let tapView = tap.view as! UIImageView;
        FunnyManager.manager.saveImage(tapView.image!);
    }
}
