//
//  Verson3DTouchViewController.swift
//  Funny
//
//  Created by yanzhen on 16/7/5.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class Verson3DTouchViewController: Super3DTouchViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.text = "1.3.1:增加了页面3DTouch  1.3.2:修改页面跳转方式  1.3.3:使用block删除多余文件  2.0.0:视频可以暂停，也可切后台  2.2.0:小窗口观看视频  2.2.4:Touch ID解锁  3.0.0:Xcode8 3.0.2: Widget 3.0.3 新增流量监测";
    }
    
    override var previewActionItems : [UIPreviewActionItem] {
        let item = UIPreviewAction(title: "取消", style: .default) { (action, previewViewController) in
            
        };
        return[item];
    }

}
