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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
//MARK: - 如果去掉storyboard启动就会崩溃
        let titles = ["内涵段子","快手","记事本","二维码"];
        let images = ["content","gifShow","note","QR"];
        
        let space: CGFloat = 10.0;
        let maximumSize = self.extensionContext?.widgetMaximumSize(for: .compact);
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

    }
    
    func extensionButtonAction(btn: ExtensionButton) {
        let url = NSURL(string: "YZFunny://" + String(btn.tag));
        self.extensionContext?.open(url as URL!, completionHandler: nil);
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .compact {
            self.preferredContentSize = CGSize(width: 0, height: 110);
        }else{
            self.preferredContentSize = CGSize(width: 0, height: 120);
        }
    }
    
    private func widgetPerformUpdate(completionHandler: ((NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.noData)
    }
}
