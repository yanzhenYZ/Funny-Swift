//
//  AboutMyViewController.swift
//  Funny
//
//  Created by yanzhen on 15/12/22.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

private let AIS_HEIGHT: CGFloat = 300.5;
private let ABOUT_ROWHEIGHT: CGFloat = 60.0;

class AboutMyViewController: SuperTableViewController{
    
    fileprivate var dataSource = [String]()
    fileprivate var tableHeaderView: UIView?
    fileprivate var headerImageView: UIImageView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "clear"), for: .default);
        self.navigationController?.navigationBar.shadowImage = UIImage(named: "clear");
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default);
        self.navigationController?.navigationBar.shadowImage = nil;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.backgroundColor = FunnyManager.manager.color(247, G: 247, B: 247);
        self.tableView.backgroundColor = UIColor.clear;
        self.tableView.rowHeight = ABOUT_ROWHEIGHT;
        self.configUI();
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell");
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "AboutCell");
            cell!.accessoryType = UITableViewCellAccessoryType.disclosureIndicator;
            cell?.detailTextLabel?.textColor = FunnyColor;
        }
        cell?.textLabel?.text = dataSource[(indexPath as NSIndexPath).row];
        if (indexPath as NSIndexPath).row == 0 {
            cell!.accessoryType = UITableViewCellAccessoryType.none;
            cell?.detailTextLabel?.text = self.fileSize();
        }
        return cell!;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        var vc: UIViewController? = nil;
        if (indexPath as NSIndexPath).row == 0 {
            FunnyManager.manager.clearMemory();
            tableView.perform(#selector(tableView.reloadData), with: nil, afterDelay: 0.5);
            return;
        }else if (indexPath as NSIndexPath).row == 1 {
            vc = AboutManageViewController(nibName: "AboutManageViewController", bundle: nil);
        }else if (indexPath as NSIndexPath).row == 2 {
            vc = AboutSettingsViewController();
        }
        else if (indexPath as NSIndexPath).row == 3 {
            vc = AboutDeclareViewController(nibName: "AboutDeclareViewController", bundle: nil);
        }else if (indexPath as NSIndexPath).row == 4 {
            vc = AboutAboutViewController(nibName: "AboutAboutViewController", bundle: nil);
        }
        self.navigationController?.pushViewController(vc!, animated: true);
    }

    func fileSize() ->String {
        let bytes = FunnyManager.manager.fileSize(cachePath + "/default");
        let fileSize = CGFloat(bytes) / 1000 / 1000;
        return String(format: "%.2f",fileSize) + "MB";
    }
    
    func exitFunny() {
        exit(0);
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.beginScroll(scrollView.contentOffset.y);
        //self.beginScroll2(scrollView.contentOffset.y);
    }
    
//MARK: - tableView.tableHeaderView伸缩方式一
    fileprivate func TableViewHeadView() {
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: AIS_HEIGHT));
        tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: AIS_HEIGHT));
        backView.addSubview(tableHeaderView!);
        headerImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: AIS_HEIGHT));
        headerImageView!.image = UIImage(named: "Ais");
        //确定headerImageView的缩放锚点和位置
        headerImageView!.layer.anchorPoint = CGPoint(x: 0.5, y: 0);
        headerImageView?.layer.position = CGPoint(x: 0.5 * WIDTH, y: 0);
        
        tableHeaderView?.addSubview(headerImageView!);
        tableView.tableHeaderView = backView;
    }
    
    fileprivate func beginScroll(_ offsetY: CGFloat) {
        if offsetY < 0 {
            let startAngle = CGAffineTransform(scaleX: 1 - offsetY / AIS_HEIGHT, y: 1 - offsetY / AIS_HEIGHT);
            headerImageView?.transform = startAngle;
            var rect = tableHeaderView?.frame;
            rect!.origin.y = offsetY;
            tableHeaderView?.frame = rect!;
        }
    }
    
//MARK: - tableView.tableHeaderView伸缩方式二
    fileprivate func TableViewHeadView2() {
        
        tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: AIS_HEIGHT));
        headerImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: AIS_HEIGHT));
        headerImageView!.image = UIImage(named: "Ais");
        tableHeaderView?.addSubview(headerImageView!);
        tableView.tableHeaderView = tableHeaderView;
    }
    
    fileprivate func beginScroll2(_ offsetY: CGFloat) {
        if offsetY < 0 {
            let startAngle = CGAffineTransform(scaleX: 1 - offsetY / AIS_HEIGHT, y: 1 - offsetY / AIS_HEIGHT);
            headerImageView?.transform = startAngle;
            var rect = headerImageView?.frame;
            rect!.origin.y = offsetY;
            headerImageView?.frame = rect!;
        }
    }
    
//MARK: - UI
    fileprivate func configUI() {
        self.title = "我的";
        dataSource = ["清除缓存","管理员","设置","声明","关于"];
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: 50));
        footerView.backgroundColor = UIColor.clear;
        
        let footerBtn = UIButton(frame: CGRect(x: 0, y: 12, width: WIDTH, height: 52));
        footerBtn.backgroundColor = UIColor.white;
        footerBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18.0);
        footerBtn.setTitle("退出", for: UIControlState());
        footerBtn.setTitleColor(FunnyColor, for: UIControlState());
        footerBtn.addTarget(self, action: #selector(self.exitFunny), for: UIControlEvents.touchUpInside);
        footerView.addSubview(footerBtn);
        tableView.tableFooterView = footerView;
        
        self.TableViewHeadView();
        //self.TableViewHeadView2();
    }
}
