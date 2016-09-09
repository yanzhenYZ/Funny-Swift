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
    
    private var dataSource = [String]()
    private var tableHeaderView: UIView?
    private var headerImageView: UIImageView?
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated);
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "clear"), forBarMetrics: .Default);
        self.navigationController?.navigationBar.shadowImage = UIImage(named: "clear");
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default);
        self.navigationController?.navigationBar.shadowImage = nil;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.backgroundColor = FunnyManager.manager.color(247, G: 247, B: 247);
        self.tableView.backgroundColor = UIColor.clearColor();
        self.tableView.rowHeight = ABOUT_ROWHEIGHT;
        self.configUI();
        
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("AboutCell");
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: "AboutCell");
            cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator;
            cell?.detailTextLabel?.textColor = FunnyColor;
        }
        cell?.textLabel?.text = dataSource[indexPath.row];
        if indexPath.row == 0 {
            cell!.accessoryType = UITableViewCellAccessoryType.None;
            cell?.detailTextLabel?.text = self.fileSize();
        }
        return cell!;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        var vc: UIViewController? = nil;
        if indexPath.row == 0 {
            FunnyManager.manager.clearMemory();
            tableView.performSelector(#selector(tableView.reloadData), withObject: nil, afterDelay: 0.5);
            return;
        }else if indexPath.row == 1 {
            vc = AboutManageViewController(nibName: "AboutManageViewController", bundle: nil);
        }else if indexPath.row == 2 {
            vc = AboutSettingsViewController();
        }
        else if indexPath.row == 3 {
            vc = AboutDeclareViewController(nibName: "AboutDeclareViewController", bundle: nil);
        }else if indexPath.row == 4 {
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
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.beginScroll(scrollView.contentOffset.y);
        //self.beginScroll2(scrollView.contentOffset.y);
    }
    
//MARK: - tableView.tableHeaderView伸缩方式一
    private func TableViewHeadView() {
        let backView = UIView(frame: CGRectMake(0, 0, WIDTH, AIS_HEIGHT));
        tableHeaderView = UIView(frame: CGRectMake(0, 0, WIDTH, AIS_HEIGHT));
        backView.addSubview(tableHeaderView!);
        headerImageView = UIImageView(frame: CGRectMake(0, 0, WIDTH, AIS_HEIGHT));
        headerImageView!.image = UIImage(named: "Ais");
        //确定headerImageView的缩放锚点和位置
        headerImageView!.layer.anchorPoint = CGPointMake(0.5, 0);
        headerImageView?.layer.position = CGPointMake(0.5 * WIDTH, 0);
        
        tableHeaderView?.addSubview(headerImageView!);
        tableView.tableHeaderView = backView;
    }
    
    private func beginScroll(offsetY: CGFloat) {
        if offsetY < 0 {
            let startAngle = CGAffineTransformMakeScale(1 - offsetY / AIS_HEIGHT, 1 - offsetY / AIS_HEIGHT);
            headerImageView?.transform = startAngle;
            var rect = tableHeaderView?.frame;
            rect!.origin.y = offsetY;
            tableHeaderView?.frame = rect!;
        }
    }
    
//MARK: - tableView.tableHeaderView伸缩方式二
    private func TableViewHeadView2() {
        
        tableHeaderView = UIView(frame: CGRectMake(0, 0, WIDTH, AIS_HEIGHT));
        headerImageView = UIImageView(frame: CGRectMake(0, 0, WIDTH, AIS_HEIGHT));
        headerImageView!.image = UIImage(named: "Ais");
        tableHeaderView?.addSubview(headerImageView!);
        tableView.tableHeaderView = tableHeaderView;
    }
    
    private func beginScroll2(offsetY: CGFloat) {
        if offsetY < 0 {
            let startAngle = CGAffineTransformMakeScale(1 - offsetY / AIS_HEIGHT, 1 - offsetY / AIS_HEIGHT);
            headerImageView?.transform = startAngle;
            var rect = headerImageView?.frame;
            rect!.origin.y = offsetY;
            headerImageView?.frame = rect!;
        }
    }
    
//MARK: - UI
    private func configUI() {
        self.title = "我的";
        dataSource = ["清除缓存","管理员","设置","声明","关于"];
        
        let footerView = UIView(frame: CGRectMake(0, 0, WIDTH, 50));
        footerView.backgroundColor = UIColor.clearColor();
        
        let footerBtn = UIButton(frame: CGRectMake(0, 12, WIDTH, 52));
        footerBtn.backgroundColor = UIColor.whiteColor();
        footerBtn.titleLabel?.font = UIFont.systemFontOfSize(18.0);
        footerBtn.setTitle("退出", forState: UIControlState.Normal);
        footerBtn.setTitleColor(FunnyColor, forState: UIControlState.Normal);
        footerBtn.addTarget(self, action: #selector(self.exitFunny), forControlEvents: UIControlEvents.TouchUpInside);
        footerView.addSubview(footerBtn);
        tableView.tableFooterView = footerView;
        
        self.TableViewHeadView();
        //self.TableViewHeadView2();
    }
}
