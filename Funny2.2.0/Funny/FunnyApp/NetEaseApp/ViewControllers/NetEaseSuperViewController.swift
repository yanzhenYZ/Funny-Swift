//
//  NetEaseSuperViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/4.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit


class NetEaseSuperViewController: SuperForthViewController {

    var defaultURL: String!
    var pushURL: String!
    var key: String!
    var page: Int? = 1
    var dataSource = [NetEaseModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.separatorStyle = .SingleLine;
    }

    override func netRequestWithMJRefresh(refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.NetURL(refresh);
        NetManager.requestDataWithURLString(urlString, contentType: JSON, finished: { (responseObj) -> Void in
            let keyArray = responseObj[self.key] as! Array<AnyObject>;
            for (_,value) in keyArray.enumerate() {
                let valueDict = value as! Dictionary<String,AnyObject>;
                if valueDict["url"]  == nil {
                    continue;
                }
                if valueDict["url"] as! String == "null" {
                    continue;
                }
                let model = NetEaseModel();
                model.setValuesForKeysWithDictionary(valueDict);
                if refresh == MJRefresh.Pull {
                    if self.dataSource.count > 0 {
                        let testModel = self.dataSource[0];
                        if testModel.url == model.url {
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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
override     
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let model = self.dataSource[indexPath.row];
        if model.imgextra.count != 0{
            var cell = tableView.dequeueReusableCellWithIdentifier("NEThreePicturesCell") as? NEThreePicturesTableViewCell;
            if cell == nil {
                cell = NSBundle.mainBundle().loadNibNamed("NEThreePicturesTableViewCell", owner: self, options: nil).last as? NEThreePicturesTableViewCell;
            }
            cell?.model = model;
            return cell!;
        }else{
            var cell = tableView.dequeueReusableCellWithIdentifier("NEPictureCell") as? NEPictureTableViewCell;
            if cell == nil {
                cell = NSBundle.mainBundle().loadNibNamed("NEPictureTableViewCell", owner: self, options: nil).last as? NEPictureTableViewCell;
            }
            cell?.model = model;
            return cell!;
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let model = self.dataSource[indexPath.row];
        if model.imgextra.count != 0{
            return 130.0;
        }else{
            return 90.0;
        }

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = self.dataSource[indexPath.row];
        let vc = NetEaseWebViewController(urlStr: model.url_3w);
        vc.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(vc, animated: true);
        
    }
//MARK: - MJRefresh
    
    func NetURL(refresh: MJRefresh) ->String {
        if refresh == MJRefresh.Push {
            let pageCount = page! * 20;
            page! += 1;
            return self.pushURL + String(pageCount) + NetEaseDefaultFooterURL;
        }else{
            return self.defaultURL;
        }
    }
}
