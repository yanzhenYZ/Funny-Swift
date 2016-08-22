//
//  WalfareGirlViewController.swift
//  Funny
//
//  Created by yanzhen on 15/12/30.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

class WalfareGirlViewController: WalfarePictureViewController{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func PictureCell(tableView: UITableView, indexPath: NSIndexPath) ->WalfareGirlTableViewCell{
        var cell = tableView.dequeueReusableCellWithIdentifier("WalfareGirlCell") as? WalfareGirlTableViewCell;
        if cell == nil {
            cell = WalfareGirlTableViewCell(style:.Default, reuseIdentifier:"WalfareGirlCell");
        }
        cell?.model = self.dataSource[indexPath.row];
        return cell!;
    }
}
