//
//  FunnyVideoManage.swift
//  Test
//
//  Created by yanzhen on 15/12/25.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit
import AVFoundation

class FunnyVideoManage: NSObject {
   /**
    *曾经播放过视频
    */
    var isPlayEnd: Bool? = false;
    var player: AVPlayer? = nil;
    var playerLayer: AVPlayerLayer?
    var videoCell: VideoSuperTableViewCell?
    var urlStr: String?
    var enterBackground: Bool = false
    
    func playVideo(cell: VideoSuperTableViewCell, urlString: String) {
        if !self.startPlayNewAV(urlString, play: cell.playButton.selected) {
            return;
        }
        self.playVideoInterrupt();
        self.urlStr = urlString;
        videoCell = cell;
        videoCell?.isPause = false;
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
                self.playerLayer!.backgroundColor = UIColor.blackColor().CGColor;
                self.isPlayEnd = true;
            }
            self.playerLayer!.frame = cell.mainImageView.bounds;
            self.videoCell!.mainImageView.layer.addSublayer(self.playerLayer!);
            
            let layer = CALayer();
            layer.frame = cell.mainImageView.bounds;
            layer.backgroundColor = UIColor.clearColor().CGColor;
            self.layerDelegate.rightSpace = cell.rightSpace;
            layer.delegate = self.layerDelegate;
            layer.setNeedsDisplay();
            cell.mainImageView.layer.addSublayer(layer);
            
            self.addNotifi(playerItem);
            self.player!.play();
        })
    }
    
    func startPlayNewAV(urlString: String!, play: Bool) ->Bool {
        var start: Bool = true;
        if urlString == urlStr {
            if play {
                videoCell?.isPause = false;
                self.player?.play();
                self.timer.fireDate = NSDate.distantPast();
            }else{
                videoCell?.isPause = true;
                self.player?.pause();
                self.timer.fireDate = NSDate.distantFuture();
            }
            start = false;
        }
        return start;
    }
    
    func playVideoEnd() {
        videoCell?.playButton.selected = false;
        if videoCell?.mainImageView.layer.sublayers!.count > 1{
            let subLayer: AnyObject? = videoCell!.mainImageView.layer.sublayers![0];
            let subLayer1: AnyObject? = videoCell!.mainImageView.layer.sublayers![1];
            subLayer?.removeFromSuperlayer();
            subLayer1?.removeFromSuperlayer();
        }
        videoCell?.progressView.setProgress(0.0, animated: false);
        self.timer.fireDate = NSDate.distantFuture();
        videoCell = nil;
        urlStr = nil;
    }
    
    func playVideoInterrupt() {
        urlStr = nil;
        if self.player?.currentItem != nil {
            self.player?.pause();
            self.playVideoEnd();
        }
        //暂停状态下刷新
        if videoCell != nil {
            if videoCell!.isPause {
                self.playVideoEnd();
                videoCell?.isPause = false;
            }
        }
    }
    
    func tableViewReload() {
        self.playVideoInterrupt();
    }
    
    func updateProgress() {
        let currentTime = CGFloat(self.player!.currentTime().value) / CGFloat(self.player!.currentTime().timescale);
        let time = CGFloat(self.player!.currentItem!.duration.value) / CGFloat(self.player!.currentItem!.duration.timescale);
        let progress = CGFloat(currentTime) / CGFloat(time);
        videoCell?.progressView.setProgress(Float(progress), animated: true);
        
    }

    func WillResignActive() {
        if (self.player!.rate > 0) {
            self.player?.pause();
            self.willEnterBackground(true);
        }
    }
    
    func didBecomeActive() {
        if enterBackground {
            self.player?.play();
            self.willEnterBackground(false);
        }
    }
    
    private func willEnterBackground(status: Bool) {
        videoCell?.playButton.selected = !status;
        videoCell!.isPause = status;
        enterBackground = status;
    }
//MARK: - observe
    
    func addNotifi(item: AVPlayerItem) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.playVideoEnd), name: AVPlayerItemDidPlayToEndTimeNotification, object: nil);
        item.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.New, context: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.WillResignActive), name: UIApplicationWillResignActiveNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.didBecomeActive), name: UIApplicationDidBecomeActiveNotification, object: nil);
    }

    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "status" {
            let playItem = self.player?.currentItem;
            if playItem?.status.rawValue == AVPlayerStatus.ReadyToPlay.rawValue {
                self.timer.fireDate = NSDate.distantPast();
            }else if playItem?.status.rawValue == AVPlayerStatus.Failed.rawValue {
                self.isPlayEnd = false;
                self.player?.currentItem!.removeObserver(self, forKeyPath: "status");
                self.timer.fireDate = NSDate.distantFuture();
            }
        }
    }
//MARK: - lazy
    lazy var timer:NSTimer = {
        let time = NSTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateProgress), userInfo: nil, repeats: true);
        NSRunLoop.currentRunLoop().addTimer(time, forMode: NSRunLoopCommonModes);
        return time;
    }()
    
    lazy var layerDelegate:CALayerDelegate = {
        let layerDelegate = CALayerDelegate();
        return layerDelegate;
    }()
//MARK: - 单例
    class var shareVideoManage : FunnyVideoManage {
        
        struct Static {
            static var onceToken: dispatch_once_t = 0;
            static var instance: FunnyVideoManage? = nil;
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = FunnyVideoManage();
        }
        return Static.instance!
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
}
