//
//  BuDeJieRankViewController.swift
//  Funny
//
//  Created by yanzhen on 15/12/29.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class BuDeJieRankViewController: BuDeJieSuperViewController,VideoPlayBtnActionDelegate {

    fileprivate var dataSource = [BuDeJieVideoModel]()
    fileprivate var currentCell :BuDeJieVideoTableViewCell? = nil;
    
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
        currentCell = button.superview?.superview as? BuDeJieVideoTableViewCell;
        let indexPath = tableView.indexPath(for: currentCell!);
        let currentM = dataSource[(indexPath! as NSIndexPath).row];
        if WindowViewManager.shareWindowVideoManage.isWindowViewShow() {
            currentCell?.playButton.isSelected = false;
            WindowViewManager.shareWindowVideoManage.videoPlayWithVideoUrlString(currentM.videouri);
        }else{
            FunnyVideoManage.shareVideoManage.playVideo(currentCell!, urlString: currentM.videouri);
        }
        
    }
    
    func playVideoOnWindow(_ videoCell: VideoSuperTableViewCell) {
        currentCell = videoCell as? BuDeJieVideoTableViewCell;
        let indexPath = tableView.indexPath(for: currentCell!);
        let currentM = dataSource[(indexPath! as NSIndexPath).row];
        FunnyVideoManage.shareVideoManage.tableViewReload();
        WindowViewManager.shareWindowVideoManage.videoPlayWithVideoUrlString(currentM.videouri);
    }
    
    override func netRequestWithMJRefresh(_ refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.netURL(refresh);
        NetManager.requestData(withURLString: urlString, contentType: JSON, finished: { (responseObj) -> Void in
            let responseDic = responseObj as! Dictionary<String,AnyObject>
            let infoDict=responseDic["info"] as! Dictionary<String,AnyObject>;
            self.maxtime = infoDict["maxtime"] as? String;
            let listArray = responseDic["list"] as! Array<AnyObject>;
            for (index, value) in listArray.enumerated() {
                let valueDict = value as! Dictionary<String,AnyObject>;
                let model = BuDeJieVideoModel();
                model.setValuesForKeys(valueDict);
                if index == 0 && self.dataSource.count > 0 && refresh == MJRefresh.pull {
                    let testModel = self.dataSource[0];
                    if testModel.videouri == model.videouri {
                        break;
                    }
                }
                
                let type = valueDict["type"] as! String;
                if Int(type) != 41 {
                    continue;
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
    
    
//MARK: - tableView    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.VideoCell(tableView, indexPath: indexPath);
    }
    
    fileprivate func VideoCell(_ tableView: UITableView, indexPath: IndexPath) -> BuDeJieVideoTableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "BuDeJieRankCell") as? BuDeJieVideoTableViewCell;
        if cell == nil {
            cell = BuDeJieVideoTableViewCell(style:.default, reuseIdentifier:"BuDeJieRankCell");
            cell!.delegate = self;
        }
        cell?.model = self.dataSource[(indexPath as NSIndexPath).row];
        if cell!.refresh(){
            FunnyVideoManage.shareVideoManage.tableViewReload();
            cell!.playButton.isSelected = false;
        }
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return self.VideoCell(tableView, indexPath: indexPath).rowHeight;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    fileprivate func netURL(_ refresh: MJRefresh) ->String {
        if refresh == MJRefresh.push {
            return BuDeJieRankingPushHeadURL + self.maxtime! + BuDeJieDefaultPushFooterURL;
        }else {
            return BudeJieRankingDefaultURL;
        }
    }

}
