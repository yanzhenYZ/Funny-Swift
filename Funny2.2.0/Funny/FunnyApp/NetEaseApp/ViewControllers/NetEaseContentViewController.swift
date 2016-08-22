//
//  NetEaseContentViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/4.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class NetEaseContentViewController: NetEaseSuperViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
    }

    override func netRequestWithMJRefresh(refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.NetURL(refresh);
        NetManager.requestDataWithURLString(urlString, contentType: JSON, finished: { (responseObj) -> Void in
            let keyArray = responseObj[self.key] as! Array<AnyObject>;
            for (_,value) in keyArray.enumerate() {
                let valueDict = value as! Dictionary<String,AnyObject>;
                let model = NetEaseModel();
                model.setValuesForKeysWithDictionary(valueDict);
                if refresh == MJRefresh.Pull {
                    if self.dataSource.count > 0 {
                        let testModel = self.dataSource[0];
                        if testModel.digest == model.digest {
                            break;
                        }
                        self.dataSource.insert(model, atIndex: 0);
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
    
//MARK: - tableView
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
    override
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return self.TextCell(tableView, indexPath: indexPath);
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.TextCell(tableView, indexPath: indexPath).rowHeight;
    }
    
    private func TextCell(tableView: UITableView, indexPath: NSIndexPath) -> NEContentTableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("NETextCell") as? NEContentTableViewCell;
        if cell == nil {
            cell = NEContentTableViewCell(style:.Default, reuseIdentifier:"NETextCell");
        }
        cell?.model = self.dataSource[indexPath.row];
        return cell!;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
//MARK: - URL
    override func NetURL(refresh: MJRefresh) -> String {
        return self.defaultURL;
    }

}
