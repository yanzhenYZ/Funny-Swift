//
//  ContentTextViewController.swift
//  Funny
//
//  Created by yanzhen on 16/4/6.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class ContentTextViewController: ContentSuperViewController {

    var cell: ContentTextTableViewCell?
    var dataGroup = [ContextTextGroupModel]()
    var dataSource = [ContentTextModel]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func netRequestWithMJRefresh(refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.getNetURL(refresh);
        NetManager.requestDataWithURLString(urlString, contentType: JSON, finished: { (responseObj) -> Void in
            let dataDict = responseObj["data"] as! Dictionary<String,AnyObject>;
            let outModel = ContextTextOutModel();
            outModel.setValuesForKeysWithDictionary(dataDict);
            if baseView == nil && refresh == MJRefresh.Nomal {
                self.minTime = String(outModel.min_time.intValue);
                self.maxTime = String(outModel.max_time.intValue);
            }else if baseView != nil && refresh != MJRefresh.Pull {
                self.minTime = String(outModel.min_time.intValue);
            }else{
                self.maxTime = String(outModel.max_time.intValue);
            }
            
            let dataArray = dataDict["data"] as! Array<AnyObject>;
            for (_, value) in dataArray.enumerate() {
                let type = value["type"] as! NSNumber;
                if type.intValue == 5 {
                    continue;
                }
                let valueDict = value["group"] as! Dictionary<String,AnyObject>;
                let groupModel = ContextTextGroupModel();
                groupModel.setValuesForKeysWithDictionary(valueDict);
                let commentsArray = value["comments"] as! Array<AnyObject>;
                let textModel = ContentTextModel();
                if commentsArray.count > 0 {
                    let commentsD = commentsArray[0] as! Dictionary<String,AnyObject>;
                    textModel.setValuesForKeysWithDictionary(commentsD);
                }else{
                    textModel.text = NOTEXT;
                }
                if refresh == MJRefresh.Pull {
                    self.dataGroup.insert(groupModel, atIndex: 0);
                    self.dataSource.insert(textModel, atIndex: 0);
                }else{
                    self.dataGroup.append(groupModel);
                    self.dataSource.append(textModel);
                }
            }
            baseView?.endRefreshing();
            self.tableView.reloadData();
        }) { (error) -> Void in
            
        }
    }
    
    private func getNetURL(refresh: MJRefresh) -> String {
        if refresh == MJRefresh.Nomal {
            return ContextTextHeaderURL + FunnyManager.manager.currentTime() + ContextTextTailUrl;
        }else if refresh == MJRefresh.Pull {
            return ContextTextHeaderURL + self.maxTime! + ContextTextTailUrl;
        }else {
            return ConTentTextFooterURL + minTime! + ConTentTextTailerURL;
        }
    }
    
    //MARK: - tableView
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return self.TextCell(tableView, indexPath: indexPath);
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let textCell = self.TextCell(tableView, indexPath: indexPath);
        return textCell.rowHeight;
    }
    
    func TextCell(tableView: UITableView,indexPath: NSIndexPath) ->ContentTextTableViewCell {
        cell = tableView.dequeueReusableCellWithIdentifier("ContentTextCell") as?ContentTextTableViewCell;
        if cell == nil {
            cell = ContentTextTableViewCell(style:.Default, reuseIdentifier:"ContentTextCell");
        }
        cell?.groupModel = self.dataGroup[indexPath.row];
        let textModel = self.dataSource[indexPath.row] as ContentTextModel;
        if textModel.text == NOTEXT {
            cell?.smallView.hidden = true;
        }else{
            cell?.smallView.hidden = false;
            cell?.textModel = textModel;
        }
        return cell!;
    }
    
    override
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = self.dataGroup[indexPath.row];
        let vc = ContentWebViewController(urlStr: model.share_url);
        vc.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(vc, animated: true);
    }
}
