//
//  QRHeaderViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/21.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class QRHeaderViewController: SuperSecondViewController {

    var makeVC: QRMakeViewController!
    var scanVC: QRScanningViewController!
    
    override func viewDidLoad() {
        self.configUI();
        super.viewDidLoad()
    }
    
    private func configUI() {
        let titleArray = ["扫描二维码","生成二维码"];
        let segment = UISegmentedControl(items: titleArray);
        segment.frame = CGRectMake(0, 0, 150, 30);
        segment.selectedSegmentIndex = 0;
        segment.addTarget(self, action: #selector(self.segmentAction(_:)), forControlEvents: UIControlEvents.ValueChanged);
        self.navigationItem.titleView = segment;
        
        makeVC = QRMakeViewController(nibName: "QRMakeViewController", bundle: nil);
        scanVC = QRScanningViewController(nibName: "QRScanningViewController", bundle: nil);
        self.addChildViewController(makeVC);
        self.addChildViewController(scanVC);
        makeVC.view.frame = self.view.bounds;
        scanVC.view.frame = self.view.bounds;
        self.view.addSubview(makeVC.view);
        self.view.addSubview(scanVC.view);
    }
    
    func segmentAction(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.makeVC.view.alpha = 0;
            }, completion: { (finished) -> Void in
                self.scanVC.view.alpha = 1;
            })
        }else{
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.scanVC.view.alpha = 0;
                }, completion: { (finished) -> Void in
                    self.makeVC.view.alpha = 1;
            })
        }
    }
    
}
