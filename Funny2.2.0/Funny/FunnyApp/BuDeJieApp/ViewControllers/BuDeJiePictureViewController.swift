//
//  BuDeJiePictureViewController.swift
//  Funny
//
//  Created by yanzhen on 15/12/29.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class BuDeJiePictureViewController: BuDeJieSuperViewController {

    var cell: BuDeJiePictureTableViewCell?
    var dataSource = [BuDeJiePictureModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func netRequestWithMJRefresh(refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.netURL(refresh);
        NetManager.requestDataWithURLString(urlString, contentType: JSON, finished: { (responseObj) -> Void in
            let infoDict=responseObj["info"] as! Dictionary<String,AnyObject>;
            self.maxtime = infoDict["maxtime"] as? String;
            let listArray = responseObj["list"] as! Array<AnyObject>;
            for (index, value) in listArray.enumerate() {
                let valueDict = value as! Dictionary<String,AnyObject>;
                let model = BuDeJiePictureModel();
                model.setValuesForKeysWithDictionary(valueDict);
                if index == 0 && self.dataSource.count > 0 && refresh == MJRefresh.Pull {
                    let testModel = self.dataSource[0];
                    if testModel.text == model.text {
                        break;
                    }
                }
                if refresh == MJRefresh.Pull {
                    self.dataSource.insert(model, atIndex: 0);
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
    
    private func netURL(refresh: MJRefresh) ->String {
        if refresh == MJRefresh.Push {
            return BuDeJieVideoPushHeadURL + self.maxtime! + BuDeJieDefaultPushFooterURL;
        }else {
            return BuDeJiePictureDefaultURL;
        }
    }
    
//MARK: - tableView    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return self.PictureCell(tableView, indexPath: indexPath);
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.PictureCell(tableView, indexPath: indexPath).rowHeight;
    }
    
    private func PictureCell(tableView: UITableView,indexPath: NSIndexPath) -> BuDeJiePictureTableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("BuDeJiePictureCell") as? BuDeJiePictureTableViewCell;
        if cell == nil {
           cell = BuDeJiePictureTableViewCell(style:.Default, reuseIdentifier:"BuDeJiePictureCell");
        }
        cell?.model = self.dataSource[indexPath.row];
        return cell!;
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    
}
