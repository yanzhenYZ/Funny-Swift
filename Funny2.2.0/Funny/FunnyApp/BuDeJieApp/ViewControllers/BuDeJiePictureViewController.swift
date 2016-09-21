//
//  BuDeJiePictureViewController.swift
//  Funny
//
//  Created by yanzhen on 15/12/29.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class BuDeJiePictureViewController: BuDeJieSuperViewController {

    fileprivate var cell: BuDeJiePictureTableViewCell?
    fileprivate var dataSource = [BuDeJiePictureModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func netRequestWithMJRefresh(_ refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.netURL(refresh);
        NetManager.requestData(withURLString: urlString, contentType: JSON, finished: { (responseObj) -> Void in
            let responseDic = responseObj as! Dictionary<String,AnyObject>;
            let infoDict=responseDic["info"] as! Dictionary<String,AnyObject>;
            self.maxtime = infoDict["maxtime"] as? String;
            let listArray = responseDic["list"] as! Array<AnyObject>;
            for (index, value) in listArray.enumerated() {
                let valueDict = value as! Dictionary<String,AnyObject>;
                let model = BuDeJiePictureModel();
                model.setValuesForKeys(valueDict);
                if index == 0 && self.dataSource.count > 0 && refresh == MJRefresh.pull {
                    let testModel = self.dataSource[0];
                    if testModel.text == model.text {
                        break;
                    }
                }
                if refresh == MJRefresh.pull {
                    self.dataSource.insert(model, at: 0);
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
    
    fileprivate func netURL(_ refresh: MJRefresh) ->String {
        if refresh == MJRefresh.push {
            return BuDeJieVideoPushHeadURL + self.maxtime! + BuDeJieDefaultPushFooterURL;
        }else {
            return BuDeJiePictureDefaultURL;
        }
    }
    
//MARK: - tableView    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.PictureCell(tableView, indexPath: indexPath);
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return self.PictureCell(tableView, indexPath: indexPath).rowHeight;
    }
    
    fileprivate func PictureCell(_ tableView: UITableView,indexPath: IndexPath) -> BuDeJiePictureTableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "BuDeJiePictureCell") as? BuDeJiePictureTableViewCell;
        if cell == nil {
           cell = BuDeJiePictureTableViewCell(style:.default, reuseIdentifier:"BuDeJiePictureCell");
        }
        cell?.model = self.dataSource[(indexPath as NSIndexPath).row];
        return cell!;
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    
}
