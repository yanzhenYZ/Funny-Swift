//
//  SinaNewsSuperViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/5.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class SinaNewsSuperViewController:  SuperForthViewController{

    var dataSource = [SinaNewsModel]()
    var titleName: String!
    var page: Int? = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .singleLine;
    }
    
    override func netRequestWithMJRefresh(_ refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.NetURL(refresh);
        NetManager.requestData(withURLString: urlString, contentType: JSON, finished: { (responseObj) -> Void in
            let responseDic=responseObj as! Dictionary<String,AnyObject>;
            let dataDict=responseDic["data"] as! Dictionary<String,AnyObject>;
            let listArray=dataDict["list"] as! Array<AnyObject>;
            for (index,value) in listArray.enumerated() {
                let model = SinaNewsModel();
                let valueDict = value as! Dictionary<String,AnyObject>;
                model.setValuesForKeys(valueDict);
                if model.kpic == nil {
                    continue;
                }
                if refresh == MJRefresh.pull {
                    if index == 0 && self.dataSource.count > 0 {
                        let testModel = self.dataSource[0];
                        if testModel.title == model.title {
                            break;
                        }
                    }
                    self.dataSource.insert(model, at: 0);
                }
                self.dataSource.append(model);
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.dataSource[(indexPath as NSIndexPath).row];
        if model.pics == nil || model.pics.count < 3 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "SinaPictureCell") as? SinaPictureTableViewCell;
            if cell == nil {
                cell = Bundle.main.loadNibNamed("SinaPictureTableViewCell", owner: self, options: nil)?.last as? SinaPictureTableViewCell;
            }
            cell?.model = model;
            return cell!;
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "SinaThreePicturesCell") as? SinaThreePicturesTableViewCell;
            if cell == nil {
                cell = Bundle.main.loadNibNamed("SinaThreePicturesTableViewCell", owner: self, options: nil)?.last as? SinaThreePicturesTableViewCell;
            }
            cell?.model = model;
            return cell!;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        let model = self.dataSource[(indexPath as NSIndexPath).row];
        if model.pics == nil || model.pics.count < 3 {
            return 85.0;
        }else{
            return 110.0;
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.dataSource[(indexPath as NSIndexPath).row];
        let vc = SuperWebViewController(urlStr: model.link);
        vc.urlString = model.link;
        vc.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(vc, animated: true);

    }
//MARK: - MJRefresh
    func NetURL(_ refresh: MJRefresh) ->String {
        if refresh == MJRefresh.push {
            page! += 1;
            return SinaNewsDefaultHeadURL + String(page!) + SinaNewsDefaultFootURL + self.titleName;
        }else{
            return SinaNewsDefaultHeadURL + "1" + SinaNewsDefaultFootURL + self.titleName;
        }
    }
}
