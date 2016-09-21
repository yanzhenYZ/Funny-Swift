//
//  SecretTitleView.swift
//  Funny
//
//  Created by yanzhen on 16/1/15.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

protocol SecretTitleViewDelegate : NSObjectProtocol{
    func SecretTitleViewSelect(_ indexPath: IndexPath)
}
class SecretTitleView: UIView ,UITableViewDataSource,UITableViewDelegate{

    weak var delegate: SecretTitleViewDelegate?
    var isHidden1: Bool = true;
    var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.clipsToBounds = true;
        self.configUI();
    }

    fileprivate func configUI() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.width, height: 132));
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = 44.0;
        self.addSubview(tableView);
    }
    
//MARK: - tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secretTitleArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "SecretTitleViewCell");
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "SecretTitleViewCell");
        }
        cell!.textLabel!.text = secretTitleArray[(indexPath as NSIndexPath).row];
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.SecretTitleViewSelect(indexPath);
        self.toggleSecretTitleView();
    }

    func toggleSecretTitleView() {
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            var height: CGFloat = 0.0;
            if self.isHidden1 == true {
                height = 132.0;
            }
            self.frame = CGRect(x: self.x, y: self.y, width: self.width, height: height)
        }, completion: { (finished) -> Void in
            self.isHidden1 = !self.isHidden1;
        }) 
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
