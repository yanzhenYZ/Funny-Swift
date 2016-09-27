//
//  AddImageView.swift
//  Funny
//
//  Created by yanzhen on 15/12/22.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

protocol AddImageViewProtocol : NSObjectProtocol {
    func addImageViewTableViewSelect(_ index: Int)
}
class AddImageView: UIImageView ,UITableViewDataSource,UITableViewDelegate{
    weak var delegate: AddImageViewProtocol?
    var isAddImageViewHidden: Bool?
    var addSecondTableView: UITableView!
    var titleSecondArray=[String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        isAddImageViewHidden=true;
        self.backgroundColor=UIColor.clear;
        self.isUserInteractionEnabled=true;
        self.clipsToBounds=true;
        let image=UIImage(named: "addView");
        let insetsSecond=UIEdgeInsetsMake(40, 15 , 30 , 15 );
        self.image=image?.resizableImage(withCapInsets: insetsSecond, resizingMode: UIImageResizingMode.stretch);
        titleSecondArray=["全屏截图","部分截图","主页面","退出"];
        addSecondTableView=UITableView(frame: CGRect(x: 1.0, y: 5.0, width: 108.0, height: CGFloat(titleSecondArray.count) * 45.0));
        addSecondTableView.register(UINib(nibName: "SuperSecondTableViewCell", bundle: nil), forCellReuseIdentifier: "SuperSecondCell");
        addSecondTableView.rowHeight=45.0;
        addSecondTableView.delegate=self;
        addSecondTableView.dataSource=self;
        addSecondTableView.scrollsToTop=false;
        addSecondTableView.separatorStyle=UITableViewCellSeparatorStyle.none;
        addSecondTableView.backgroundColor=UIColor.clear;
        self.addSubview(addSecondTableView);
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return titleSecondArray.count;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "SuperSecondCell", for: indexPath) as! SuperSecondTableViewCell;
        cell.titleSecondLabel.text=titleSecondArray[indexPath.row];
        if indexPath.row == titleSecondArray.count-1 {
            cell.bottomSecondImageView.isHidden=true;
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        self.toggleAddImageView();
        self.delegate?.addImageViewTableViewSelect(indexPath.row);
    }
    
    func toggleAddImageView() {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            var height:CGFloat = 0.0;
            if self.isAddImageViewHidden == true {
                self.isAddImageViewHidden=false;
                height=CGFloat(self.titleSecondArray.count) * 45.0+2.0;
            }else{
                self.isAddImageViewHidden=true;
            }
            self.frame=CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: height);
        });
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
