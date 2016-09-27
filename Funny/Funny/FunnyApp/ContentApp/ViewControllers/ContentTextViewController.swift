//
//  ContentTextViewController.swift
//  Funny
//
//  Created by yanzhen on 16/4/6.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class ContentTextViewController: ContentSuperViewController {

    fileprivate var dataGroup = [ContextTextGroupModel]()
    fileprivate var dataSource = [ContentTextModel]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func netRequestWithMJRefresh(_ refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.getNetURL(refresh);
        NetManager.requestData(withURLString: urlString, contentType: JSON, finished: { (responseObj) -> Void in
            let responseDic = responseObj as! Dictionary<String,AnyObject>
            let dataDict = responseDic["data"] as! Dictionary<String,AnyObject>;
            let outModel = ContextTextOutModel();
            outModel.setValuesForKeys(dataDict);
            if baseView == nil && refresh == MJRefresh.nomal {
                self.minTime = String(outModel.min_time.int32Value);
                self.maxTime = String(outModel.max_time.int32Value);
            }else if baseView != nil && refresh != MJRefresh.pull {
                self.minTime = String(outModel.min_time.int32Value);
            }else{
                self.maxTime = String(outModel.max_time.int32Value);
            }
            
            let dataArray = dataDict["data"] as! Array<AnyObject>;
            for (_, value) in dataArray.enumerated() {
                let type = value["type"] as! NSNumber;
                if type.int32Value == 5 {
                    continue;
                }
                let valueDict = value["group"] as! Dictionary<String,AnyObject>;
                let groupModel = ContextTextGroupModel();
                groupModel.setValuesForKeys(valueDict);
                let commentsArray = value["comments"] as! Array<AnyObject>;
                let textModel = ContentTextModel();
                if commentsArray.count > 0 {
                    let commentsD = commentsArray[0] as! Dictionary<String,AnyObject>;
                    textModel.setValuesForKeys(commentsD);
                }else{
                    textModel.text = NOTEXT;
                }
                if refresh == MJRefresh.pull {
                    self.dataGroup.insert(groupModel, at: 0);
                    self.dataSource.insert(textModel, at: 0);
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
    
    fileprivate func getNetURL(_ refresh: MJRefresh) -> String {
        if refresh == MJRefresh.nomal {
            return ContextTextHeaderURL + FunnyManager.manager.currentTime() + ContextTextTailUrl;
        }else if refresh == MJRefresh.pull {
            return ContextTextHeaderURL + self.maxTime! + ContextTextTailUrl;
        }else {
            return ConTentTextFooterURL + minTime! + ConTentTextTailerURL;
        }
    }
    
    //MARK: - tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ContentTextCell") as?ContentTextTableViewCell;
        if cell == nil {
            cell = ContentTextTableViewCell(style:.default, reuseIdentifier:"ContentTextCell");
        }
        cell?.groupModel = self.dataGroup[indexPath.row];
        let textModel = self.dataSource[indexPath.row] as ContentTextModel;
        if textModel.text == NOTEXT {
            cell?.smallView.isHidden = true;
        }else{
            cell?.smallView.isHidden = false;
            cell?.textModel = textModel;
        }
        rowHeightData[indexPath] = cell?.rowHeight;
        return cell!;
    }
    
    override
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.dataGroup[indexPath.row];
        let vc = ContentWebViewController(urlStr: model.share_url);
        vc.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(vc, animated: true);
    }
}
