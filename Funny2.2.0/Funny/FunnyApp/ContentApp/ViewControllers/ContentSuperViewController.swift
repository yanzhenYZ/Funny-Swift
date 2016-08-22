//
//  ContentSuperViewController.swift
//  Funny
//
//  Created by yanzhen on 16/4/6.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class ContentSuperViewController: SuperForthViewController {

    var maxTime: String?
    var minTime: String?
    
    override func viewDidLoad() {
        self.maxTime = FunnyManager.manager.currentTime();
        self.minTime = FunnyManager.manager.currentTime();
        super.viewDidLoad()

    }
    
    
}
