//
//  AboutAboutViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/21.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class AboutAboutViewController: UIViewController,UIViewControllerPreviewingDelegate {

    @IBOutlet fileprivate weak var versonLabel: UILabel!
    @IBOutlet fileprivate weak var aboutImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default);
        self.navigationController?.navigationBar.shadowImage = nil;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "关于";
        
        aboutImageView.layer.masksToBounds = true;
        aboutImageView.layer.cornerRadius = aboutImageView.width / 2;
        
        let dict = Bundle.main.infoDictionary;
        let verson = dict![String(kCFBundleVersionKey)] as! String;
        versonLabel.text = verson;
        self.registerForPreviewing(with: self, sourceView: self.view);
    }

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let vc = Verson3DTouchViewController();
        return vc;
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.show(viewControllerToCommit, sender: self);
    }
}
