//
//  SuperSecondViewController.swift
//  Funny
//
//  Created by yanzhen on 16/4/6.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class SuperSecondViewController: SuperViewController,AwesomeMenuDelegate,YZActionSheetDelegate {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.hidesBottomBarWhenPushed = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configSuperSecondUI();
    }
    
    fileprivate func shotPartViewOrNot(_ rect: CGRect,shot: Bool) {
        self.shotPartView.removeFromSuperview();
        if shot {
            let image = FunnyManager.manager.ScreenShotPart(self.view, rect: rect);
            FunnyManager.manager.saveImage(image);
        }
    }

    //MARK:lazy
//    lazy var addSecondImageView: AddImageView = {
//        let addImageView=AddImageView(frame: CGRectMake(15.0, 64.0, 110.0, 0.0));
//        addImageView.delegate=self;
//        self.view.addSubview(addImageView);
//        return addImageView;
//    }()
    
    lazy var shotPartView:SuperScreenPartShotView = {
        let shotPartView=SuperScreenPartShotView(frame: CGRect(x: 0.0, y: 64.0, width: WIDTH, height: HEIGHT-64.0-49.0))
        shotPartView.initBlock{ (rect, shot) -> Void in
            let frame = CGRect(x: rect.origin.x, y: rect.origin.y
                + 64, width: rect.size.width, height: rect.size.height);
            self.shotPartViewOrNot(frame,shot: shot);
        }
        return shotPartView;
    }()

    lazy var sheet: YZActionSheet = {
        let titleItem = YZActionSheetItem(title: "退出程序", titleColor: nil, titleFont: nil);
        let item = YZActionSheetItem(title: "确定", titleColor: nil, titleFont: nil);
        let sheet = YZActionSheet(titleItem: titleItem, delegate: self, cancelItem: nil, itemsArray: [item]);
        return sheet;
    }()
    
    //MARK - UI
    override func configSuperUI() {
        
    }
    
    fileprivate func configSuperSecondUI() {
        
        let block:(String) -> AwesomeMenuItem = { imageName in
            let menuItemImage = UIImage(named: "menu_bg");
            return AwesomeMenuItem(image: menuItemImage, highlightedImage: nil, contentImage: UIImage(named: imageName), highlightedContentImage: nil);
        }
        let menuItems = [block("shotPart"),block("home"),block("exit"),block("my")];
        let startItem =  AwesomeMenuItem(image: UIImage(named: "menu"), highlightedImage: nil, contentImage: UIImage(named: "plus"), highlightedContentImage: UIImage(named: "plusHL"));
        
        let menu = AwesomeMenu(frame: CGRect(x: 0, y: HEIGHT - 200 - 49, width: 200, height: 200), start: startItem, menuItems: menuItems);
        menu?.menuWholeAngle = CGFloat(M_PI_2);
        menu?.startPoint = CGPoint(x: 20, y: 180);
        menu?.delegate = self;
        menu?.alpha = 0.5;
        self.view.addSubview(menu!);
    }
//MARK: Awesome delegate
    func awesomeMenu(_ menu: AwesomeMenu!, didSelect idx: Int) {
        menu.alpha = 0.5;
        if 0 == idx {
            self.view.addSubview(self.shotPartView);
        }else if 1 == idx {
            self.dismiss(animated: true, completion: nil);
        }else if 2 == idx {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate;
            self.sheet.showInView(appDelegate.window);
        }else if 3 == idx {
            let vc = AboutMyViewController();
            vc.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(vc, animated: true);
        }
    }
//MARK: YZActionSheet delegate
    func yzActionSheet(_ actionSheet: YZActionSheet!, index: Int) {
        if index == 1 {
            exit(0);
        }
    }
    
    func awesomeMenuWillAnimateOpen(_ menu: AwesomeMenu!) {
        menu.alpha = 1.0;
    }
    
    func awesomeMenuWillAnimateClose(_ menu: AwesomeMenu!) {
        menu.alpha = 0.5;
    }
}
