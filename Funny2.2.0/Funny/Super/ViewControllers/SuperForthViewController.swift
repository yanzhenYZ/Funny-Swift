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

        self.netRequestWithMJRefresh(.Nomal, baseView: nil);
        self.refresh();
    }
    
    func netRequestWithMJRefresh(refresh: MJRefresh, baseView: MJRefreshBaseView?){
        
    }
    
    func refresh() {
        self.header = MJRefreshHeaderView.header();
        self.footer = MJRefreshFooterView.footer();
        self.header!.scrollView = tableView;
        self.footer!.scrollView = tableView;
        
        unowned let blockSelf = self
        self.header!.beginRefreshingBlock = {(baseView) -> Void in
            blockSelf.netRequestWithMJRefresh(.Pull, baseView: baseView);
        }
        self.footer!.beginRefreshingBlock = {(baseView) -> Void in
            blockSelf.netRequestWithMJRefresh(.Push, baseView: baseView);
        }
    }

}
