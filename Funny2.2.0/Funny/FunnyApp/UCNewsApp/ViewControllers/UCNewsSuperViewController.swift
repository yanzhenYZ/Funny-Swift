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
        self.tableView.separatorStyle = .singleLine;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.dataSource[(indexPath as NSIndexPath).row];
        if model.thumbnails.count >= 3 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "UCThreePictureCell") as? UCNewsThreePicturesTableViewCell;
            if cell == nil {
                cell = Bundle.main.loadNibNamed("UCNewsThreePicturesTableViewCell", owner: self, options: nil)?.last as? UCNewsThreePicturesTableViewCell;
            }
            cell?.model = model;
            return cell!;
        }else if model.thumbnails.count == 1{
            var cell = tableView.dequeueReusableCell(withIdentifier: "UCPictureCell") as? UCNewsPictureTableViewCell;
            if cell == nil {
                cell = Bundle.main.loadNibNamed("UCNewsPictureTableViewCell", owner: self, options: nil)?.last as? UCNewsPictureTableViewCell;
            }
            cell?.model = model;
            return cell!;
        }else{
            return UITableViewCell();
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        let model = self.dataSource[(indexPath as NSIndexPath).row];
        if model.thumbnails.count >= 3 {
            return 128.0;
        }else if model.thumbnails.count == 1 {
            return 80.0;
        }else{
            return 0.0;
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource[(indexPath as NSIndexPath).row];
        let vc = SuperWebViewController(urlStr: model.url);
        vc.urlString = model.url;//original_url
        vc.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    
    override func netRequestWithMJRefresh(_ refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.NetURL(refresh);
        NetManager.requestData(withURLString: urlString, contentType: JSON, finished: { (responseObj) -> Void in
            let responseDic = responseObj as! Dictionary<String,AnyObject>
            let dataDict=responseDic["data"] as! Dictionary<String,AnyObject>;
            let articlesDict=dataDict["articles"] as! Dictionary<String,AnyObject>;
            for (key, _) in articlesDict {
                let modelDict=articlesDict[key] as! Dictionary<String,AnyObject>;
                let model = UCNewsModel();
                model.setValuesForKeys(modelDict);
                if refresh == MJRefresh.pull {
                    self.dataSource.insert(model, at: 0);
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
    func NetURL(_ refresh: MJRefresh) ->String {
        let time = Int(FunnyManager.manager.currentTime())! * 1000;
        if refresh == MJRefresh.nomal {
            return self.UCNewsHeadURL  + "0" + self.UCNewsMiddleURL + String(time) + self.UCNewsFootURL;
        }else{
            let m1: String! = String(time);
            let m2: String! = String(time + 35);
            return self.UCNewsHeadURL + m1 + self.UCNewsMiddleURL + m2 + self.UCNewsFootURL;
        }
    }
    
}
