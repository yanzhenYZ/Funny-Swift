//
//  ContentPictureViewController.swift
//  Funny
//
//  Created by yanzhen on 16/4/6.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class ContentPictureViewController: ContentSuperViewController {

    private var cell: ContentPictureTableViewCell?
    private var commentsArray = [ContentPictureCommentModel]()
    private var dataSource = [ContentPictureGroupModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func netRequestWithMJRefresh(refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.getNetURL(refresh);
        NetManager.requestDataWithURLString(urlString, contentType: JSON, finished: { (responseObj) -> Void in
            let dataDict = responseObj["data"] as! Dictionary<String,AnyObject>;
            let outModel = ContentPictureDataModel();
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
                
                let commentsArray = value["comments"] as! Array<AnyObject>;
                let commentModel = ContentPictureCommentModel();
                if commentsArray.count > 0 {
                    let commentsD = commentsArray[0] as! Dictionary<String,AnyObject>;
                    commentModel.setValuesForKeysWithDictionary(commentsD);
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
                
                if refresh == MJRefresh.Pull {
                    self.dataSource.insert(groupModel, atIndex: 0);
                    self.commentsArray.insert(commentModel, atIndex: 0);
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
    
    private func getNetURL(refresh: MJRefresh) -> String {
        if refresh == MJRefresh.Nomal {
            return ContentPictureMaxHeadURL + FunnyManager.manager.currentTime() + ContentPictureMaxTailURL;
        }else if refresh == MJRefresh.Pull {
            return ContentPictureMaxHeadURL + self.maxTime! + ContentPictureMaxTailURL;
        }else {
            return ContentPictureMinHeadURL + minTime! + ContentPictureMinTailURL;
        }
    }
    
    //MARK: - tableView
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return self.PictureCell(tableView, indexPath: indexPath);
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let commentCell = self.PictureCell(tableView, indexPath: indexPath);
        return commentCell.rowHeight;
    }
    
    private func PictureCell(tableView: UITableView,indexPath: NSIndexPath) ->ContentPictureTableViewCell {
        cell = tableView.dequeueReusableCellWithIdentifier("ContentPictureCell") as?ContentPictureTableViewCell;
        if cell == nil {
            cell = ContentPictureTableViewCell(style:.Default, reuseIdentifier:"ContentPictureCell");
        }
        cell?.groupModel = self.dataSource[indexPath.row];
        let commentModel = self.commentsArray[indexPath.row];
        if commentModel.text == NOTEXT {
            cell?.smallView.hidden = true;
        }else{
            cell?.smallView.hidden = false;
            cell?.commentModel = commentModel;
        }
        return cell!;
    }
    
    override
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = self.dataSource[indexPath.row];
        let vc = ContentWebViewController(urlStr: model.share_url);
        vc.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(vc, animated: true);
    }
}
