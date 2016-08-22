//
//  WindowLoadingView.swift
//  Funny
//
//  Created by yanzhen on 16/7/29.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

protocol WindowLoadingViewProtocol : NSObjectProtocol {
    func windowLoadingViewDismiss()
}

class WindowLoadingView: UIView {

    weak var delegate: WindowLoadingViewProtocol?
    var indicator: UIActivityIndicatorView!
    var tipLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.configUI();
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if !tipLabel.hidden {
            self.hidden = true;
            self.delegate?.windowLoadingViewDismiss();
        }
    }
    
    private func configUI() {
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge);
        indicator.color = FunnyColor;
        indicator.hidesWhenStopped = true;
        self.addSubview(indicator);
        
        tipLabel = UILabel();
        tipLabel.text = "加载失败";
        tipLabel.textAlignment = .Center;
        tipLabel.textColor = FunnyColor;
        tipLabel.font = UIFont.systemFontOfSize(15);
        tipLabel.hidden = true;
        self.addSubview(tipLabel);
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        indicator.center = CGPointMake(self.width * 0.5, self.height * 0.5 - 7);
        tipLabel.frame = CGRectMake(0, self.height - 25, self.width, 25);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
