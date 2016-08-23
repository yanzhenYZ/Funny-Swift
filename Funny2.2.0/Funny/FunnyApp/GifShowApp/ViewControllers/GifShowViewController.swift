//
//  GifShowViewController.swift
//  Funny
//
//  Created by yanzhen on 15/12/28.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class GifShowViewController: GifShowSuperViewController,VideoPlayBtnActionDelegate {
    private var dataSource = [GifShowVideoModel]()
    private var pushIndex: Int = 0
    private var pullIndex: Int = 0
    private var refres: Int = 0;
    private var currentCell :GifShowVideoTableViewCell? = nil;
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        if (currentCell != nil) {
            if currentCell?.playButton.hidden == true {
                FunnyVideoManage.shareVideoManage.tableViewReload();
            }
        }
    }
    
    override func viewDidLoad() {
        tableView.rowHeight = (WIDTH - 100) / 3 * 4 + 77.5;
        super.viewDidLoad()
    }

//MARK: - playVideo
    func playVideoStart(button: UIButton) {
        currentCell = button.superview?.superview as? GifShowVideoTableViewCell;
        let indexPath = tableView.indexPathForCell(currentCell!);
        let currentM = dataSource[indexPath!.row];
        if WindowViewManager.shareWindowVideoManage.isWindowViewShow() {
            currentCell?.playButton.selected = false;
            WindowViewManager.shareWindowVideoManage.videoPlayWithVideoUrlString(currentM.main_mv_url);
        }else{
            FunnyVideoManage.shareVideoManage.playVideo(currentCell!, urlString: currentM.main_mv_url);
        }
        
    }
    
    func playVideoOnWindow(videoCell: VideoSuperTableViewCell) {
        currentCell = videoCell as? GifShowVideoTableViewCell;
        let indexPath = tableView.indexPathForCell(currentCell!);
        let currentM = dataSource[indexPath!.row];
        FunnyVideoManage.shareVideoManage.tableViewReload();
        WindowViewManager.shareWindowVideoManage.videoPlayWithVideoUrlString(currentM.main_mv_url);
    }

    override func netRequestWithMJRefresh(refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let request = NSMutableURLRequest(URL: NSURL(string: GifShowHeadURL)!);
        request.HTTPMethod = "POST";
        var bodyString: String? = nil;
        if refresh == MJRefresh.Pull {
            let index = pullIndex % self.downArray.count;
            bodyString = self.downArray[index];
        }else if refresh == MJRefresh.Push {
            let index = pushIndex % self.pageArray.count;
            bodyString = self.pageArray[index];
        }else{
            bodyString = GifShowTest;
        }
        self.refres = refresh.rawValue;
        let bodyData = bodyString!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false);
        request.HTTPBody = bodyData;
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
        //
        let config = NSURLSessionConfiguration.defaultSessionConfiguration();
        let urlSession = NSURLSession(configuration: config);
        let task = urlSession.dataTaskWithRequest(request) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                if data != nil {
                    self.parsingData(data!);
                    if baseView != nil {
                        baseView?.endRefreshing();
                    }
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false;
                    self.tableView.reloadData();
                }
            });
        }
        task.resume();
    }
//MARK: - tableView 
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("GifShowVideoCell") as? GifShowVideoTableViewCell;
        if cell == nil {
            cell = GifShowVideoTableViewCell(style:.Default, reuseIdentifier:"GifShowVideoCell");
            cell!.delegate = self;
        }
        cell!.model = dataSource[indexPath.row];
        if cell!.refresh() {
            FunnyVideoManage.shareVideoManage.tableViewReload();
            cell?.playButton.selected = false;
        }
        return cell!;
    }
    
    private func parsingData(data: NSData) {
        let dict = (try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as! Dictionary<String,AnyObject>;
        let feedsArray = dict["feeds"] as! Array<AnyObject>;
        for (_,value) in feedsArray.enumerate() {
            let valueDict = value as! Dictionary<String,AnyObject>;
            let model = GifShowVideoModel();
            model.setValuesForKeysWithDictionary(valueDict);
            if self.refres == MJRefresh.Pull.rawValue {
                self.dataSource.insert(model, atIndex: 0);
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
