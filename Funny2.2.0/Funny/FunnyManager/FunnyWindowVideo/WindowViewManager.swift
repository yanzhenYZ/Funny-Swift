//
//  WindowViewManager.swift
//  Funny
//
//  Created by yanzhen on 16/7/29.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit
import AVFoundation

class WindowViewManager: NSObject, WindowViewProtocol {

    var player: AVPlayer? = nil
    var playerLayer: AVPlayerLayer?
    var urlStr: String?
    var isPlayEnd: Bool? = false;
    var enterBackground: Bool = false
    var isPause: Bool = false;
    var isPlaying: Bool = false
    
    func isWindowViewShow() ->Bool {
        return !self.windowView.hidden;
    }
    
    func videoPlayWithVideoUrlString(urlString: String) {
        urlStr = urlString;
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        appDelegate.showVideoWindow();
        appDelegate.videoWindow.makeWindowView(self.windowView);
        self.windowView.hidden = false;
        self.startPlayVideo(urlString);
    }
    
    private func startPlayVideo(urlString: String) {
        self.windowView.playBtn.selected = false;
        self.windowView.loadingView.hidden = false;
        self.windowView.loadingView.tipLabel.hidden = true;
        self.windowView.loadingView.indicator.startAnimating();
        isPause = false;
        
        let url = NSURL(string: urlString);
        let playerItem = AVPlayerItem(URL: url!);
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            if self.isPlayEnd! && self.player?.currentItem != nil {
                NSNotificationCenter.defaultCenter().removeObserver(self);
                self.player?.currentItem!.removeObserver(self, forKeyPath: "status");
                self.player?.replaceCurrentItemWithPlayerItem(playerItem);
            }else{
                self.player = AVPlayer(playerItem: playerItem);
                self.playerLayer = AVPlayerLayer(player: self.player);
                self.playerLayer!.backgroundColor = UIColor.clearColor().CGColor;
                self.isPlayEnd = true;
            }
            self.playerLayer!.frame = self.windowView.mainImageView.bounds;
            self.windowView.mainImageView.layer.addSublayer(self.playerLayer!);
            self.addNotifi(playerItem);
            self.player!.play();
            self.isPlaying = true;
        })
    }
    

    func playVideoEnd() {
        isPlaying = false;
        self.windowView.playBtn.selected = true;
        self.timer.fireDate = NSDate.distantFuture();
        self.windowView.progressView.setProgress(0.0, animated: false);
    }
    
    func updateProgress() {
        let currentTime = CGFloat(self.player!.currentTime().value) / CGFloat(self.player!.currentTime().timescale);
        let time = CGFloat(self.player!.currentItem!.duration.value) / CGFloat(self.player!.currentItem!.duration.timescale);
        let progress = CGFloat(currentTime) / CGFloat(time);
        self.windowView.progressView.setProgress(Float(progress), animated: true);
    }
    
//MARK: - WindowViewProtocol
    func closeWindowView() {
        if self.player?.rate > 0 || isPlaying {
            self.player?.pause();
            self.timer.fireDate = NSDate.distantFuture();
        }
        self.windowView.hidden = true;
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        appDelegate.videoWindow.hidden = true;
        appDelegate.window?.makeKeyAndVisible();
//        self.windowView = nil;
        
    }
    
    func videoPlayOrPause(playBtn: UIButton) {
        let block:(Bool) ->Void = { pause in
            self.isPause = pause;
            playBtn.selected = pause;
            self.isPlaying = !pause;
            if pause {
                self.player?.pause();
                self.timer.fireDate = NSDate.distantFuture();
            }else{
                self.player?.play();
                self.timer.fireDate = NSDate.distantPast();
            }
        }
        
        if isPlaying {
            block(true);
        }else{
            if isPause {
                block(false);
            }else{
                self.startPlayVideo(urlStr!);
            }
        }
    }
    
    func loadingViewDismissForFail() {
        self.windowView.playBtn.selected = true;
    }
    
//MARK: - observe
    func addNotifi(item: AVPlayerItem) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.playVideoEnd), name: AVPlayerItemDidPlayToEndTimeNotification, object: nil);
        item.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.New, context: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.WillResignActive), name: UIApplicationWillResignActiveNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.didBecomeActive), name: UIApplicationDidBecomeActiveNotification, object: nil);
    }
    
    func WillResignActive() {
        if self.player?.rate > 0 || isPlaying {
            self.player?.pause();
            enterBackground = true;
        }
    }
    
    func didBecomeActive() {
        if enterBackground {
            enterBackground = false;
            self.player?.play();
            isPlaying = true;
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "status" {
            let playItem = self.player?.currentItem;
            if playItem?.status.rawValue == AVPlayerStatus.ReadyToPlay.rawValue {
                self.timer.fireDate = NSDate.distantPast();
                self.windowView.loadingView.indicator.stopAnimating();
                self.windowView.loadingView.hidden = true;
            }else if playItem?.status.rawValue == AVPlayerStatus.Failed.rawValue {
                self.isPlayEnd = false;
                isPlaying = false;
                self.windowView.loadingView.tipLabel.hidden = false;
                self.player?.currentItem!.removeObserver(self, forKeyPath: "status");
                self.timer.fireDate = NSDate.distantFuture();
            }
        }
    }
//MARK: - lazy
    lazy var timer: NSTimer = {
        let time = NSTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateProgress), userInfo: nil, repeats: true);
        NSRunLoop.currentRunLoop().addTimer(time, forMode: NSRunLoopCommonModes);
        return time;
    }()
    
    lazy var windowView: WindowView = {
        let windowView = WindowView(frame: CGRectMake(0, 0, WIDTH, WIDTH / 4 * 3 + 4));
        windowView.delegate = self;
        windowView.hidden = true;
//        let window = UIApplication.sharedApplication().keyWindow;
//        window!.addSubview(windowView);
        return windowView;
    }()
    
//MARK: - 单例
    class var shareWindowVideoManage : WindowViewManager {
        
        struct Static {
            static var onceToken: dispatch_once_t = 0;
            static var instance: WindowViewManager? = nil;
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = WindowViewManager();
        }
        return Static.instance!
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
}
