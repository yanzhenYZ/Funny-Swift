//
//  ContentSuperViewController.swift
//  Funny
//
//  Created by yanzhen on 16/4/6.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class ContentSuperViewController: SuperForthViewController {

    var maxTime: String?
    var minTime: String?
    var rowHeightData: Dictionary<IndexPath,CGFloat> = [:]
    override func viewDidLoad() {
        self.maxTime = FunnyManager.manager.currentTime();
        self.minTime = FunnyManager.manager.currentTime();
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        if rowHeightData[indexPath] != nil {
            return rowHeightData[indexPath]!;
        }
        return HEIGHT;
    }
}
