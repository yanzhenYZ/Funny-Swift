//
//  WalfareTabBarViewController.swift
//  Funny
//
//  Created by yanzhen on 16/4/7.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class WalfareTabBarViewController: ExtentTabBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let block: (WalfareSuperViewController,[String]) -> ExtentNavigationViewController = {vc,array in
            vc.defaultURL = array[2];
            vc.pullHeadURL = array[3];
            vc.pushHeadURL = array[4];
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
        let nvc1 = block(WalfareTextViewController(),["段子","weibo_compose",WalfareTextDefaultURL,WalfareTextPullHeadURL,WalfareTextPushHeadURL]);
        let nvc2 = block(WalfareVideoViewController(),["视频","weibo_music",WalfareVideoDefaultURL,WalfareVideoPullHeadURL,WalfareVideoPushHeadURL]);
        let nvc3 = block(WalfarePictureViewController(),["图片","weibo_message",WalfarePictureDefaultURL,WalfarePicturePullHeadURL,WalfarePicturePushHeadURL]);
        let nvc4 = block(WalfareGirlViewController(),["美女","weibo_favorite",WalfareGirlDefaultURL,WalfareGirlPullHeadURL,WalfareGirlPushHeadURL]);
        self.viewControllers=[nvc1,nvc2,nvc3,nvc4];
    }
}
