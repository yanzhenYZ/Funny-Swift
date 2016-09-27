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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default);
        self.navigationController?.navigationBar.shadowImage = nil;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = SETTINGS_ROWHEIGHT;
        self.tableView.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 237/255.0, alpha: 1);
        self.tableView.separatorStyle = .none;
        dataSource.append(["隐私设置"]);
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = dataSource[section];
        return items.count;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "SETTINGS_CELL");
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "SETTINGS_CELL");
            cell?.accessoryType = .disclosureIndicator;
        }
        let items = dataSource[(indexPath as NSIndexPath).section];
        cell?.textLabel?.text = items[indexPath.row];
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return SETTINGS_SECTIONHEIGHTERH;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView();
        view.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 237/255.0, alpha: 1);
        return view;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        let str = [UIApplicationOpenSettingsURLString];
        let url = URL(string: str[(indexPath as NSIndexPath).section]);
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.openURL(url!);
        }
    }
}
