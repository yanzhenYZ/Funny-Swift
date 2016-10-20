//
//  YZCircleView.swift
//  test1
//
//  Created by yanzhen on 16/10/18.
//  Copyright © 2016年 v2tech. All rights reserved.
//

import UIKit

class YZCircleView: UIView {

    fileprivate var circleLayer: CAShapeLayer!
    fileprivate var progressLayer: CAShapeLayer!
    fileprivate var titleLabel: UILabel!
    fileprivate var subTitleLabel: UILabel!
    
    init(frame: CGRect, radius: CGFloat) {
        super.init(frame: frame);
        self.clipsToBounds = true;
        let width = frame.size.width;
        let height = frame.size.height;
        let lineWidth: CGFloat = 2.0;
        
        circleLayer = CAShapeLayer();
        circleLayer.frame = self.bounds;
        circleLayer.fillColor = UIColor.clear.cgColor;
        circleLayer.strokeColor = UIColor.gray.cgColor;
        circleLayer.opacity = 0.25;
        circleLayer.lineCap = kCALineCapRound;
        circleLayer.lineWidth = lineWidth;
        self.layer.addSublayer(circleLayer);
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: width * 0.5, y: height * 0.5), radius: radius, startAngle: -CGFloat(M_PI_2), endAngle: CGFloat(M_PI_2) * 3 , clockwise: true);
        circleLayer.path = circlePath.cgPath;
        
        progressLayer = CAShapeLayer();
        progressLayer.frame = self.bounds;
        progressLayer.fillColor = UIColor.clear.cgColor;
        progressLayer.strokeColor = UIColor(colorLiteralRed: 1.0, green: 133/255.0, blue: 25/255.0, alpha: 1.0).cgColor;
        progressLayer.lineCap = kCAFillRuleNonZero;
        progressLayer.strokeEnd = 0.0;
        progressLayer.lineWidth = lineWidth;
        self.layer.addSublayer(progressLayer);
        let progressPath = UIBezierPath(arcCenter: CGPoint(x: width * 0.5, y: height * 0.5), radius: radius, startAngle: -CGFloat(M_PI_2), endAngle: CGFloat(M_PI_2) * 3 , clockwise: true);
        progressLayer.path = progressPath.cgPath;
        
        var labelHeight: CGFloat = 25.0;
        if radius < (labelHeight + lineWidth) {
            labelHeight = radius - lineWidth;
        }
        titleLabel = UILabel(frame: CGRect(x: width * 0.5 - radius + lineWidth, y: height * 0.5 - labelHeight, width: 2 * radius - 2 * lineWidth, height: labelHeight));
        titleLabel.font = UIFont.systemFont(ofSize: 14.0);
        titleLabel.textAlignment = .center;
        titleLabel.textColor = UIColor(colorLiteralRed: 104/255.0, green: 99/255.0, blue: 107/255.0, alpha: 1.0);
        self.addSubview(titleLabel);
        
        subTitleLabel = UILabel(frame: CGRect(x: width * 0.5 - radius + lineWidth, y: height * 0.5, width: 2 * radius - 2 * lineWidth, height: labelHeight));
        subTitleLabel.font = UIFont.systemFont(ofSize: 15.0);
        subTitleLabel.textAlignment = .center;
        subTitleLabel.textColor = UIColor(colorLiteralRed: 14/255.0, green: 110/255.0, blue: 251/255.0, alpha: 1.0);
        self.addSubview(subTitleLabel);
    }
    
    func setProgress(progress: CGFloat) {
        CATransaction.begin();
        CATransaction.setDisableActions(true);
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn));
        CATransaction.setAnimationDuration(1.0);
        var strokeEnd = progress < 0.0 ? 0.0 : progress;
        strokeEnd = progress > 1.0 ? 1.0 : progress;
        progressLayer.strokeEnd = strokeEnd;
        CATransaction.commit();
    }
    
    var title: String! {
        didSet {
            titleLabel.text = title;
        }
    }
    
    var subTitle: String! {
        didSet {
            subTitleLabel.text = subTitle;
        }
    }
    
    var titleFontSize: CGFloat! {
        didSet{
            titleLabel.font = UIFont.systemFont(ofSize: titleFontSize);
        }
    }

    var subTitleFontSize: CGFloat! {
        didSet{
            subTitleLabel.font = UIFont.systemFont(ofSize: subTitleFontSize);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
