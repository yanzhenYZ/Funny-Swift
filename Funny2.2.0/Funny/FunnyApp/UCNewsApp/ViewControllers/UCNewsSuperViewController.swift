//
//  UCNewsSuperViewController.swift
//  Funny
//
//  Created by yanzhen on 16/4/7.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class UCNewsSuperViewController: SuperForthViewController {

    var dataSource = [UCNewsModel]()
    var UCNewsHeadURL: String!
    var UCNewsMiddleURL: String!
    var UCNewsFootURL: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .SingleLine;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let model = self.dataSource[indexPath.row];
        if model.thumbnails.count >= 3 {
            var cell = tableView.dequeueReusableCellWithIdentifier("UCThreePictureCell") as? UCNewsThreePicturesTableViewCell;
            if cell == nil {
                cell = NSBundle.mainBundle().loadNibNamed("UCNewsThreePicturesTableViewCell", owner: self, options: nil).last as? UCNewsThreePicturesTableViewCell;
            }
            cell?.model = model;
            return cell!;
        }else if model.thumbnails.count == 1{
            var cell = tableView.dequeueReusableCellWithIdentifier("UCPictureCell") as? UCNewsPictureTableViewCell;
            if cell == nil {
                cell = NSBundle.mainBundle().loadNibNamed("UCNewsPictureTableViewCell", owner: self, options: nil).last as? UCNewsPictureTableViewCell;
            }
            cell?.model = model;
            return cell!;
        }else{
            return UITableViewCell();
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let model = self.dataSource[indexPath.row];
        if model.thumbnails.count >= 3 {
            return 128.0;
        }else if model.thumbnails.count == 1 {
            return 80.0;
        }else{
            return 0.0;
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = dataSource[indexPath.row];
        let vc = SuperWebViewController(urlStr: model.url);
        vc.urlString = model.url;//original_url
        vc.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    
    override func netRequestWithMJRefresh(refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.NetURL(refresh);
        NetManager.requestDataWithURLString(urlString, contentType: JSON, finished: { (responseObj) -> Void in
            let dataDict=responseObj["data"] as! Dictionary<String,AnyObject>;
            let articlesDict=dataDict["articles"] as! Dictionary<String,AnyObject>;
            for (key, _) in articlesDict {
                let modelDict=articlesDict[key] as! Dictionary<String,AnyObject>;
                let model = UCNewsModel();
                model.setValuesForKeysWithDictionary(modelDict);
                if refresh == MJRefresh.Pull {
                    self.dataSource.insert(model, atIndex: 0);
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
    //MARK: - URL + MJRefresh
    func NetURL(refresh: MJRefresh) ->String {
        let time = Int(FunnyManager.manager.currentTime())! * 1000;
        if refresh == MJRefresh.Nomal {
            return self.UCNewsHeadURL  + "0" + self.UCNewsMiddleURL + String(time) + self.UCNewsFootURL;
        }else{
            return self.UCNewsHeadURL + String(time) + self.UCNewsMiddleURL + String(time + 35) + self.UCNewsFootURL;
        }
    }
    
}
