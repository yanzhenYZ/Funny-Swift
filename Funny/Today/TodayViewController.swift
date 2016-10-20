//
//  TodayViewController.swift
//  Today
//
//  Created by yanzhen on 16/10/12.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    fileprivate var network: YZNetwork!
    fileprivate var cpu: YZCPU!
    fileprivate var timer: Timer!
    
    fileprivate var cpuView: YZCircleView!
    fileprivate var memoryView: YZCircleView!
    fileprivate var netWorkView: YZCircleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded;
//MARK: - 如果去掉storyboard启动就会崩溃
        let titles = ["内涵段子","快手","记事本","二维码"];
        let images = ["content","gifShow","note","QR"];
        
        let space: CGFloat = 10.0;
        let maximumSize = self.extensionContext?.widgetMaximumSize(for: .expanded);
        let btnWidth = (maximumSize!.width - 5.0 * space) / 4;
        let btnHeight = maximumSize!.height - 20.0;
        for i: Int in 0 ..< 4 {
            let btn = ExtensionButton(frame: CGRect(x: space + (btnWidth + space) * CGFloat(i), y: 10, width: btnWidth, height: btnHeight));
            btn.tag = 100 + i;
            let image = UIImage(named: images[i]);
            btn.setImage(image, for: .normal);
            btn.setTitle(titles[i], for: .normal);
            btn.addTarget(self, action: #selector(self.extensionButtonAction(btn:)), for: .touchUpInside);
            self.view.addSubview(btn);
        }

        unowned let weakSelf = self
        
        let bottomSpace = (maximumSize!.width - 90.0 * 3) / 4;
        var x1 = bottomSpace;
        cpuView = YZCircleView(frame: CGRect(x: x1, y: 120, width: 90, height: 90), radius: 42.5);
        cpuView.title = "CPU";
        self.view.addSubview(cpuView);
        cpu = YZCPU();
        cpu.startMonitorCPUUsage(withTimeInterval: 1.0) { (usage) in
            weakSelf.cpuView.subTitle = String(format: "%.1f", usage * 100) + "%";
            weakSelf.cpuView.setProgress(progress: usage);
        };
        
        x1 = bottomSpace + (bottomSpace + 90);
        memoryView = YZCircleView(frame: CGRect(x: x1, y: 120, width: 90, height: 90), radius: 42.5);
        memoryView.titleFontSize = 13.0;
        memoryView.subTitleFontSize = 13.0;
        memoryView.title = "空间剩余";
        let totalSize = YZDevice.getTotalDiskSize();
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            let availableSize = YZDevice.getAvailableDiskSize();
            weakSelf.memoryView.subTitle = String(format: "%.1fG/%.1fG", CGFloat(availableSize) / 1024.0 / 1024 / 1024,CGFloat(totalSize) / 1024.0 / 1024 / 1024);
            weakSelf.memoryView.setProgress(progress: 1 - CGFloat(availableSize) / CGFloat(totalSize));
        });
        RunLoop.current.add(timer, forMode: .commonModes);
        self.view.addSubview(memoryView);
        
        x1 = bottomSpace + (bottomSpace + 90) * 2;
        netWorkView = YZCircleView(frame: CGRect(x: x1, y: 120, width: 90, height: 90), radius: 42.5);
        netWorkView.title = "无网络";
        self.view.addSubview(netWorkView);
        network = YZNetwork();
        network.getCurrentNetSpeed { (netWorkFlux) in
            let titles = ["无网络","Wifi","4G","3G","2G"];
            weakSelf.netWorkView.title = titles[Int(netWorkFlux!.netStatus.rawValue)];
            weakSelf.netWorkView.subTitle = self.stringFromBytes(received: netWorkFlux!.received);
        };
    }
    
    private func stringFromBytes(received: Float) ->String {
        let KB: Float = 1024.0;
        let MB = KB * 1024;
        let GB = MB * 1024;
        var speed = "0B/s";
        
        if received >= GB {
            speed = String(format: "%.1fG/s", received / GB);
        }else if received >= MB {
            speed = String(format: "%.1fM/s", received / MB);
        }else if received >= KB {
            speed = String(format: "%.1fKB/s", received / KB);
        }else{
            speed = String(format: "%.0fB/s", received);
        }
        return speed;
    }
    
    func extensionButtonAction(btn: ExtensionButton) {
        let url = NSURL(string: "YZFunny://" + String(btn.tag));
        self.extensionContext?.open(url as URL!, completionHandler: nil);
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .compact {
            self.preferredContentSize = CGSize(width: 0, height: 110);
        }else{
            self.preferredContentSize = CGSize(width: 0, height: 220);
        }
    }
    
    private func widgetPerformUpdate(completionHandler: ((NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
    deinit {
        timer.invalidate();
        cpu.stopMonitorCPUUsage();
        network.stopMonitorNetWork();
    }
}
