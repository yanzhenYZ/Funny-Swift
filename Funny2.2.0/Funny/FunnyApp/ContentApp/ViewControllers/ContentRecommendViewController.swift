//
//  ContentRecommendViewController.swift
//  Funny
//
//  Created by yanzhen on 16/4/6.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class ContentRecommendViewController: ContentSuperViewController,VideoPlayBtnActionDelegate{
    private var cell: ContentVideoTableViewCell?
    private var commentsMArray = [ContentVideoCommentsModel]()
    private var groupMArray = [ContentVideoModel]()
    private var currentCell :ContentVideoTableViewCell? = nil;
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        if (currentCell != nil) {
            if currentCell?.playButton.hidden == true {
                FunnyVideoManage.shareVideoManage.tableViewReload();
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
//MARK: - playVideo
    func playVideoStart(button: UIButton) {
        currentCell = button.superview?.superview as? ContentVideoTableViewCell;
        let indexPath = tableView.indexPathForCell(currentCell!);
        let currentM = groupMArray[indexPath!.row];
        if WindowViewManager.shareWindowVideoManage.isWindowViewShow() {
            currentCell?.playButton.selected = false;
            WindowViewManager.shareWindowVideoManage.videoPlayWithVideoUrlString(currentM.url);
        }else{
            FunnyVideoManage.shareVideoManage.playVideo(currentCell!, urlString: currentM.url);
        }
        
    }
    
    func playVideoOnWindow(videoCell: VideoSuperTableViewCell) {
        currentCell = videoCell as? ContentVideoTableViewCell;
        let indexPath = tableView.indexPathForCell(videoCell);
        let currentM = groupMArray[indexPath!.row];
        FunnyVideoManage.shareVideoManage.tableViewReload();
        WindowViewManager.shareWindowVideoManage.videoPlayWithVideoUrlString(currentM.url);
    }
    
    override func netRequestWithMJRefresh(refresh: MJRefresh, baseView: MJRefreshBaseView?){
        let urlString = self.getNetURL(refresh);
        NetManager.requestDataWithURLString(urlString, contentType:JSON, finished: { (responseObj) -> Void in
            let dataDict = responseObj["data"] as! Dictionary<String,AnyObject>;
            let dataModel = ContentVideoDataModel();
            dataModel.setValuesForKeysWithDictionary(dataDict);
            if (baseView == nil && refresh != MJRefresh.Pull) {
                self.minTime = String(dataModel.min_time.intValue);
                self.maxTime = String(dataModel.max_time.intValue);
            }else if (baseView != nil && refresh != MJRefresh.Pull){
                self.minTime = String(dataModel.min_time.intValue);
            }else{
                self.maxTime = String(dataModel.max_time.intValue);
            }
            
            let dataArray = dataDict["data"] as! Array<AnyObject>;
            for (_, value) in dataArray.enumerate() {
                //广告过滤->
                let type = value["type"] as! NSNumber;
                if type.intValue == 5 {
                    continue;
                }
                let commentsArray = value["comments"] as! Array<AnyObject>;
                let commentsModel = ContentVideoCommentsModel();
                if commentsArray.count > 0 {
                    let commentsD = commentsArray[0] as! Dictionary<String,AnyObject>;
                    commentsModel.setValuesForKeysWithDictionary(commentsD);
                }else{
                    commentsModel.text = NOTEXT;
                }
                let groupDict = value["group"] as! Dictionary<String,AnyObject>;
                /**  避免为空  */
                let o: AnyObject? = groupDict["category_name"];
                if o == nil {
                    continue;
                }
                let category_name = groupDict["category_name"] as! String;
                if category_name != "搞笑视频" {
                    continue;
                }
                let groupModel = ContentVideoModel();
                let userDict = groupDict["user"] as! Dictionary<String,AnyObject>;
                groupModel.avatar_url = userDict["avatar_url"] as! String;
                groupModel.name=userDict["name"] as! String;
                groupModel.share_url=groupDict["share_url"] as! String;
                groupModel.text=groupDict["text"] as! String;
                groupModel.create_time=groupDict["create_time"] as! NSNumber;
                groupModel.mp4_url=groupDict["mp4_url"] as! String;
                groupModel.duration=groupDict["duration"] as! NSNumber;
                
                let large_coverDict = groupDict["large_cover"] as! Dictionary<String,AnyObject>;
                let imageListArray = large_coverDict["url_list"] as! Array<AnyObject>;
                groupModel.imageURL=imageListArray[0]["url"] as! String;
                let videoDict = groupDict["720p_video"] as! Dictionary<String,AnyObject>;
                groupModel.width=videoDict["width"] as! NSNumber;
                groupModel.height=videoDict["height"] as! NSNumber;
                let videoListArray = videoDict["url_list"] as! Array<AnyObject>;
                groupModel.url=videoListArray[0]["url"] as! String;
                
                if refresh == MJRefresh.Pull {
                    self.commentsMArray.insert(commentsModel, atIndex: 0);
                    self.groupMArray.insert(groupModel, atIndex: 0);
                }else{
                    self.commentsMArray.append(commentsModel);
                    self.groupMArray.append(groupModel);
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
            return ContentRecommendDefaultURL;
        }else if refresh == MJRefresh.Pull {
            return ContentRecommendMaxHeadURL + maxTime! + ContentRecommendMaxFootURL;
        }else {
            return ContentRecommendMinHeadURL + minTime! + ContentRecommendMinFootURL;
        }
    }
    
    //MARK: - tableView
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMArray.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return self.VideoCell(tableView, indexPath: indexPath);
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let videoCell = self.VideoCell(tableView, indexPath: indexPath);
        return videoCell.rowHeight;
    }
    
    func VideoCell(tableView: UITableView, indexPath: NSIndexPath) ->ContentVideoTableViewCell {
        cell = tableView.dequeueReusableCellWithIdentifier("ContentRecommentCell") as?ContentVideoTableViewCell;
        if cell == nil {
            cell = ContentVideoTableViewCell(style:.Default, reuseIdentifier:"ContentRecommentCell");
            cell!.delegate = self;
        }
        
        cell!.groupModel = groupMArray[indexPath.row];
        let commentModel = commentsMArray[indexPath.row];
        if commentModel.text == NOTEXT {
            cell!.smallView.hidden = true;
        }else{
            cell!.smallView.hidden = false;
            cell!.commentModel = commentModel;
        }
        if cell!.refresh() {
            FunnyVideoManage.shareVideoManage.tableViewReload();
            cell?.selected = false;
        }
        cell!.playButton.hidden = false;
        return cell!;
    }
    
    override
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = groupMArray[indexPath.row];
        let vc = ContentWebViewController(urlStr: model.share_url);
        vc.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(vc, animated: true);
    }
}
