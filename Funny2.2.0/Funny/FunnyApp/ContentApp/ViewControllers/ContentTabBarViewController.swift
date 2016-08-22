//
//  ContentTabBarViewController.swift
//  Funny
//
//  Created by yanzhen on 16/4/6.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class ContentTabBarViewController: ExtentTabBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let nvc1 = self.ncvWithVC(ContentRecommendViewController(), title: "推荐", imageName: "weibo_home");
        let nvc2 = self.ncvWithVC(ContentTextViewController(), title: "段子", imageName: "weibo_compose");
        let nvc3 = self.ncvWithVC(ContentVideoViewController(), title: "视频", imageName: "weibo_music");
        let nvc4 = self.ncvWithVC(ContentPictureViewController(), title: "图片", imageName: "weibo_message");
        self.viewControllers=[nvc1,nvc2,nvc3,nvc4];
    }
}
