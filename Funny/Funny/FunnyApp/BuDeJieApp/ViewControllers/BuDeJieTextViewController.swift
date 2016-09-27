//
//  BuDeJieTextViewController.swift
//  Funny
//
//  Created by yanzhen on 15/12/29.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class BuDeJieTextViewController: BuDeJieSuperViewController {

    fileprivate var dataSource = [BuDeJieTextModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func netRequestWithMJRefresh(_ refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.netURL(refresh);
        NetManager.requestData(withURLString: urlString, contentType: JSON, finished: { (responseObj) -> Void in
            let responseDic = responseObj as! Dictionary<String,AnyObject>;
            let infoDict=responseDic["info"] as! Dictionary<String,AnyObject>;
            self.maxid = infoDict["maxid"] as? String;
            let listArray = responseDic["list"] as! Array<AnyObject>;
            for (index, value) in listArray.enumerated() {
                let valueDict = value as! Dictionary<String,AnyObject>;
                let model = BuDeJieTextModel();
                model.setValuesForKeys(valueDict);
                if index == 0 && self.dataSource.count > 0 && refresh == MJRefresh.pull {
                    let testModel = self.dataSource[0];
                    if testModel.text == model.text {
                        break;
                    }
                }
            
                if refresh == MJRefresh.pull {
                    self.dataSource.insert(model, at: 0);
                }else {
                    self.dataSource.append(model);
                }
            }
            baseView?.endRefreshing();
            self.tableView.reloadData();
        }) { (error) -> Void in
            print(error);
        }
    }
    
    fileprivate func netURL(_ refresh: MJRefresh) ->String {
        if refresh == MJRefresh.push {
            return BuDeJieTextPushHeaderURL + self.maxid! + BuDeJieTextPushFooterURL;
        }else {
            return BuDeJieTextUrl;
        }
    }
    
//MARK: - tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "BuDeJieTextCell") as? BuDeJieTextTableViewCell;
        if cell == nil {
            cell = BuDeJieTextTableViewCell(style:.default, reuseIdentifier:"BuDeJieTextCell");
        }
        cell?.model = self.dataSource[indexPath.row];
        rowHeightData[indexPath] = cell?.rowHeight;
        return cell!;
    }
}
