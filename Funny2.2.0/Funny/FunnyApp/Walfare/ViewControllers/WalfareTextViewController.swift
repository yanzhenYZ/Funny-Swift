//
//  WalfareTextViewController.swift
//  Funny
//
//  Created by yanzhen on 15/12/30.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class WalfareTextViewController: WalfareSuperViewController {

    var dataSource = [WalfareTextModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func netRequestWithMJRefresh(refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.NetURL(refresh);
        NetManager.requestDataWithURLString(urlString, contentType: HTML, finished: { (responseObj) -> Void in
            let itemsArray = responseObj["items"] as! Array<AnyObject>;
            if refresh == MJRefresh.Pull && self.dataSource.count > 0 {
                let firstModel = self.dataSource[0];
                let testDict = itemsArray[0] as! Dictionary<String,AnyObject>;
                let testModel = WalfareTextModel();
                testModel.setValuesForKeysWithDictionary(testDict);
                if firstModel.wbody != testModel.wbody {
                    for (_,value) in itemsArray.enumerate() {
                        let model = WalfareTextModel();
                        let valueDict = value as! Dictionary<String,AnyObject>;
                        model.setValuesForKeysWithDictionary(valueDict);
                        self.dataSource.insert(model, atIndex: 0);
                    }
                }
             }else{
                for (_,value) in itemsArray.enumerate() {
                    let model = WalfareTextModel();
                    let valueDict = value as! Dictionary<String,AnyObject>;
                    model.setValuesForKeysWithDictionary(valueDict);
                    self.dataSource.append(model);
                }
            }
            let model=self.dataSource.last;
            self.max_timestamp = model!.update_time;
            baseView?.endRefreshing();
            self.tableView.reloadData();
        }) { (error) -> Void in
            print(error);
        }
    }
 //MARK: tableView
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
override     
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return self.TextCell(tableView, indexPath: indexPath);
    }
    
    private func TextCell(tableView: UITableView, indexPath: NSIndexPath) -> WalfareTextTableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("WalfareTextCell") as? WalfareTextTableViewCell;
        if cell == nil {
            cell = WalfareTextTableViewCell(style:.Default, reuseIdentifier:"WalfareTextCell");
        }
        cell?.model = self.dataSource[indexPath.row];
        return cell!;

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.TextCell(tableView, indexPath: indexPath).rowHeight;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}
