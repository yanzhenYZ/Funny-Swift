//
//  VideoSuperTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 15/12/25.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

protocol VideoPlayBtnActionDelegate : NSObjectProtocol {
    func playVideoStart(button: UIButton);
    func playVideoOnWindow(videoCell: VideoSuperTableViewCell)
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
        return playButton.selected || isPause;
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None;
        self.backgroundColor = FunnyManager.manager.color(246.0, G: 246.0, B: 246.0);
        let longGesture = UILongPressGestureRecognizer(target: self, action:  #selector(self.longGestureAction(_:)));
        self.addGestureRecognizer(longGesture);
        let pin = UIPinchGestureRecognizer(target: self, action: #selector(self.pinAction(_:)));
        self.addGestureRecognizer(pin);
        
        self.configSuperUI();
        self.configSuperSecondUI();
    }
    
    func pinAction(pin: UIPinchGestureRecognizer) {
        if pin.state == .Began {
            if self.playButton.selected || self.isPause {
                delegate?.playVideoOnWindow(self);
            }
        }
    }
    
    func longGestureAction(longGesture: UILongPressGestureRecognizer) {
        //内涵段子不可以分享
        if noShare! {
            return;
        }
        if longGesture.state == UIGestureRecognizerState.Began {
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
                if (data?.length)! / 1000 > 16 {
                    data = UIImageJPEGRepresentation(mainImageView.image!, scale);
                }else{
                    break;
                }
            }
            var image = UIImage(data: data!);
            if (data?.length)! / 1000 > 17 {
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
            WXApi.sendReq(req);
        }
    }
    
    func configSuperUI() {
        _backView = UIView(frame: CGRectMake(5.0, 5.0, WIDTH - 10.0, 0.0));
        _backView.backgroundColor = UIColor.whiteColor();
        self.contentView.addSubview(_backView);
        
        _headView = ContentHeadView(frame: CGRectMake(10.0, 10.0, WIDTH - 20, 50.0));
        self.contentView.addSubview(_headView);
        
        _userTextLabel = UILabel(frame: CGRectMake(15.0, 65.0, WIDTH - 25.0, 0.0));
        _userTextLabel.font = UIFont.systemFontOfSize(ContentMainTextFont);
        _userTextLabel.numberOfLines = 0;
        self.contentView.addSubview(_userTextLabel);
        
        mainImageView = UIImageView(frame: CGRectMake(10.0, CGRectGetMaxY(_userTextLabel.frame) + 10.0, WIDTH - 20.0, 0));
        mainImageView.contentMode = UIViewContentMode.ScaleAspectFill;
        mainImageView.clipsToBounds = true;
        self.contentView.addSubview(mainImageView);
        
        progressView = UIProgressView(frame: CGRectMake(10.0, CGRectGetMaxY(mainImageView.frame), WIDTH - 20.0, 2.0));
        progressView.progress = 0.0;
        self.contentView.addSubview(progressView);
        
        playButton = UIButton(frame: CGRectMake(0.0, 0.0, 70.0, 70.0));
        playButton.backgroundColor = UIColor.clearColor();
        playButton.setBackgroundImage(UIImage(named: "play_start"), forState: .Normal);
        playButton.setBackgroundImage(UIImage(named: "play_pause"), forState: .Selected);
        playButton.addTarget(self, action: #selector(self.playButtonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        self.contentView.addSubview(playButton);
    }
    
    func playButtonClick(button: UIButton) {
        button.selected = !button.selected;
        self.delegate?.playVideoStart(button);
    }
    
    func configSuperSecondUI() {
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
