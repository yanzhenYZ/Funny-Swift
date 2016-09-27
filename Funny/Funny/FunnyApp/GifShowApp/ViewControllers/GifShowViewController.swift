//
//  GifShowViewController.swift
//  Funny
//
//  Created by yanzhen on 15/12/28.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class GifShowViewController: GifShowSuperViewController,VideoPlayBtnActionDelegate {
    fileprivate var dataSource = [GifShowVideoModel]()
    fileprivate var pushIndex: Int = 0
    fileprivate var pullIndex: Int = 0
    fileprivate var refres: Int = 0;
    fileprivate var currentCell :GifShowVideoTableViewCell? = nil;
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        if (currentCell != nil) {
            if currentCell?.playButton.isHidden == true {
                FunnyVideoManage.shareVideoManage.tableViewReload();
            }
        }
    }
    
    override func viewDidLoad() {
        tableView.rowHeight = (WIDTH - 100) / 3 * 4 + 77.5;
        super.viewDidLoad()
    }

//MARK: - playVideo
    func playVideoStart(_ button: UIButton) {
        currentCell = button.superview?.superview as? GifShowVideoTableViewCell;
        let indexPath = tableView.indexPath(for: currentCell!);
        let currentM = dataSource[(indexPath! as NSIndexPath).row];
        if WindowViewManager.shareWindowVideoManage.isWindowViewShow() {
            currentCell?.playButton.isSelected = false;
            WindowViewManager.shareWindowVideoManage.videoPlayWithVideoUrlString(currentM.main_mv_url);
        }else{
            FunnyVideoManage.shareVideoManage.playVideo(currentCell!, urlString: currentM.main_mv_url);
        }
        
    }
    
    func playVideoOnWindow(_ videoCell: VideoSuperTableViewCell) {
        currentCell = videoCell as? GifShowVideoTableViewCell;
        let indexPath = tableView.indexPath(for: currentCell!);
        let currentM = dataSource[(indexPath! as NSIndexPath).row];
        FunnyVideoManage.shareVideoManage.tableViewReload();
        WindowViewManager.shareWindowVideoManage.videoPlayWithVideoUrlString(currentM.main_mv_url);
    }

    override func netRequestWithMJRefresh(_ refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let request = NSMutableURLRequest(url: URL(string: GifShowHeadURL)!);
        request.httpMethod = "POST";
        var bodyString: String? = nil;
        if refresh == MJRefresh.pull {
            let index = pullIndex % self.downArray.count;
            bodyString = self.downArray[index];
        }else if refresh == MJRefresh.push {
            let index = pushIndex % self.pageArray.count;
            bodyString = self.pageArray[index];
        }else{
            bodyString = GifShowTest;
        }
        self.refres = refresh.rawValue;
        let bodyData = bodyString!.data(using: String.Encoding.utf8, allowLossyConversion: false);
        request.httpBody = bodyData;
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        //
        let config = URLSessionConfiguration.default;
        let urlSession = URLSession(configuration: config);
        let task = urlSession.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            DispatchQueue.main.async(execute: {
                if data != nil {
                    self.parsingData(data!);
                    if baseView != nil {
                        baseView?.endRefreshing();
                    }
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                    self.tableView.reloadData();
                }
            });

        });
        task.resume();
    }
//MARK: - tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "GifShowVideoCell") as? GifShowVideoTableViewCell;
        if cell == nil {
            cell = GifShowVideoTableViewCell(style:.default, reuseIdentifier:"GifShowVideoCell");
            cell!.delegate = self;
        }
        cell!.model = dataSource[indexPath.row];
        if cell!.refresh() {
            FunnyVideoManage.shareVideoManage.tableViewReload();
            cell?.playButton.isSelected = false;
        }
        return cell!;
    }
    
    fileprivate func parsingData(_ data: Data) {
        let dict = (try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)) as! Dictionary<String,AnyObject>;
        let feedsArray = dict["feeds"] as! Array<AnyObject>;
        for (_,value) in feedsArray.enumerated() {
            let valueDict = value as! Dictionary<String,AnyObject>;
            let model = GifShowVideoModel();
            model.setValuesForKeys(valueDict);
            if self.refres == MJRefresh.pull.rawValue {
                self.dataSource.insert(model, at: 0);
            }else{
                self.dataSource.append(model);
            }
        }
    }
    
//MARK: - lazy
    lazy var pageArray: [String] = {
        let array = [GifShowPage1,GifShowPage2,GifShowPage3,GifShowPage4,GifShowPage5,GifShowPage6];
        return array as [String];
        }()
    lazy var downArray: [String] = {
        let array = [GifShowDown1,GifShowDown2,GifShowDown3,GifShowDown4,GifShowDown5];
        return array as [String];
        }()

}
