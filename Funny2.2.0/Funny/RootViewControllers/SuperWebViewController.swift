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
    var delayTime: NSTimeInterval!
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
        let url = NSURL(string: urlString!);
        let request = NSURLRequest(URL: url!);
        webView.loadRequest(request);
    }
//MARK: - UIWebViewDelegate
    func webViewDidFinishLoad(webView: UIWebView) {
        //        let str = webView.stringByEvaluatingJavaScriptFromString("document.getElementsByTagName('html')[0].outerHTML;");
        //        print(str);
        if strlen(self.jsString()) > 0 {
            webView.stringByEvaluatingJavaScriptFromString(self.jsString());
        }
        self.performSelector(#selector(self.show), withObject: nil, afterDelay: delayTime);
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        self.show();
    }
    
    func jsString() ->String{
        return "";
    }
    
    func show(){
        indicator.stopAnimating();
        webView.hidden = false;
    }

}
