//
//  WalfareVideoViewController.swift
//  Funny
//
//  Created by yanzhen on 15/12/30.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class WalfareVideoViewController: WalfareSuperViewController,VideoPlayBtnActionDelegate {

    fileprivate var dataSource = [WalfareVideoModel]()
    fileprivate var currentCell :WalfareVideoTableViewCell? = nil;
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        if (currentCell != nil) {
            if currentCell?.playButton.isHidden == true {
                FunnyVideoManage.shareVideoManage.tableViewReload();
            }
        }
    }
    
//MARK: - playVideo
    func playVideoStart(_ button: UIButton) {
        currentCell = button.superview?.superview as? WalfareVideoTableViewCell;
        let indexPath = tableView.indexPath(for: currentCell!);
        let currentM = dataSource[(indexPath! as NSIndexPath).row];
        if WindowViewManager.shareWindowVideoManage.isWindowViewShow() {
            currentCell?.playButton.isSelected = false;
            WindowViewManager.shareWindowVideoManage.videoPlayWithVideoUrlString(currentM.vplay_url);
        }else{
            FunnyVideoManage.shareVideoManage.playVideo(currentCell!, urlString: currentM.vplay_url);
        }
        
    }
    
    func playVideoOnWindow(_ videoCell: VideoSuperTableViewCell) {
        currentCell = videoCell as? WalfareVideoTableViewCell;
        let indexPath = tableView.indexPath(for: currentCell!);
        let currentM = dataSource[(indexPath! as NSIndexPath).row];
        FunnyVideoManage.shareVideoManage.tableViewReload();
        WindowViewManager.shareWindowVideoManage.videoPlayWithVideoUrlString(currentM.vplay_url);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func netRequestWithMJRefresh(_ refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.NetURL(refresh);
        NetManager.requestData(withURLString: urlString, contentType: HTML, finished: { (responseObj) -> Void in
            let responseDic = responseObj as! Dictionary<String,AnyObject>;
            let itemsArray = responseDic["items"] as! Array<AnyObject>;
            if refresh == MJRefresh.pull && self.dataSource.count > 0 {
                let firstModel = self.dataSource[0];
                let testDict = itemsArray[0] as! Dictionary<String,AnyObject>;
                let testModel = WalfareVideoModel();
                testModel.setValuesForKeys(testDict);
                if firstModel.wbody != testModel.wbody {
                    for (_,value) in itemsArray.enumerated() {
                        let model = WalfareVideoModel();
                        let valueDict = value as! Dictionary<String,AnyObject>;
                        model.setValuesForKeys(valueDict);
                        self.dataSource.insert(model, at: 0);
                    }
                }
            }else{
                for (_,value) in itemsArray.enumerated() {
                    let model = WalfareVideoModel();
                    let valueDict = value as! Dictionary<String,AnyObject>;
                    model.setValuesForKeys(valueDict);
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
override     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "WalfareVideoCell") as? WalfareVideoTableViewCell;
    if cell == nil {
        cell = WalfareVideoTableViewCell(style:.default, reuseIdentifier:"WalfareVideoCell");
        cell!.delegate = self;
    }
    cell?.model = self.dataSource[indexPath.row];
    if cell!.refresh() {
        FunnyVideoManage.shareVideoManage.tableViewReload();
        cell!.playButton.isSelected = false;
    }
    rowHeightData[indexPath] = cell?.rowHeight;
    return cell!;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //http://ww2.sinaimg.cn/orj480/736f0c7ejw1ezdllt3w6uj20hs0a03zn.jpg
    }

    
}
