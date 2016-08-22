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
        self.textView.text = "1.3.1:增加了页面3DTouch  1.3.2修改页面跳转方式  1.3.3使用block删除多余文件  2.0.0视频可以暂停，也可切后台  2.2.0小窗口观看视频";
    }
    
    override func previewActionItems() -> [UIPreviewActionItem] {
        let item = UIPreviewAction(title: "取消", style: .Default) { (action, previewViewController) in
            
        };
        return[item];
    }

}
