//
//  AboutSettingsViewController.swift
//  Funny
//
//  Created by yanzhen on 16/9/9.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

private let SETTINGS_ROWHEIGHT: CGFloat = 50.0;
private let SETTINGS_SECTIONHEIGHTERH: CGFloat = 10.0;

class AboutSettingsViewController: SuperTableViewController {

    var dataSource = [[String]]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default);
        self.navigationController?.navigationBar.shadowImage = nil;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = SETTINGS_ROWHEIGHT;
        self.tableView.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 237/255.0, alpha: 1);
        self.tableView.separatorStyle = .None;
        dataSource.append(["隐私设置"]);
        dataSource.append(["打开WIFI"]);
        dataSource.append(["打开移动网络"]);
        print(dataSource);
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource.count;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = dataSource[section];
        return items.count;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("SETTINGS_CELL");
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "SETTINGS_CELL");
            cell?.accessoryType = .DisclosureIndicator;
        }
        print(indexPath.section);
        let items = dataSource[indexPath.section];
        cell?.textLabel?.text = items[indexPath.row];
        return cell!;
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return SETTINGS_SECTIONHEIGHTERH;
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView();
        view.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 237/255.0, alpha: 1);
        return view;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        let str = [UIApplicationOpenSettingsURLString,"prefs:root=WIFI","prefs:root=MOBILE_DATA_SETTINGS_ID"];
        print(indexPath.section);
        let url = NSURL(string: str[indexPath.section]);
        if UIApplication.sharedApplication().canOpenURL(url!) {
            UIApplication.sharedApplication().openURL(url!);
        }
    }
}
