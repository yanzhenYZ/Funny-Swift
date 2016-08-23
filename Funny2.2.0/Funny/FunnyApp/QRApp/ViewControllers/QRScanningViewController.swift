//
//  QRScanningViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/21.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class QRScanningViewController: UIViewController {

    private var transition: YZTransition!
    @IBOutlet private weak var openURLBtn: UIButton!
    @IBOutlet private weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func startScanning(sender: UIButton) {
        self.textView.text = "";
        openURLBtn.hidden = true;
        
        let vc = QRStartScanViewController(isFromWindow: false);
        vc.scanVC = self;
        transition = YZTransition();
        transition.type = .FromTop;
        vc.modalPresentationStyle = .Custom;
        vc.transitioningDelegate = transition;
        self.navigationController?.presentViewController(vc, animated: true, completion: { 
//            self.transition.type = .FromLeft;
        });
        
    }

    @IBAction func openURL(sender: UIButton) {
        if textView.text.isEmpty {
            return;
        }
        UIApplication.sharedApplication().openURL(NSURL(string: textView.text)!);
    }
    
    func scanningDone(result: String) {
        openURLBtn.hidden = !FunnyManager.manager.isNetURL(result);
        textView.hidden = false;
        textView.text = result;
    }
    
    
}
