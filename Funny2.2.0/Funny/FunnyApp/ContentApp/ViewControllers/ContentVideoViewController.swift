//
//  ContentVideoViewController.swift
//  Funny
//
//  Created by yanzhen on 16/4/6.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class ContentVideoViewController: ContentSuperViewController,VideoPlayBtnActionDelegate {

    fileprivate var cell: ContentVideoTableViewCell?
    fileprivate var groupArray = [ContentVideoCommentsModel]()
    fileprivate var dataSource = [ContentVideoModel]()
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
        
        // Do any additional setup after loading the view.
    }
    
//MARK: - playVideo
    func playVideoStart(_ button: UIButton) {
        currentCell = button.superview?.superview as? ContentVideoTableViewCell;
        let indexPath = tableView.indexPath(for: currentCell!);
        let currentM = dataSource[(indexPath! as NSIndexPath).row];
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
        let currentM = dataSource[(indexPath! as NSIndexPath).row];
        FunnyVideoManage.shareVideoManage.tableViewReload();
        WindowViewManager.shareWindowVideoManage.videoPlayWithVideoUrlString(currentM.url);
    }
    
    override func netRequestWithMJRefresh(_ refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.getNetURL(refresh);
        NetManager.requestData(withURLString: urlString, contentType: JSON, finished: { (responseObj) -> Void in
            let responseDic = responseObj as! Dictionary<String,AnyObject>
            let dataDict = responseDic["data"] as! Dictionary<String,AnyObject>;
            let dataModel = ContentVideoDataModel();
            dataModel.setValuesForKeys(dataDict);
            if (baseView == nil && MJRefresh.nomal == refresh) {
                self.minTime = String(dataModel.min_time.int32Value);
                self.maxTime = String(dataModel.max_time.int32Value);
            }else if (baseView != nil && refresh != MJRefresh.pull){
                self.minTime = String(dataModel.min_time.int32Value);
            }else{
                self.maxTime = String(dataModel.max_time.int32Value);
            }
            
            let dataArray = dataDict["data"] as! Array<AnyObject>;
            for (_, value) in dataArray.enumerated() {
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
                let o: AnyObject? = groupDict["mp4_url"];
                if o == nil {
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
                    self.groupArray.insert(commentsModel, at: 0);
                    self.dataSource.insert(groupModel, at: 0);
                }else{
                    self.groupArray.append(commentsModel);
                    self.dataSource.append(groupModel);
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
            return ConTentVideoMaxHeadURL + FunnyManager.manager.currentTime() + ContentVideoMaxFootURL;
        }else if refresh == MJRefresh.pull {
            return ConTentVideoMaxHeadURL + self.maxTime! + ContentVideoMaxFootURL;
        }else {
            return ContentVideoMinHeadURL + minTime! + ContentVideoMinFootURL;
        }
    }
    //MARK: - tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.VideoCell(tableView, indexPath: indexPath);
    }
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        let videoCell = self.VideoCell(tableView, indexPath: indexPath);
        return videoCell.rowHeight;
    }
    
    func VideoCell(_ tableView: UITableView, indexPath: IndexPath) ->ContentVideoTableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "ContentRecommentCell") as?ContentVideoTableViewCell;
        if cell == nil {
            cell = ContentVideoTableViewCell(style:.default, reuseIdentifier:"ContentRecommentCell");
            cell!.delegate = self;
        }
        cell!.groupModel = dataSource[(indexPath as NSIndexPath).row];
        let commentModel = groupArray[(indexPath as NSIndexPath).row];
        if commentModel.text == NOTEXT {
            cell!.smallView.isHidden = true;
        }else{
            cell!.smallView.isHidden = false;
            cell!.commentModel = commentModel;
        }
        if cell!.refresh(){
            FunnyVideoManage.shareVideoManage.tableViewReload();
            cell?.playButton.isSelected = false;
        }
        return cell!;
    }
    
    override
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource[(indexPath as NSIndexPath).row];
        let vc = ContentWebViewController(urlStr: model.share_url);
        vc.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(vc, animated: true);
    }


}
