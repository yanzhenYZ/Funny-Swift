//
//  WindowViewManager.swift
//  Funny
//
//  Created by yanzhen on 16/7/29.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit
import AVFoundation
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


class WindowViewManager: NSObject, WindowViewProtocol {

    fileprivate var player: AVPlayer? = nil
    fileprivate var playerLayer: AVPlayerLayer?
    fileprivate var urlStr: String?
    fileprivate var isPlayEnd: Bool? = false;
    fileprivate var enterBackground: Bool = false
    fileprivate var isPause: Bool = false;
    fileprivate var isPlaying: Bool = false
    
    func isWindowViewShow() ->Bool {
        return !self.windowView.isHidden;
    }
    
    func videoPlayWithVideoUrlString(_ urlString: String) {
        urlStr = urlString;
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        appDelegate.showVideoWindow();
        appDelegate.videoWindow.makeWindowView(self.windowView);
        self.windowView.isHidden = false;
        self.startPlayVideo(urlString);
    }
    
    fileprivate func startPlayVideo(_ urlString: String) {
        self.windowView.playBtn.isSelected = false;
        self.windowView.loadingView.isHidden = false;
        self.windowView.loadingView.tipLabel.isHidden = true;
        self.windowView.loadingView.indicator.startAnimating();
        isPause = false;
        
        let url = URL(string: urlString);
        let playerItem = AVPlayerItem(url: url!);
        DispatchQueue.main.async(execute: { () -> Void in
            if self.isPlayEnd! && self.player?.currentItem != nil {
                NotificationCenter.default.removeObserver(self);
                self.player?.currentItem!.removeObserver(self, forKeyPath: "status");
                self.player?.replaceCurrentItem(with: playerItem);
            }else{
                self.player = AVPlayer(playerItem: playerItem);
                self.playerLayer = AVPlayerLayer(player: self.player);
                self.playerLayer!.backgroundColor = UIColor.clear.cgColor;
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
        self.windowView.playBtn.isSelected = true;
        self.timer.fireDate = Date.distantFuture;
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
            self.timer.fireDate = Date.distantFuture;
        }
        self.windowView.isHidden = true;
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        appDelegate.videoWindow.isHidden = true;
        appDelegate.window?.makeKeyAndVisible();
//        self.windowView = nil;
        
    }
    
    func videoPlayOrPause(_ playBtn: UIButton) {
        let block:(Bool) ->Void = { pause in
            self.isPause = pause;
            playBtn.isSelected = pause;
            self.isPlaying = !pause;
            if pause {
                self.player?.pause();
                self.timer.fireDate = Date.distantFuture;
            }else{
                self.player?.play();
                self.timer.fireDate = Date.distantPast;
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
        self.windowView.playBtn.isSelected = true;
    }
    
//MARK: - observe
    func addNotifi(_ item: AVPlayerItem) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.playVideoEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil);
        item.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.new, context: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.didBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil);
    }
    
    func didEnterBackground() {
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
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            let playItem = self.player?.currentItem;
            if playItem?.status.rawValue == AVPlayerStatus.readyToPlay.rawValue {
                self.timer.fireDate = Date.distantPast;
                self.windowView.loadingView.indicator.stopAnimating();
                self.windowView.loadingView.isHidden = true;
            }else if playItem?.status.rawValue == AVPlayerStatus.failed.rawValue {
                self.isPlayEnd = false;
                isPlaying = false;
                self.windowView.loadingView.tipLabel.isHidden = false;
                self.player?.currentItem!.removeObserver(self, forKeyPath: "status");
                self.timer.fireDate = Date.distantFuture;
            }
        }
    }
//MARK: - lazy
    lazy var timer: Timer = {
        let time = Timer(timeInterval: 0.1, target: self, selector: #selector(self.updateProgress), userInfo: nil, repeats: true);
        RunLoop.current.add(time, forMode: RunLoopMode.commonModes);
        return time;
    }()
    
    lazy var windowView: WindowView = {
        let windowView = WindowView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: WIDTH / 4 * 3 + 4));
        windowView.delegate = self;
        windowView.isHidden = true;
//        let window = UIApplication.sharedApplication().keyWindow;
//        window!.addSubview(windowView);
        return windowView;
    }()
    
//MARK: - 单例
    //1
    struct Static {
        static var onceToken: Int = 0;
        static var instance: WindowViewManager? = nil;
    }
    
    private static var __once: () = {
        Static.instance = WindowViewManager();
    }()
    
    class var shareWindowVideoManage : WindowViewManager {
        _ = WindowViewManager.__once
        return Static.instance!
    }

    deinit {
        NotificationCenter.default.removeObserver(self);
    }
}
