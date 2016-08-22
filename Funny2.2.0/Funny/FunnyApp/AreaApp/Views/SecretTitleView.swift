//
//  SecretTitleView.swift
//  Funny
//
//  Created by yanzhen on 16/1/15.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

protocol SecretTitleViewDelegate : NSObjectProtocol{
    func SecretTitleViewSelect(indexPath: NSIndexPath)
}
class SecretTitleView: UIView ,UITableViewDataSource,UITableViewDelegate{

    weak var delegate: SecretTitleViewDelegate?
    var isHidden: Bool!
    var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        isHidden = true;
        self.clipsToBounds = true;
        self.configUI();
    }

    private func configUI() {
        tableView = UITableView(frame: CGRectMake(0, 0, self.width, 132));
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = 44.0;
        self.addSubview(tableView);
    }
    
//MARK: - tableview
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secretTitleArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("SecretTitleViewCell");
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "SecretTitleViewCell");
        }
        cell!.textLabel!.text = secretTitleArray[indexPath.row];
        return cell!;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.SecretTitleViewSelect(indexPath);
        self.toggleSecretTitleView();
    }

    func toggleSecretTitleView() {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            var height: CGFloat = 0.0;
            if self.isHidden == true {
                height = 132.0;
            }
            self.frame = CGRectMake(self.x, self.y, self.width, height)
        }) { (finished) -> Void in
            self.isHidden = !self.isHidden;
        }
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
