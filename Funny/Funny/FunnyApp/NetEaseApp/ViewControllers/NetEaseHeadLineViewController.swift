//
//  NetEaseHeadLineViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/4.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class NetEaseHeadLineViewController: NetEaseSuperViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        page = 7;
    }

    override func netRequestWithMJRefresh(_ refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.NetURL(refresh);
        NetManager.requestData(withURLString: urlString, contentType: JSON, finished: { (responseObj) -> Void in
            let responseDic = responseObj as! Dictionary<String,AnyObject>
            let keyArray = responseDic[self.key] as! Array<AnyObject>;
            for (_,value) in keyArray.enumerated() {
                let valueDict = value as! Dictionary<String,AnyObject>;
                if valueDict["url"]  == nil {
                    continue;
                }
                if valueDict["url"] as! String == "null" {
                    continue;
                }
                let model = NetEaseModel();
                model.setValuesForKeys(valueDict);
                if refresh == MJRefresh.pull {
                    if self.dataSource.count > 0 {
                        let testModel = self.dataSource[0];
                        if testModel.url == model.url {
                            break;
                        }
                        self.dataSource.insert(model, at: 0);
                    }
                }else{
                    self.dataSource.append(model);
                }
            }
            baseView?.endRefreshing();
            self.tableView.reloadData();
        }) { (error) -> Void in
            print(error);
        }
    }
}
