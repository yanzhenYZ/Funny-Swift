//
//  ContentPictureViewController.swift
//  Funny
//
//  Created by yanzhen on 16/4/6.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class ContentPictureViewController: ContentSuperViewController {

    fileprivate var commentsArray = [ContentPictureCommentModel]()
    fileprivate var dataSource = [ContentPictureGroupModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func netRequestWithMJRefresh(_ refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.getNetURL(refresh);
        NetManager.requestData(withURLString: urlString, contentType: JSON, finished: { (responseObj) -> Void in
            let responseDic = responseObj as! Dictionary<String,AnyObject>
            let dataDict = responseDic["data"] as! Dictionary<String,AnyObject>;
            let outModel = ContentPictureDataModel();
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
                
                let commentsArray = value["comments"] as! Array<AnyObject>;
                let commentModel = ContentPictureCommentModel();
                if commentsArray.count > 0 {
                    let commentsD = commentsArray[0] as! Dictionary<String,AnyObject>;
                    commentModel.setValuesForKeys(commentsD);
                }else{
                    commentModel.text = NOTEXT;
                }
                
                let groupDict = value["group"] as! Dictionary<String,AnyObject>;
                let groupModel = ContentPictureGroupModel();
                groupModel.share_url=groupDict["share_url"] as! String;
                groupModel.text=groupDict["text"] as! String;
                groupModel.create_time=groupDict["create_time"] as! NSNumber;
                
                let o: AnyObject? = groupDict["large_image"];
                if o == nil {
                    continue;
                }
                let middleImageDict = groupDict["large_image"] as! Dictionary<String,AnyObject>;
                groupModel.r_width = middleImageDict["r_width"] as! NSNumber;
                groupModel.r_height = middleImageDict["r_height"] as! NSNumber;
                
                let url_listArray = middleImageDict["url_list"] as! Array<AnyObject>;
                groupModel.url=url_listArray[0]["url"] as! String;
                
                let userDict = groupDict["user"] as! Dictionary<String,AnyObject>;
                groupModel.avatar_url=userDict["avatar_url"] as! String;
                groupModel.name=userDict["name"] as! String;
                
                if refresh == MJRefresh.pull {
                    self.dataSource.insert(groupModel, at: 0);
                    self.commentsArray.insert(commentModel, at: 0);
                }else{
                    self.dataSource.append(groupModel);
                    self.commentsArray.append(commentModel);
                }
            }
            baseView?.endRefreshing();
            self.tableView.reloadData();
        }) { (error) -> Void in
            print(error);
        }
    }
    
    fileprivate func getNetURL(_ refresh: MJRefresh) -> String {
        if refresh == MJRefresh.nomal {
            return ContentPictureMaxHeadURL + FunnyManager.manager.currentTime() + ContentPictureMaxTailURL;
        }else if refresh == MJRefresh.pull {
            return ContentPictureMaxHeadURL + self.maxTime! + ContentPictureMaxTailURL;
        }else {
            return ContentPictureMinHeadURL + minTime! + ContentPictureMinTailURL;
        }
    }
    
    //MARK: - tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ContentPictureCell") as?ContentPictureTableViewCell;
        if cell == nil {
            cell = ContentPictureTableViewCell(style:.default, reuseIdentifier:"ContentPictureCell");
        }
        cell?.groupModel = self.dataSource[indexPath.row];
        let commentModel = self.commentsArray[indexPath.row];
        if commentModel.text == NOTEXT {
            cell?.smallView.isHidden = true;
        }else{
            cell?.smallView.isHidden = false;
            cell?.commentModel = commentModel;
        }
        rowHeightData[indexPath] = cell?.rowHeight;
        return cell!;
    }
    
    override
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.dataSource[indexPath.row];
        let vc = ContentWebViewController(urlStr: model.share_url);
        vc.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(vc, animated: true);
    }
}
