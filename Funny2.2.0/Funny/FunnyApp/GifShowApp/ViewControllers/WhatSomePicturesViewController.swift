//
//  WhatSomePicturesViewController.swift
//  Funny
//
//  Created by yanzhen on 15/12/28.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class WhatSomePicturesViewController: GifShowSuperViewController {

    private var maxTime: String?
    private var cell: SomeWhatPictureTableViewCell?
    private var dataSource = [SomeWhatPictureModel]()
    override func viewDidLoad() {
        maxTime = FunnyManager.manager.currentTime();
        super.viewDidLoad()

    }

    override func netRequestWithMJRefresh(refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.netURL(refresh);
        NetManager.requestDataWithURLString(urlString, contentType: JSON, finished: { (responseObj) -> Void in
            let dataDict = responseObj["data"] as! Dictionary<String,AnyObject>;
            if refresh != MJRefresh.Pull {
                let time = dataDict["max_time"] as! NSNumber;
                self.maxTime = String(time.intValue);
            }
            let dataArray = dataDict["data"] as! Array<AnyObject>;
            for (_,value) in dataArray.enumerate() {
                let valueDict = value as! Dictionary<String,AnyObject>;
                let groupDict=valueDict["group"] as! Dictionary<String,AnyObject>;
                let type = groupDict["type"] as! NSNumber;
                if type.intValue != 1 {
                    continue;
                }
                
                let model = SomeWhatPictureModel();
                let userDict = groupDict["user"] as! Dictionary<String,AnyObject>;
                let middle_imageDict = groupDict["middle_image"] as! Dictionary<String,AnyObject>;
                let url_listArray = middle_imageDict["url_list"] as! Array<AnyObject>;
                model.avatar_url = userDict["avatar_url"] as! String;
                model.name = userDict["name"] as! String;
                model.text = groupDict["text"] as! String;
                model.create_time = groupDict["create_time"] as! NSNumber;
                model.r_height = middle_imageDict["r_height"] as! NSNumber;
                model.r_width = middle_imageDict["r_width"] as! NSNumber;
                model.url=url_listArray[0]["url"] as! String;
                if refresh == MJRefresh.Pull {
                    self.dataSource.insert(model, atIndex: 0);
                } else {
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
        if refresh == MJRefresh.Nomal {
            return SomeWhatDefaultPictureURL;
        }else if refresh == MJRefresh.Pull {
            return SomeWhatPullHeadURL + FunnyManager.manager.currentTime()  + SomeWhatDefaultFootURL;
        }else {
            return SomeWhatPushHeadURL + self.maxTime! + SomeWhatDefaultFootURL;
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return self.pictureCell(tableView, indexPath: indexPath);
    }
    
    func pictureCell(tableView: UITableView,indexPath: NSIndexPath) -> SomeWhatPictureTableViewCell {
        cell = tableView.dequeueReusableCellWithIdentifier("SomeWhatPictureCell") as? SomeWhatPictureTableViewCell;
        if cell == nil {
            cell = SomeWhatPictureTableViewCell(style:.Default, reuseIdentifier:"SomeWhatPictureCell");
        }
        cell?.model = self.dataSource[indexPath.row];
        return cell!;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let pictureCell = self.pictureCell(tableView, indexPath: indexPath);
        return pictureCell.rowHeight;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
 