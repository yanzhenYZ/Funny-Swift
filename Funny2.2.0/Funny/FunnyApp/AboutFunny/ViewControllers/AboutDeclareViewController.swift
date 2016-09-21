//
//  AboutDeclareViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/21.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class AboutDeclareViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default);
        self.navigationController?.navigationBar.shadowImage = nil;
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "声明";
        self.configUI();
        
    }

    fileprivate func configUI() {
        
        let declareLabel = UILabel(frame: CGRect(x: 20, y: 80, width: WIDTH-40, height: 0));
        declareLabel.font = UIFont.systemFont(ofSize: 20.0);
        declareLabel.numberOfLines = 0;
        //declareLabel.textColor = UIColor.blackColor();
        declareLabel.text = "Most of the resources of the App are from the network, the App does not do business purposes, will not have any resource owners infringement.This app's system is swift2.2. \n\n该App支持iPhone6和iPhone6s,其他设备会出现适配问题。";
        self.view.addSubview(declareLabel);
        
        let newSize = FunnyManager.manager.LabelSize(declareLabel.text!, width: WIDTH - 40, font: 20.0);
        declareLabel.height = newSize.height;
        
        let myLabel = UILabel(frame: CGRect(x: 20, y: declareLabel.frame.maxY + 10, width: WIDTH - 40, height: 25));
        myLabel.text = "----- Y&Z";
        myLabel.textAlignment = NSTextAlignment.right;
        self.view.addSubview(myLabel);

        
    }
}
