//
//  NetEaseTabBarViewController.swift
//  Funny
//
//  Created by yanzhen on 16/4/7.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class NetEaseTabBarViewController: ExtentTabBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let block: (NetEaseSuperViewController,[String]) -> ExtentNavigationViewController = { vc, array in
            let nvc=ExtentNavigationViewController(rootViewController: vc);
            vc.title=array[0];
            vc.defaultURL = array[2];
            vc.pushURL = array[3];
            vc.key = array[4];
            let selectedImageName = array[1] + "_s";
            let unSelectedImageName = array[1] + "_u";
            let unSelectedImage = UIImage(named: unSelectedImageName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
            let selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
            nvc.tabBarItem.image = unSelectedImage;
            nvc.tabBarItem.selectedImage = selectedImage;
            return nvc;
        };
        
        let nvc1 = block(NetEaseHeadLineViewController(),["头条","weibo_home",NetEaseHeadLineDefaultURL,NetEaseHeadLinePushURL,"T1348647909107"]);
        let nvc2 = block(NetEaseSuperViewController(),["原创","weibo_compose",NetEaseOriginalDefaultURL,NetEaseOriginalPushURL,"T1370583240249"]);
        let nvc3 = block(NetEaseSuperViewController(),["娱乐","weibo_message",NetEasePlayDefaultURL,NetEasePlayPushURL,"T1348648517839"]);
        let nvc4 = block(NetEaseContentViewController(),["段子","weibo_music",NetEaseContentDefaultURL,NetEaseContentPushURL,"段子"]);
        let nvc5 = block(NetEaseSuperViewController(),["体育","weibo_favorite",NetEaseSportDefaultURL,NetEaseSportPushURL,"T1348649079062"]);
        self.viewControllers=[nvc1,nvc2,nvc3,nvc4,nvc5];

    }
}
