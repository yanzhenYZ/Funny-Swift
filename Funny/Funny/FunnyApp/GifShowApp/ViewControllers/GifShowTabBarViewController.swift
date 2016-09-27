//
//  GifShowTabBarViewController.swift
//  Funny
//
//  Created by yanzhen on 16/4/6.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class GifShowTabBarViewController: ExtentTabBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let nvc1 = self.ncvWithVC(GifShowViewController(), title: "快手", imageName: "weibo_home");
        let nvc2 = self.ncvWithVC(WhatSomePicturesViewController(), title: "美女", imageName: "weibo_favorite");
        self.viewControllers = [nvc1,nvc2];
    }
}
