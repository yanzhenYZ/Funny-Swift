//
//  AboutAboutViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/21.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class AboutAboutViewController: UIViewController,UIViewControllerPreviewingDelegate {

    @IBOutlet private weak var versonLabel: UILabel!
    @IBOutlet private weak var aboutImageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default);
        self.navigationController?.navigationBar.shadowImage = nil;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "关于";
        
        aboutImageView.layer.masksToBounds = true;
        aboutImageView.layer.cornerRadius = aboutImageView.width / 2;
        
        let dict = NSBundle.mainBundle().infoDictionary;
        let verson = dict![String(kCFBundleVersionKey)] as! String;
        versonLabel.text = verson;
        self.registerForPreviewingWithDelegate(self, sourceView: self.view);
    }

    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let vc = Verson3DTouchViewController();
        return vc;
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        self.showViewController(viewControllerToCommit, sender: self);
    }
}
