//
//  SuperWebViewController.swift
//  Funny
//
//  Created by yanzhen on 16/6/28.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class SuperWebViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var delayTime: TimeInterval!
    var urlString: String?
    
    init(urlStr: String){
        super.init(nibName: "SuperWebViewController", bundle: nil);
        urlString = urlStr;
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Y&Z";
        delayTime = 0.0;
        let url = URL(string: urlString!);
        let request = URLRequest(url: url!);
        webView.loadRequest(request);
    }
//MARK: - UIWebViewDelegate
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //        let str = webView.stringByEvaluatingJavaScriptFromString("document.getElementsByTagName('html')[0].outerHTML;");
        //        print(str);
        if strlen(self.jsString()) > 0 {
            webView.stringByEvaluatingJavaScript(from: self.jsString());
        }
        self.perform(#selector(self.showAnimating), with: nil, afterDelay: delayTime);
        //self.perform(#selector(self.show()), with: nil, afterDelay: delayTime);
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.showAnimating();
    }
    
    func jsString() ->String{
        return "";
    }
    
    func showAnimating(){
        indicator.stopAnimating();
        webView.isHidden = false;
    }

}
