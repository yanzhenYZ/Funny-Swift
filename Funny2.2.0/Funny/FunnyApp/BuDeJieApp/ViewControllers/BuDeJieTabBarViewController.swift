//
//  BuDeJieTabBarViewController.swift
//  Funny
//
//  Created by yanzhen on 16/4/7.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class BuDeJieTabBarViewController: ExtentTabBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let nvc1 = self.ncvWithVC(BuDeJieTextViewController(), title: "段子", imageName: "weibo_compose");
        let nvc2 = self.ncvWithVC(BuDeJieVideoViewController(), title: "视频", imageName: "weibo_music");
        let nvc3 = self.ncvWithVC(BuDeJiePictureViewController(), title: "图片", imageName: "weibo_message");
        let nvc4 = self.ncvWithVC(BuDeJieRankViewController(), title: "排行", imageName: "weibo_favorite");
        self.viewControllers=[nvc1,nvc2,nvc3,nvc4];
    }
}
