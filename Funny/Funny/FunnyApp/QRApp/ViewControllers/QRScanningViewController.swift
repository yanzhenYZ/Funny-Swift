//
//  QRScanningViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/21.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class QRScanningViewController: UIViewController {

    fileprivate var transition: YZTransition!
    @IBOutlet fileprivate weak var openURLBtn: UIButton!
    @IBOutlet fileprivate weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func startScanning(_ sender: UIButton) {
        self.textView.text = "";
        openURLBtn.isHidden = true;
        
        let vc = QRStartScanViewController(isFromWindow: false);
        vc.scanVC = self;
        transition = YZTransition();
        transition.type = .fromTop;
        vc.modalPresentationStyle = .custom;
        vc.transitioningDelegate = transition;
        self.navigationController?.present(vc, animated: true, completion: { 
//            self.transition.type = .FromLeft;
        });
        
    }

    @IBAction func openURL(_ sender: UIButton) {
        if textView.text.isEmpty {
            return;
        }
        UIApplication.shared.open(URL(string: textView.text)!, options: [:], completionHandler: nil);
    }
    
    func scanningDone(_ result: String) {
        openURLBtn.isHidden = !FunnyManager.manager.isNetURL(result);
        textView.isHidden = false;
        textView.text = result;
    }
    
    
}
