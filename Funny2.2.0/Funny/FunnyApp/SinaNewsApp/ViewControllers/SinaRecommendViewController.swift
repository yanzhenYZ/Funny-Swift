//
//  SinaRecommendViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/5.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class SinaRecommendViewController: SinaNewsSuperViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        page = 21;

        // Do any additional setup after loading the view.
    }

    override func NetURL(refresh: MJRefresh) -> String {
        
        if refresh == MJRefresh.Push{
            let url = SinaRecommendPushHeadURL + String(page!) + SinaNewsDefaultFootURL + self.titleName;
            page! += 20;
            return url;
        }else if refresh == MJRefresh.Pull{
            let url = SinaRecommendPullHeadURL + String(page!) + SinaNewsDefaultFootURL + self.titleName;
            page! += 6;
            return url;
        }else{
            return SinaRecommendNormalURL;
        }
    }
    
}
