//
//  WindowView.swift
//  Funny
//
//  Created by yanzhen on 16/7/29.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

protocol WindowViewProtocol: NSObjectProtocol{
    func closeWindowView()
    func videoPlayOrPause(playBtn: UIButton)
    func loadingViewDismissForFail()
}

class WindowView: UIView, WindowLoadingViewProtocol {

    weak var delegate: WindowViewProtocol?
    var mainImageView: UIImageView!
    var progressView: UIProgressView!
    var playBtn: UIButton!
    var loadingView: WindowLoadingView!
    private var effectView: UIVisualEffectView!
    private var closeBtn: UIButton!
    private var topLineView: UIView!
    private var yzView: UIView!
    private var yzLayer: CALayer!
    private var layerDelegate: CALayerDelegate!
    private var beginPoint: CGPoint!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.configUI();
    }
//MARK: - Action
    func closeBtnAction(btn: UIButton) {
        delegate?.closeWindowView();
    }
    
    func playBtnAction(btn: UIButton) {
        delegate?.videoPlayOrPause(btn);
    }
    
//MARK: - WindowLoadingViewProtocol
    func windowLoadingViewDismiss() {
        delegate?.loadingViewDismissForFail();
    }
    
//MARK: - UI
    private func configUI() {
        let effect = UIBlurEffect(style: .Light);
        effectView = UIVisualEffectView(effect: effect);
        effectView.userInteractionEnabled = false;
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
        yzView.backgroundColor = UIColor.clearColor();
        yzLayer = CALayer();
        yzLayer.backgroundColor = UIColor.clearColor().CGColor;
        layerDelegate = CALayerDelegate();
        layerDelegate.left = true;
        yzLayer.delegate = layerDelegate;
        yzView.layer.addSublayer(yzLayer);
        yzLayer.setNeedsDisplay();
        self.addSubview(yzView);
        
        closeBtn = UIButton(type: .Custom);
        closeBtn.backgroundColor = UIColor.clearColor();
        closeBtn.setBackgroundImage(UIImage(named: "closeWindowView"), forState: .Normal);
        closeBtn.addTarget(self, action: #selector(self.closeBtnAction(_:)), forControlEvents: .TouchUpInside);
        self.addSubview(closeBtn);
        
        playBtn = UIButton(type: .Custom);
        playBtn.setImage(UIImage(named: "WindowViewPause"), forState: .Selected);
        playBtn.addTarget(self, action: #selector(self.playBtnAction(_:)), forControlEvents: .TouchUpInside);
        self.addSubview(playBtn);
        
        loadingView = WindowLoadingView(frame: CGRectZero);
        loadingView.delegate = self;
        loadingView.hidden = true;
        self.addSubview(loadingView);
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = self.width;
        let height = self.height;
        
        effectView.frame = self.bounds;
        topLineView.frame = CGRectMake(0, 0, width, 2);
        progressView.frame = CGRectMake(0, height - 2, width, 2);
        mainImageView.frame = CGRectMake(0, 2, width, height - 4);
        yzView.frame = CGRectMake(0, 2, width, height - 4);
        yzLayer.frame = yzView.bounds;
        
        
        closeBtn.frame = CGRectMake(width - 30.0, 2 , 30.0, 30.0);
        playBtn.frame = CGRectMake(0, 0, 70 * 1.5, 70 * 1.5);
        playBtn.center = CGPointMake(width * 0.5, height * 0.5);
        
        loadingView.frame = CGRectMake(0, 0, 70, 70);
        loadingView.center = CGPointMake(width * 0.5, height * 0.5);
        if mainImageView.layer.sublayers?.count > 0 {
            for (_,value) in mainImageView.layer.sublayers!.enumerate() {
                value.frame = mainImageView.bounds;
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
