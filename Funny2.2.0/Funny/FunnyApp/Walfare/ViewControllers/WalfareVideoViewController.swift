//
//  WalfareVideoViewController.swift
//  Funny
//
//  Created by yanzhen on 15/12/30.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class WalfareVideoViewController: WalfareSuperViewController,VideoPlayBtnActionDelegate {

    private var dataSource = [WalfareVideoModel]()
    private var currentCell :WalfareVideoTableViewCell? = nil;
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        if (currentCell != nil) {
            if currentCell?.playButton.hidden == true {
                FunnyVideoManage.shareVideoManage.tableViewReload();
            }
        }
    }
    
//MARK: - playVideo
    func playVideoStart(button: UIButton) {
        currentCell = button.superview?.superview as? WalfareVideoTableViewCell;
        let indexPath = tableView.indexPathForCell(currentCell!);
        let currentM = dataSource[indexPath!.row];
        if WindowViewManager.shareWindowVideoManage.isWindowViewShow() {
            currentCell?.playButton.selected = false;
            WindowViewManager.shareWindowVideoManage.videoPlayWithVideoUrlString(currentM.vplay_url);
        }else{
            FunnyVideoManage.shareVideoManage.playVideo(currentCell!, urlString: currentM.vplay_url);
        }
        
    }
    
    func playVideoOnWindow(videoCell: VideoSuperTableViewCell) {
        currentCell = videoCell as? WalfareVideoTableViewCell;
        let indexPath = tableView.indexPathForCell(currentCell!);
        let currentM = dataSource[indexPath!.row];
        FunnyVideoManage.shareVideoManage.tableViewReload();
        WindowViewManager.shareWindowVideoManage.videoPlayWithVideoUrlString(currentM.vplay_url);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func netRequestWithMJRefresh(refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.NetURL(refresh);
        NetManager.requestDataWithURLString(urlString, contentType: HTML, finished: { (responseObj) -> Void in
            let itemsArray = responseObj["items"] as! Array<AnyObject>;
            if refresh == MJRefresh.Pull && self.dataSource.count > 0 {
                let firstModel = self.dataSource[0];
                let testDict = itemsArray[0] as! Dictionary<String,AnyObject>;
                let testModel = WalfareVideoModel();
                testModel.setValuesForKeysWithDictionary(testDict);
                if firstModel.wbody != testModel.wbody {
                    for (_,value) in itemsArray.enumerate() {
                        let model = WalfareVideoModel();
                        let valueDict = value as! Dictionary<String,AnyObject>;
                        model.setValuesForKeysWithDictionary(valueDict);
                        self.dataSource.insert(model, atIndex: 0);
                    }
                }
            }else{
                for (_,value) in itemsArray.enumerate() {
                    let model = WalfareVideoModel();
                    let valueDict = value as! Dictionary<String,AnyObject>;
                    model.setValuesForKeysWithDictionary(valueDict);
                    self.dataSource.append(model);
                }
            }
            let model=self.dataSource.last;
            self.max_timestamp = model!.update_time;
            baseView?.endRefreshing()
            self.tableView.reloadData();
            }) { (error) -> Void in
                print(error);
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
override     
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return self.VideoCell(tableView, indexPath: indexPath);
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.VideoCell(tableView, indexPath: indexPath).rowHeight;
    }
    
    private func VideoCell(tableView: UITableView, indexPath: NSIndexPath) ->WalfareVideoTableViewCell{
        var cell = tableView.dequeueReusableCellWithIdentifier("WalfareVideoCell") as? WalfareVideoTableViewCell;
        if cell == nil {
            cell = WalfareVideoTableViewCell(style:.Default, reuseIdentifier:"WalfareVideoCell");
            cell!.delegate = self;
        }
        cell?.model = self.dataSource[indexPath.row];
        if cell!.refresh() {
            FunnyVideoManage.shareVideoManage.tableViewReload();
            cell!.playButton.selected = false;
        }
        return cell!;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //http://ww2.sinaimg.cn/orj480/736f0c7ejw1ezdllt3w6uj20hs0a03zn.jpg
    }

    
}
