//
//  WindowView.swift
//  Funny
//
//  Created by yanzhen on 16/7/29.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


protocol WindowViewProtocol: NSObjectProtocol{
    func closeWindowView()
    func videoPlayOrPause(_ playBtn: UIButton)
    func loadingViewDismissForFail()
}

class WindowView: UIView, WindowLoadingViewProtocol {

    weak var delegate: WindowViewProtocol?
    var mainImageView: UIImageView!
    var progressView: UIProgressView!
    var playBtn: UIButton!
    var loadingView: WindowLoadingView!
    fileprivate var effectView: UIVisualEffectView!
    fileprivate var closeBtn: UIButton!
    fileprivate var topLineView: UIView!
    fileprivate var yzView: UIView!
    fileprivate var yzLayer: CALayer!
    fileprivate var layerDelegate: LayerDelegate!
    fileprivate var beginPoint: CGPoint!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.configUI();
    }
//MARK: - Action
    func closeBtnAction(_ btn: UIButton) {
        delegate?.closeWindowView();
    }
    
    func playBtnAction(_ btn: UIButton) {
        delegate?.videoPlayOrPause(btn);
    }
    
//MARK: - WindowLoadingViewProtocol
    func windowLoadingViewDismiss() {
        delegate?.loadingViewDismissForFail();
    }
    
//MARK: - UI
    fileprivate func configUI() {
        let effect = UIBlurEffect(style: .light);
        effectView = UIVisualEffectView(effect: effect);
        effectView.isUserInteractionEnabled = false;
        self.addSubview(effectView);
        
        topLineView = UIView();
        topLineView.backgroundColor = FunnyColor;
        self.addSubview(topLineView);
        
        mainImageView = UIImageView();
        self.addSubview(mainImageView);
        
        progressView = UIProgressView();
        progressView.progressTintColor = FunnyColor;
        self.addSubview(progressView);
        
        yzView = UIView();
        yzView.backgroundColor = UIColor.clear;
        yzLayer = CALayer();
        yzLayer.backgroundColor = UIColor.clear.cgColor;
        layerDelegate = LayerDelegate();
        layerDelegate.left = true;
        yzLayer.delegate = layerDelegate;
        yzView.layer.addSublayer(yzLayer);
        yzLayer.setNeedsDisplay();
        self.addSubview(yzView);
        
        closeBtn = UIButton(type: .custom);
        closeBtn.backgroundColor = UIColor.clear;
        closeBtn.setBackgroundImage(UIImage(named: "closeWindowView"), for: UIControlState());
        closeBtn.addTarget(self, action: #selector(self.closeBtnAction(_:)), for: .touchUpInside);
        self.addSubview(closeBtn);
        
        playBtn = UIButton(type: .custom);
        playBtn.setImage(UIImage(named: "WindowViewPause"), for: .selected);
        playBtn.addTarget(self, action: #selector(self.playBtnAction(_:)), for: .touchUpInside);
        self.addSubview(playBtn);
        
        loadingView = WindowLoadingView(frame: CGRect.zero);
        loadingView.delegate = self;
        loadingView.isHidden = true;
        self.addSubview(loadingView);
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = self.width;
        let height = self.height;
        
        effectView.frame = self.bounds;
        topLineView.frame = CGRect(x: 0, y: 0, width: width, height: 2);
        progressView.frame = CGRect(x: 0, y: height - 2, width: width, height: 2);
        mainImageView.frame = CGRect(x: 0, y: 2, width: width, height: height - 4);
        yzView.frame = CGRect(x: 0, y: 2, width: width, height: height - 4);
        yzLayer.frame = yzView.bounds;
        
        
        closeBtn.frame = CGRect(x: width - 30.0, y: 2 , width: 30.0, height: 30.0);
        playBtn.frame = CGRect(x: 0, y: 0, width: 70 * 1.5, height: 70 * 1.5);
        playBtn.center = CGPoint(x: width * 0.5, y: height * 0.5);
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 70, height: 70);
        loadingView.center = CGPoint(x: width * 0.5, y: height * 0.5);
        if mainImageView.layer.sublayers?.count > 0 {
            for (_,value) in mainImageView.layer.sublayers!.enumerated() {
                value.frame = mainImageView.bounds;
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
