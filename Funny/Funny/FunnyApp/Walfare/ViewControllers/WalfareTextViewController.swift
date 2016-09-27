//
//  WalfareTextViewController.swift
//  Funny
//
//  Created by yanzhen on 15/12/30.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class WalfareTextViewController: WalfareSuperViewController {

    fileprivate var dataSource = [WalfareTextModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func netRequestWithMJRefresh(_ refresh: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = self.NetURL(refresh);
        NetManager.requestData(withURLString: urlString, contentType: HTML, finished: { (responseObj) -> Void in
            let responseDic = responseObj as! Dictionary<String,AnyObject>
            let itemsArray = responseDic["items"] as! Array<AnyObject>;
            if refresh == MJRefresh.pull && self.dataSource.count > 0 {
                let firstModel = self.dataSource[0];
                let testDict = itemsArray[0] as! Dictionary<String,AnyObject>;
                let testModel = WalfareTextModel();
                testModel.setValuesForKeys(testDict);
                if firstModel.wbody != testModel.wbody {
                    for (_,value) in itemsArray.enumerated() {
                        let model = WalfareTextModel();
                        let valueDict = value as! Dictionary<String,AnyObject>;
                        model.setValuesForKeys(valueDict);
                        self.dataSource.insert(model, at: 0);
                    }
                }
             }else{
                for (_,value) in itemsArray.enumerated() {
                    let model = WalfareTextModel();
                    let valueDict = value as! Dictionary<String,AnyObject>;
                    model.setValuesForKeys(valueDict);
                    self.dataSource.append(model);
                }
            }
            let model=self.dataSource.last;
            self.max_timestamp = model!.update_time;
            baseView?.endRefreshing();
            self.tableView.reloadData();
        }) { (error) -> Void in
            print(error);
        }
    }
 //MARK: tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }

    override
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "WalfareTextCell") as? WalfareTextTableViewCell;
        if cell == nil {
            print(11222);
            cell = WalfareTextTableViewCell(style:.default, reuseIdentifier:"WalfareTextCell");
        }
        cell?.model = self.dataSource[indexPath.row];
        rowHeightData[indexPath] = cell?.rowHeight;
        return cell!;
        
    }
}
