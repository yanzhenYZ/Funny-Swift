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
        mainImageView = UIImageView(frame: CGRect(x: 10, y: mainTextLabel.frame.maxY+5, width: WIDTH-20, height: 0));
        mainImageView.isUserInteractionEnabled = true;
        self.contentView.addSubview(mainImageView);
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longGestureAction(_:)));
        longGesture.minimumPressDuration = 1.0;
        mainImageView.addGestureRecognizer(longGesture);
    }
    
    func longGestureAction(_ tap: UILongPressGestureRecognizer) {
        if tap.state != UIGestureRecognizerState.began {
            return;
        }
        let tapView = tap.view as! UIImageView;
        FunnyManager.manager.saveImage(tapView.image!);
    }
}
