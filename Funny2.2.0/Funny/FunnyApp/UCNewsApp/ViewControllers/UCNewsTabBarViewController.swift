//
//  UCNewsTabBarViewController.swift
//  Funny
//
//  Created by yanzhen on 16/4/7.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class UCNewsTabBarViewController: ExtentTabBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let block: (UCNewsSuperViewController,[String]) -> ExtentNavigationViewController = { vc, array in
            vc.UCNewsHeadURL = array[2];
            vc.UCNewsMiddleURL = array[3];
            vc.UCNewsFootURL = array[4];
            let nvc = ExtentNavigationViewController(rootViewController: vc);
            vc.title = array[0];
            let selectedImageName = array[1] + "_s";
            let unSelectedImageName = array[1] + "_u";
            let unSelectedImage = UIImage(named: unSelectedImageName)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
            let selectedImage = UIImage(named: selectedImageName)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
            nvc.tabBarItem.image = unSelectedImage;
            nvc.tabBarItem.selectedImage = selectedImage;
            return nvc;
        };
        
        let nvc1 = block(UCNewsSuperViewController(),["推荐","weibo_home",UCNewsRecommendHeadURL,UCNewsRecommendMiddleURL,UCNewsRecommendFootURL]);
        let nvc2 = block(UCNewsSuperViewController(),["NBA","weibo_compose",UCNewsNBAHeadURL,UCNewsNBAMiddleURL,UCNewsNBAFootURL]);
        let nvc3 = block(UCNewsSuperViewController(),["娱乐","weibo_music",UCNewsPlayHeadURL,UCNewsPlayMiddleURL,UCNewsPlayFootURL]);
        let nvc4 = block(UCNewsSuperViewController(),["社会","weibo_message",UCNewsSocialHeadURL,UCNewsSocialMiddleURL,UCNewsSocialFootURL]);
        let nvc5 = block(UCNewsSuperViewController(),["搞笑","weibo_favorite",UCNewsFunnyHeadURL,UCNewsFunnyMiddleURL,UCNewsFunnyFootURL]);
        self.viewControllers=[nvc1,nvc2,nvc3,nvc4,nvc5];
    }
}
