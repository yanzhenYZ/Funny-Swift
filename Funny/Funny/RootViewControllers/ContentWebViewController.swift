//
//  ContentWebViewController.swift
//  Funny
//
//  Created by yanzhen on 16/6/28.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class ContentWebViewController: SuperWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        delayTime = 1.5;
    }
    
    override func jsString() ->String {
        var js = "var openNow = document.getElementsByClassName('open download J-download J-app-download-link')[0];" + "var openNow1 = document.getElementsByClassName('open download J-download J-app-download-link')[1];";
        //
        js = js + "var moreComment = document.getElementsByClassName('text-desc')[0];" + "moreComment.parentNode.removeChild(moreComment);";
        js = js + "var yzMore = document.getElementsByClassName('more')[0];" + "yzMore.parentNode.removeChild(yzMore);";
        //
        js = js + "var topBar = openNow.parentNode;" + "topBar.parentNode.removeChild(topBar);";
        js = js + "var bottomBar = openNow1.parentNode;" + "buyNow.parentNode.removeChild(buyNow);";
        js = js + "var yzTB = document.getElementsByClassName('a_adtemp a_tbad js-tbad')[0];" + "bottomBar.parentNode.removeChild(bottomBar);";
        return js;
    }
}
