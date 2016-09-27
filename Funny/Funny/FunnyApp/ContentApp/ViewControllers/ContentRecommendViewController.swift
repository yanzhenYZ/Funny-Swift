//
//  ContentRecommendViewController.swift
//  Funny
//
//  Created by yanzhen on 16/4/6.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class ContentRecommendViewController: ContentSuperViewController,VideoPlayBtnActionDelegate{
    fileprivate var commentsMArray = [ContentVideoCommentsModel]()
    fileprivate var groupMArray = [ContentVideoModel]()
    fileprivate var currentCell :ContentVideoTableViewCell? = nil;
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        if (currentCell != nil) {
            if currentCell?.playButton.isHidden == true {
                FunnyVideoManage.shareVideoManage.tableViewReload();
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
//MARK: - playVideo
    func playVideoStart(_ button: UIButton) {
        currentCell = button.superview?.superview as? ContentVideoTableViewCell;
        let indexPath = tableView.indexPath(for: currentCell!);
        let currentM = groupMArray[(indexPath! as NSIndexPath).row];
        if WindowViewManager.shareWindowVideoManage.isWindowViewShow() {
            currentCell?.playButton.isSelected = false;
            WindowViewManager.shareWindowVideoManage.videoPlayWithVideoUrlString(currentM.url);
        }else{
            FunnyVideoManage.shareVideoManage.playVideo(currentCell!, urlString: currentM.url);
        }
        
    }
    
    func playVideoOnWindow(_ videoCell: VideoSuperTableViewCell) {
        currentCell = videoCell as? ContentVideoTableViewCell;
        let indexPath = tableView.indexPath(for: videoCell);
        let currentM = groupMArray[(indexPath! as NSIndexPath).row];
        FunnyVideoManage.shareVideoManage.tableViewReload();
        WindowViewManager.shareWindowVideoManage.videoPlayWithVideoUrlString(currentM.url);
    }
    
    override func netRequestWithMJRefresh(_ refresh: MJRefresh, baseView: MJRefreshBaseView?){
        let urlString = self.getNetURL(refresh);
        NetManager.requestData(withURLString: urlString, contentType:JSON, finished: { (responseObj) -> Void in
            let responseDic = responseObj as! Dictionary<String,AnyObject>
            let dataDict = responseDic["data"] as! Dictionary<String,AnyObject>;
            let dataModel = ContentVideoDataModel();
            dataModel.setValuesForKeys(dataDict);
            if (baseView == nil && refresh != MJRefresh.pull) {
                self.minTime = String(dataModel.min_time.int32Value);
                self.maxTime = String(dataModel.max_time.int32Value);
            }else if (baseView != nil && refresh != MJRefresh.pull){
                self.minTime = String(dataModel.min_time.int32Value);
            }else{
                self.maxTime = String(dataModel.max_time.int32Value);
            }
            
            let dataArray = dataDict["data"] as! Array<AnyObject>;
            for (_, value) in dataArray.enumerated() {
                //广告过滤->
                let type = value["type"] as! NSNumber;
                if type.int32Value == 5 {
                    continue;
                }
                let commentsArray = value["comments"] as! Array<AnyObject>;
                let commentsModel = ContentVideoCommentsModel();
                if commentsArray.count > 0 {
                    let commentsD = commentsArray[0] as! Dictionary<String,AnyObject>;
                    commentsModel.setValuesForKeys(commentsD);
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
                
                if refresh == MJRefresh.pull {
                    self.commentsMArray.insert(commentsModel, at: 0);
                    self.groupMArray.insert(groupModel, at: 0);
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

    fileprivate func getNetURL(_ refresh: MJRefresh) -> String {
        if refresh == MJRefresh.nomal {
            return ContentRecommendDefaultURL;
        }else if refresh == MJRefresh.pull {
            return ContentRecommendMaxHeadURL + maxTime! + ContentRecommendMaxFootURL;
        }else {
            return ContentRecommendMinHeadURL + minTime! + ContentRecommendMinFootURL;
        }
    }
    
    //MARK: - tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMArray.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ContentRecommentCell") as? ContentVideoTableViewCell;
        if cell == nil {
            cell = ContentVideoTableViewCell(style:.default, reuseIdentifier:"ContentRecommentCell");
            cell!.delegate = self;
        }
        
        cell!.groupModel = groupMArray[indexPath.row];
        let commentModel = commentsMArray[indexPath.row];
        if commentModel.text == NOTEXT {
            cell!.smallView.isHidden = true;
        }else{
            cell!.smallView.isHidden = false;
            cell!.commentModel = commentModel;
        }
        if cell!.refresh() {
            FunnyVideoManage.shareVideoManage.tableViewReload();
            cell?.isSelected = false;
        }
        cell!.playButton.isHidden = false;
        rowHeightData[indexPath] = cell?.rowHeight;
        return cell!;
    }
    
    override
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = groupMArray[indexPath.row];
        let vc = ContentWebViewController(urlStr: model.share_url);
        vc.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(vc, animated: true);
    }
}
