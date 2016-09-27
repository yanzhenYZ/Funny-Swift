//
//  WhatSomePicturesViewController.swift
//  Funny
//
//  Created by yanzhen on 15/12/28.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class WhatSomePicturesViewController: GifShowSuperViewController {

    fileprivate var maxTime: String?
    fileprivate var dataSource = [SomeWhatPictureModel]()
    fileprivate var rowHeightData: Dictionary<IndexPath,CGFloat> = [:]
    override func viewDidLoad() {
        maxTime = FunnyManager.manager.currentTime();
        super.viewDidLoad()

    }

    override func netRequestWithMJRefresh(_ refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.netURL(refresh);
        NetManager.requestData(withURLString: urlString, contentType: JSON, finished: { (responseObj) -> Void in
            let responseDic = responseObj as! Dictionary<String,AnyObject>
            let dataDict = responseDic["data"] as! Dictionary<String,AnyObject>;
            if refresh != MJRefresh.pull {
                let time = dataDict["max_time"] as! NSNumber;
                self.maxTime = String(time.int32Value);
            }
            let dataArray = dataDict["data"] as! Array<AnyObject>;
            for (_,value) in dataArray.enumerated() {
                let valueDict = value as! Dictionary<String,AnyObject>;
                let groupDict=valueDict["group"] as! Dictionary<String,AnyObject>;
                let type = groupDict["type"] as! NSNumber;
                if type.int32Value != 1 {
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
                if refresh == MJRefresh.pull {
                    self.dataSource.insert(model, at: 0);
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
    
    fileprivate func netURL(_ refresh: MJRefresh) ->String {
        if refresh == MJRefresh.nomal {
            return SomeWhatDefaultPictureURL;
        }else if refresh == MJRefresh.pull {
            return SomeWhatPullHeadURL + FunnyManager.manager.currentTime()  + SomeWhatDefaultFootURL;
        }else {
            return SomeWhatPushHeadURL + self.maxTime! + SomeWhatDefaultFootURL;
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "SomeWhatPictureCell") as? SomeWhatPictureTableViewCell;
        if cell == nil {
            cell = SomeWhatPictureTableViewCell(style:.default, reuseIdentifier:"SomeWhatPictureCell");
        }
        cell?.model = self.dataSource[indexPath.row];
        rowHeightData[indexPath] = cell?.rowHeight;
        return cell!;
    }

    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        if rowHeightData[indexPath] != nil {
            return rowHeightData[indexPath]!;
        }
        return 0;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
 
