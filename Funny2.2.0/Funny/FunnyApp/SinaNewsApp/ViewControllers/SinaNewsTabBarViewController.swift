//
//  SinaNewsTabBarViewController.swift
//  Funny
//
//  Created by yanzhen on 16/4/7.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class SinaNewsTabBarViewController: ExtentTabBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let block: (SinaNewsSuperViewController,[String]) -> ExtentNavigationViewController = { vc, array in
            let nvc = ExtentNavigationViewController(rootViewController: vc);
            vc.title = array[0];
            vc.titleName = array[2];
            let selectedImageName = array[1] + "_s";
            let unSelectedImageName = array[1] + "_u";
            let unSelectedImage = UIImage(named: unSelectedImageName)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
            let selectedImage = UIImage(named: selectedImageName)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
            nvc.tabBarItem.image = unSelectedImage;
            nvc.tabBarItem.selectedImage = selectedImage;
            return nvc;
        };

        let nvc1 = block(SinaNewsSuperViewController(),["头条","weibo_home","toutiao"]);
        let nvc2 = block(SinaRecommendViewController(),["推荐","weibo_compose","tuijian"]);
        let nvc3 = block(SinaNewsSuperViewController(),["娱乐","weibo_music","ent"]);
        let nvc4 = block(SinaNewsSuperViewController(),["搞笑","weibo_favorite","funny"]);
        self.viewControllers=[nvc1,nvc2,nvc3,nvc4];
    }
}
