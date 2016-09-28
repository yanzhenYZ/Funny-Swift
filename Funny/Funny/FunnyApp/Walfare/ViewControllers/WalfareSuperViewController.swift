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
    var rowHeightData: Dictionary<IndexPath,CGFloat> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell();
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        if rowHeightData[indexPath] != nil {
            return rowHeightData[indexPath]!;
        }
        return HEIGHT;
    }
    
    func NetURL(_ refresh: MJRefresh) ->String {
        if refresh == MJRefresh.push {
            return self.pushHeadURL + self.max_timestamp + WalfarePushDefaultMiddleURL + self.latest_viewed_ts + WalfareDefaultFootURL;
        }else if refresh == MJRefresh.pull {
            return self.pullHeadURL + self.latest_viewed_ts + WalfareDefaultFootURL;
        }else{
            self.latest_viewed_ts = FunnyManager.manager.currentTime();
            return self.defaultURL;
        }
    }
    
}
