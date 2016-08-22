//
//  BuDeJieVideoViewController.swift
//  Funny
//
//  Created by yanzhen on 15/12/29.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class BuDeJieVideoViewController: BuDeJieSuperViewController,VideoPlayBtnActionDelegate {

    var dataSource = [BuDeJieVideoModel]()
    var currentCell :BuDeJieVideoTableViewCell? = nil;
    
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

        // Do any additional setup after loading the view.
    }
    
//MARK: - playVideo
    func playVideoStart(button: UIButton) {
        currentCell = button.superview?.superview as? BuDeJieVideoTableViewCell;
        let indexPath = tableView.indexPathForCell(currentCell!);
        let currentM = dataSource[indexPath!.row];
        if WindowViewManager.shareWindowVideoManage.isWindowViewShow() {
            currentCell?.playButton.selected = false;
            WindowViewManager.shareWindowVideoManage.videoPlayWithVideoUrlString(currentM.videouri);
        }else{
            FunnyVideoManage.shareVideoManage.playVideo(currentCell!, urlString: currentM.videouri);
        }
        
    }
    
    func playVideoOnWindow(videoCell: VideoSuperTableViewCell) {
        currentCell = videoCell as? BuDeJieVideoTableViewCell;
        let indexPath = tableView.indexPathForCell(currentCell!);
        let currentM = dataSource[indexPath!.row];
        FunnyVideoManage.shareVideoManage.tableViewReload();
        WindowViewManager.shareWindowVideoManage.videoPlayWithVideoUrlString(currentM.videouri);
    }

    
    override func netRequestWithMJRefresh(refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.netURL(refresh);
        NetManager.requestDataWithURLString(urlString, contentType: JSON, finished: { (responseObj) -> Void in
            let infoDict=responseObj["info"] as! Dictionary<String,AnyObject>;
            self.maxtime = infoDict["maxtime"] as? String;
            let listArray = responseObj["list"] as! Array<AnyObject>;
            for (index, value) in listArray.enumerate() {
                let valueDict = value as! Dictionary<String,AnyObject>;
                let model = BuDeJieVideoModel();
                model.setValuesForKeysWithDictionary(valueDict);
                if index == 0 && self.dataSource.count > 0 && refresh == MJRefresh.Pull {
                    let testModel = self.dataSource[0];
                    if testModel.videouri == model.videouri {
                        break;
                    }
                }
                if refresh == MJRefresh.Pull {
                    self.dataSource.insert(model, atIndex: 0);
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
    
    private func netURL(refresh: MJRefresh) ->String {
        if refresh == MJRefresh.Push {
            return BuDeJieVideoPushHeadURL + self.maxtime! + BuDeJieDefaultPushFooterURL;
        }else {
            return BuDeJieVideoDefaultURL;
        }
}
    
//MARK: - tableView    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return self.VideoCell(tableView, indexPath: indexPath);
    }
    
    private func VideoCell(tableView: UITableView, indexPath: NSIndexPath) -> BuDeJieVideoTableViewCell {
            var cell = tableView.dequeueReusableCellWithIdentifier("BuDeJieVideoCell") as? BuDeJieVideoTableViewCell;
            if cell == nil {
                cell = BuDeJieVideoTableViewCell(style:.Default, reuseIdentifier:"BuDeJieVideoCell");
                cell!.delegate = self;
            }
            cell?.model = self.dataSource[indexPath.row];
        if cell!.refresh() {
            FunnyVideoManage.shareVideoManage.tableViewReload();
            cell?.playButton.selected = false;
        }
        return cell!;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.VideoCell(tableView, indexPath: indexPath).rowHeight;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    
}
