//
//  NetEaseWebViewController.swift
//  Funny
//
//  Created by yanzhen on 16/6/28.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class NetEaseWebViewController: SuperWebViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delayTime = 1.0;
    }
    
    override func jsString() ->String {
        var js = "var yzTopbar = document.getElementsByClassName('topbar')[0];" + "yzTopbar.parentNode.removeChild(yzTopbar);";
        js = js + "var box = document.getElementsByClassName('a_adtemp a_topad js-topad')[0];" + "box.parentNode.removeChild(box);";
        js = js + "var buyNow = document.getElementsByClassName('more_client more-client')[0];" + "buyNow.parentNode.removeChild(buyNow);";
        js = js + "var yzTB = document.getElementsByClassName('a_adtemp a_tbad js-tbad')[0];" + "yzTB.parentNode.removeChild(yzTB);";
        return js;
    }
}
