//
//  WalfarePictureViewController.swift
//  Funny
//
//  Created by yanzhen on 15/12/30.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class WalfarePictureViewController: WalfareSuperViewController {

    var dataSource = [WalfarePictureModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func netRequestWithMJRefresh(refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.NetURL(refresh);
        NetManager.requestDataWithURLString(urlString, contentType: HTML, finished: { (responseObj) -> Void in
            let itemsArray = responseObj["items"] as! Array<AnyObject>;
            if refresh == MJRefresh.Pull && self.dataSource.count > 0 {
                let firstModel = self.dataSource[0];
                let testDict = itemsArray[0] as! Dictionary<String,AnyObject>;
                let testModel = WalfarePictureModel();
                testModel.setValuesForKeysWithDictionary(testDict);
                if firstModel.wbody != testModel.wbody {
                    for (_,value) in itemsArray.enumerate() {
                        let model = WalfarePictureModel();
                        let valueDict = value as! Dictionary<String,AnyObject>;
                        model.setValuesForKeysWithDictionary(valueDict);
                        self.dataSource.insert(model, atIndex: 0);
                    }
                }
            }else{
                for (_,value) in itemsArray.enumerate() {
                    let model = WalfarePictureModel();
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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
    override
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return self.PictureCell(tableView, indexPath: indexPath);
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.PictureCell(tableView, indexPath: indexPath).rowHeight;
    }
    
    private func PictureCell(tableView: UITableView, indexPath: NSIndexPath) ->WalfarePictureTableViewCell{
        var cell = tableView.dequeueReusableCellWithIdentifier("WalfarePictureCell") as? WalfarePictureTableViewCell;
        if cell == nil {
            cell = WalfarePictureTableViewCell(style:.Default, reuseIdentifier:"WalfarePictureCell");
        }
        cell?.model = self.dataSource[indexPath.row];
        return cell!;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //http://ww2.sinaimg.cn/orj480/736f0c7ejw1ezdllt3w6uj20hs0a03zn.jpg
    }

    
}
