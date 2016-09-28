//
//  BuDeJieSuperViewController.swift
//  Funny
//
//  Created by yanzhen on 16/4/7.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class BuDeJieSuperViewController: SuperForthViewController {

    var maxid: String? = nil
    var maxtime: String? = nil
    var rowHeightData: Dictionary<IndexPath,CGFloat> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        if rowHeightData[indexPath] != nil {
            return rowHeightData[indexPath]!;
        }
        return HEIGHT;
    }
}
