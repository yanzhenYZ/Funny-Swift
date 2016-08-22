//
//  WalfareSuperViewController.swift
//  Funny
//
//  Created by yanzhen on 15/12/30.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class WalfareSuperViewController: SuperForthViewController {
    var defaultURL: String!
    var pullHeadURL: String!
    var pushHeadURL: String!
    var max_timestamp: String!
    var latest_viewed_ts: String!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell();
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    func NetURL(refresh: MJRefresh) ->String {
        if refresh == MJRefresh.Push {
            return self.pushHeadURL + self.max_timestamp + WalfarePushDefaultMiddleURL + self.latest_viewed_ts + WalfareDefaultFootURL;
        }else if refresh == MJRefresh.Pull {
            return self.pullHeadURL + self.latest_viewed_ts + WalfareDefaultFootURL;
        }else{
            self.latest_viewed_ts = FunnyManager.manager.currentTime();
            return self.defaultURL;
        }
    }
    
}
