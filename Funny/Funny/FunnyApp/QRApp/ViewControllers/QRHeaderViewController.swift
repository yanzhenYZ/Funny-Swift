//
//  QRHeaderViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/21.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class QRHeaderViewController: SuperSecondViewController {

    fileprivate var makeVC: QRMakeViewController!
    fileprivate var scanVC: QRScanningViewController!
    
    override func viewDidLoad() {
        self.configUI();
        super.viewDidLoad()
    }
    
    fileprivate func configUI() {
        let titleArray = ["扫描二维码","生成二维码"];
        let segment = UISegmentedControl(items: titleArray);
        segment.frame = CGRect(x: 0, y: 0, width: 150, height: 30);
        segment.selectedSegmentIndex = 0;
        segment.addTarget(self, action: #selector(self.segmentAction(_:)), for: .valueChanged);
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
    
    func segmentAction(_ segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.makeVC.view.alpha = 0;
            }, completion: { (finished) -> Void in
                self.scanVC.view.alpha = 1;
            })
        }else{
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                    self.scanVC.view.alpha = 0;
                }, completion: { (finished) -> Void in
                    self.makeVC.view.alpha = 1;
            })
        }
    }
    
}
