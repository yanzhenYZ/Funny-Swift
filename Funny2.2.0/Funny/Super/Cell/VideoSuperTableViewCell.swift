//
//  VideoSuperTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 15/12/25.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

protocol VideoPlayBtnActionDelegate : NSObjectProtocol {
    func playVideoStart(_ button: UIButton);
    func playVideoOnWindow(_ videoCell: VideoSuperTableViewCell)
}
class VideoSuperTableViewCell: UITableViewCell {

    weak var delegate: VideoPlayBtnActionDelegate?
    var noShare: Bool! = false
    var shareTitle: String!
    var shareURL: String!
    var _backView: UIView!
    var _headView: ContentHeadView!
    var mainImageView: UIImageView!
    var playButton: UIButton!
    var progressView: UIProgressView!
    var rowHeight: CGFloat!
    var _userTextLabel: UILabel!
    var rightSpace: CGFloat! = 0
    var isPause: Bool = false
    
    internal func refresh() -> Bool {
        return playButton.isSelected || isPause;
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.none;
        self.backgroundColor = FunnyManager.manager.color(246.0, G: 246.0, B: 246.0);
        let longGesture = UILongPressGestureRecognizer(target: self, action:  #selector(self.longGestureAction(_:)));
        self.addGestureRecognizer(longGesture);
        let pin = UIPinchGestureRecognizer(target: self, action: #selector(self.pinAction(_:)));
        self.addGestureRecognizer(pin);
        
        self.configSuperUI();
        self.configSuperSecondUI();
    }
    
    func pinAction(_ pin: UIPinchGestureRecognizer) {
        if pin.state == .began {
            if self.playButton.isSelected || self.isPause {
                delegate?.playVideoOnWindow(self);
            }
        }
    }
    
    func longGestureAction(_ longGesture: UILongPressGestureRecognizer) {
        //内涵段子不可以分享
        if noShare! {
            return;
        }
        if longGesture.state == UIGestureRecognizerState.began {
            let message = WXMediaMessage();
            if shareTitle != nil {
                message.title = shareTitle;
            }else{
                message.title = "搞笑视频";
            }
            
            var data = UIImageJPEGRepresentation(mainImageView.image!, 0.3);
            var scale: CGFloat = 0.2;
            for _ in 0 ..< 3 {
                scale *= 0.5;
                if (data?.count)! / 1000 > 16 {
                    data = UIImageJPEGRepresentation(mainImageView.image!, scale);
                }else{
                    break;
                }
            }
            var image = UIImage(data: data!);
            if (data?.count)! / 1000 > 17 {
                image = UIImage(named: "play");
            }
            message.setThumbImage(image);
            
            let ext = WXVideoObject();
            if shareURL != nil {
                print(shareURL);
                ext.videoUrl = shareURL;
            }else{
                ext.videoUrl = "http://www.baidu.com";
            }
            message.mediaObject = ext;
            let req = SendMessageToWXReq();
            req.bText = false;
            req.message = message;
            req.scene = Int32(1);
            WXApi.send(req);
        }
    }
    
    func configSuperUI() {
        _backView = UIView(frame: CGRect(x: 5.0, y: 5.0, width: WIDTH - 10.0, height: 0.0));
        _backView.backgroundColor = UIColor.white;
        self.contentView.addSubview(_backView);
        
        _headView = ContentHeadView(frame: CGRect(x: 10.0, y: 10.0, width: WIDTH - 20, height: 50.0));
        self.contentView.addSubview(_headView);
        
        _userTextLabel = UILabel(frame: CGRect(x: 15.0, y: 65.0, width: WIDTH - 25.0, height: 0.0));
        _userTextLabel.font = UIFont.systemFont(ofSize: ContentMainTextFont);
        _userTextLabel.numberOfLines = 0;
        self.contentView.addSubview(_userTextLabel);
        
        mainImageView = UIImageView(frame: CGRect(x: 10.0, y: _userTextLabel.frame.maxY + 10.0, width: WIDTH - 20.0, height: 0));
        mainImageView.contentMode = UIViewContentMode.scaleAspectFill;
        mainImageView.clipsToBounds = true;
        self.contentView.addSubview(mainImageView);
        
        progressView = UIProgressView(frame: CGRect(x: 10.0, y: mainImageView.frame.maxY, width: WIDTH - 20.0, height: 2.0));
        progressView.progress = 0.0;
        self.contentView.addSubview(progressView);
        
        playButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 70.0, height: 70.0));
        playButton.backgroundColor = UIColor.clear;
        playButton.setBackgroundImage(UIImage(named: "play_start"), for: UIControlState());
        playButton.setBackgroundImage(UIImage(named: "play_pause"), for: .selected);
        playButton.addTarget(self, action: #selector(self.playButtonClick(_:)), for: UIControlEvents.touchUpInside);
        self.contentView.addSubview(playButton);
    }
    
    func playButtonClick(_ button: UIButton) {
        button.isSelected = !button.isSelected;
        self.delegate?.playVideoStart(button);
    }
    
    func configSuperSecondUI() {
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
