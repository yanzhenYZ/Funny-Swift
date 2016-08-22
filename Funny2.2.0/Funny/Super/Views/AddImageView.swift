//
//  AddImageView.swift
//  Funny
//
//  Created by yanzhen on 15/12/22.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

protocol AddImageViewProtocol : NSObjectProtocol {
    func addImageViewTableViewSelect(index: Int)
}
class AddImageView: UIImageView ,UITableViewDataSource,UITableViewDelegate{
    weak var delegate: AddImageViewProtocol?
    var isAddImageViewHidden: Bool?
    var addSecondTableView: UITableView!
    var titleSecondArray=[String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        isAddImageViewHidden=true;
        self.backgroundColor=UIColor.clearColor();
        self.userInteractionEnabled=true;
        self.clipsToBounds=true;
        let image=UIImage(named: "addView");
        let insetsSecond=UIEdgeInsetsMake(40, 15 , 30 , 15 );
        self.image=image?.resizableImageWithCapInsets(insetsSecond, resizingMode: UIImageResizingMode.Stretch);
        titleSecondArray=["全屏截图","部分截图","主页面","退出"];
        addSecondTableView=UITableView(frame: CGRectMake(1.0, 5.0, 108.0, CGFloat(titleSecondArray.count) * 45.0));
        addSecondTableView.registerNib(UINib(nibName: "SuperSecondTableViewCell", bundle: nil), forCellReuseIdentifier: "SuperSecondCell");
        addSecondTableView.rowHeight=45.0;
        addSecondTableView.delegate=self;
        addSecondTableView.dataSource=self;
        addSecondTableView.scrollsToTop=false;
        addSecondTableView.separatorStyle=UITableViewCellSeparatorStyle.None;
        addSecondTableView.backgroundColor=UIColor.clearColor();
        self.addSubview(addSecondTableView);
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return titleSecondArray.count;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell=tableView.dequeueReusableCellWithIdentifier("SuperSecondCell", forIndexPath: indexPath) as! SuperSecondTableViewCell;
        cell.titleSecondLabel.text=titleSecondArray[indexPath.row];
        if indexPath.row == titleSecondArray.count-1 {
            cell.bottomSecondImageView.hidden=true;
        }
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.toggleAddImageView();
        self.delegate?.addImageViewTableViewSelect(indexPath.row);
    }
    
    func toggleAddImageView() {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            var height:CGFloat = 0.0;
            if self.isAddImageViewHidden == true {
                self.isAddImageViewHidden=false;
                height=CGFloat(self.titleSecondArray.count) * 45.0+2.0;
            }else{
                self.isAddImageViewHidden=true;
            }
            self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
        });
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
