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

        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none;
    }

    override func netRequestWithMJRefresh(_ refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.NetURL(refresh);
        NetManager.requestData(withURLString: urlString, contentType: JSON, finished: { (responseObj) -> Void in
            let responseDic = responseObj as! Dictionary<String,AnyObject>;
            let keyArray = responseDic[self.key] as! Array<AnyObject>;
            for (_,value) in keyArray.enumerated() {
                let valueDict = value as! Dictionary<String,AnyObject>;
                let model = NetEaseModel();
                model.setValuesForKeys(valueDict);
                if refresh == MJRefresh.pull {
                    if self.dataSource.count > 0 {
                        let testModel = self.dataSource[0];
                        if testModel.digest == model.digest {
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
    
//MARK: - tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
    override
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.TextCell(tableView, indexPath: indexPath);
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return self.TextCell(tableView, indexPath: indexPath).rowHeight;
    }
    
    fileprivate func TextCell(_ tableView: UITableView, indexPath: IndexPath) -> NEContentTableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "NETextCell") as? NEContentTableViewCell;
        if cell == nil {
            cell = NEContentTableViewCell(style:.default, reuseIdentifier:"NETextCell");
        }
        cell?.model = self.dataSource[(indexPath as NSIndexPath).row];
        return cell!;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
//MARK: - URL
    override func NetURL(_ refresh: MJRefresh) -> String {
        return self.defaultURL;
    }

}
