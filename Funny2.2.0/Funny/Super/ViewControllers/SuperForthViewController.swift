//
//  SuperForthViewController.swift
//  Funny
//
//  Created by yanzhen on 16/6/23.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class SuperForthViewController: SuperThirdViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.netRequestWithMJRefresh(.nomal, baseView: nil);
        self.refresh();
    }
    
    func netRequestWithMJRefresh(_ refresh: MJRefresh, baseView: MJRefreshBaseView?){
        
    }
    
    func refresh() {
        self.header = MJRefreshHeaderView.header();
        self.footer = MJRefreshFooterView.footer();
        self.header!.scrollView = tableView;
        self.footer!.scrollView = tableView;
        
        unowned let blockSelf = self
        self.header!.beginRefreshingBlock = {(baseView) -> Void in
            blockSelf.netRequestWithMJRefresh(.pull, baseView: baseView);
        }
        self.footer!.beginRefreshingBlock = {(baseView) -> Void in
            blockSelf.netRequestWithMJRefresh(.push, baseView: baseView);
        }
    }

}
