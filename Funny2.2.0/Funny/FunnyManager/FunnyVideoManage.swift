//
//  FunnyVideoManage.swift
//  Test
//
//  Created by yanzhen on 15/12/25.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
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


class FunnyVideoManage: NSObject {
   
   /**
    *曾经播放过视频
    */
    fileprivate var isPlayEnd: Bool? = false;
    fileprivate var player: AVPlayer? = nil;
    fileprivate var playerLayer: AVPlayerLayer?
    fileprivate var videoCell: VideoSuperTableViewCell?
    fileprivate var urlStr: String?
    fileprivate var enterBackground: Bool = false
    
    func playVideo(_ cell: VideoSuperTableViewCell, urlString: String) {
        if !self.startPlayNewAV(urlString, play: cell.playButton.isSelected) {
            return;
        }
        self.playVideoInterrupt();
        self.urlStr = urlString;
        videoCell = cell;
        videoCell?.isPause = false;
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
                self.playerLayer!.backgroundColor = UIColor.black.cgColor;
                self.isPlayEnd = true;
            }
            self.playerLayer!.frame = cell.mainImageView.bounds;
            self.videoCell!.mainImageView.layer.addSublayer(self.playerLayer!);
            
            let layer = CALayer();
            layer.frame = cell.mainImageView.bounds;
            layer.backgroundColor = UIColor.clear.cgColor;
            self.layerDelegate.rightSpace = cell.rightSpace;
            layer.delegate = self.layerDelegate;
            layer.setNeedsDisplay();
            cell.mainImageView.layer.addSublayer(layer);
            
            self.addNotifi(playerItem);
            self.player!.play();
        })
    }
    
    func startPlayNewAV(_ urlString: String!, play: Bool) ->Bool {
        var start: Bool = true;
        if urlString == urlStr {
            if play {
                videoCell?.isPause = false;
                self.player?.play();
                self.timer.fireDate = Date.distantPast;
            }else{
                videoCell?.isPause = true;
                self.player?.pause();
                self.timer.fireDate = Date.distantFuture;
            }
            start = false;
        }
        return start;
    }
    
    func playVideoEnd() {
        videoCell?.playButton.isSelected = false;
        if videoCell?.mainImageView.layer.sublayers!.count > 1{
            let subLayer: AnyObject? = videoCell!.mainImageView.layer.sublayers![0];
            let subLayer1: AnyObject? = videoCell!.mainImageView.layer.sublayers![1];
            subLayer?.removeFromSuperlayer();
            subLayer1?.removeFromSuperlayer();
        }
        videoCell?.progressView.setProgress(0.0, animated: false);
        self.timer.fireDate = Date.distantFuture;
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

    func didEnterBackground() {
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
    
    fileprivate func willEnterBackground(_ status: Bool) {
        videoCell?.playButton.isSelected = !status;
        videoCell!.isPause = status;
        enterBackground = status;
    }
//MARK: - observe
    
    func addNotifi(_ item: AVPlayerItem) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.playVideoEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil);
        item.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.new, context: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.didBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil);
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            let playItem = self.player?.currentItem;
            if playItem?.status.rawValue == AVPlayerStatus.readyToPlay.rawValue {
                self.timer.fireDate = Date.distantPast;
            }else if playItem?.status.rawValue == AVPlayerStatus.failed.rawValue {
                self.isPlayEnd = false;
                self.player?.currentItem!.removeObserver(self, forKeyPath: "status");
                self.timer.fireDate = Date.distantFuture;
            }
        }
    }
//MARK: - lazy
    lazy var timer:Timer = {
        let time = Timer(timeInterval: 0.1, target: self, selector: #selector(self.updateProgress), userInfo: nil, repeats: true);
        RunLoop.current.add(time, forMode: RunLoopMode.commonModes);
        return time;
    }()
    
    lazy var layerDelegate: LayerDelegate = {
        let layerDelegate = LayerDelegate();
        return layerDelegate;
    }()
//MARK: - 单例
    struct Static {
        static var onceToken: Int = 0;
        static var instance: FunnyVideoManage? = nil;
    }
    
    private static var __once: () = {
        Static.instance = FunnyVideoManage();
    }()
    
    class var shareVideoManage : FunnyVideoManage {
        _ = FunnyVideoManage.__once
        return Static.instance!
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
}
