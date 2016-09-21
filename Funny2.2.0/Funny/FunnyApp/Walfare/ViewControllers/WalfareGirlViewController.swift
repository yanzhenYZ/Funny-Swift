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
    
    fileprivate func PictureCell(_ tableView: UITableView, indexPath: IndexPath) ->WalfareGirlTableViewCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: "WalfareGirlCell") as? WalfareGirlTableViewCell;
        if cell == nil {
            cell = WalfareGirlTableViewCell(style:.default, reuseIdentifier:"WalfareGirlCell");
        }
        cell?.model = self.dataSource[(indexPath as NSIndexPath).row];
        return cell!;
    }
}
