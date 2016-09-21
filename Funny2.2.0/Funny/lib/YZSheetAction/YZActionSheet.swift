//
//  YZActionSheet.swift
//  test
//
//  Created by yanzhen on 16/7/1.
//  Copyright © 2016年 v2tech. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class YZActionSheetItem: NSObject {
    /**     标题     */
    var title: String!
    /**     标题颜色     */
    var titleColor: UIColor?
    /**     标题大小     */
    var titleFont: CGFloat?
    
    init(title: String!, titleColor: UIColor?, titleFont: CGFloat?){
        super.init();
        self.title = title;
        self.titleColor = titleColor;
        self.titleFont = titleFont;
    }
}
//MARK: YZActionSheet
protocol YZActionSheetDelegate : NSObjectProtocol{
    func yzActionSheet(_ actionSheet: YZActionSheet!, index: Int)
}

class YZActionSheet: UIView {

    /**     动画显示的时间(默认0.5)     */
    var showDuration: Float = 0.5
    /**     动画消失的时间(默认0.25)     */
    var dismissDuration: Float = 0.25
    fileprivate
    var titleItem: YZActionSheetItem?
    weak var delegate: YZActionSheetDelegate?
    var cancelItem: YZActionSheetItem?
    var itemsArray: [YZActionSheetItem]?
    var backView: UIView!

    init(titleItem: YZActionSheetItem?, delegate: YZActionSheetDelegate?, cancelItem: YZActionSheetItem?,itemsArray: [YZActionSheetItem]!){
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0));
        self.titleItem = titleItem;
        self.cancelItem = cancelItem;
        self.delegate = delegate;
        self.itemsArray = itemsArray;
        self.configUI();
    }
    
    func showInView(_ view: UIView?) {
        self.backgroundColor = UIColor.clear;
        self.removeFromSuperview();
        let window: UIView! = UIApplication.shared.windows.last;
        var showView = window;
        if view != nil {
            showView = view;
        }
        showView?.addSubview(self);
        self.frame = CGRect(x: 0, y: 0, width: (showView?.frame.size.width)!, height: (showView?.frame.size.height)!);
        backView.frame = CGRect(x: 0, y: (showView?.frame.size.height)!, width: 0, height: 0);
        self.resetFrame();
        self.show();
    }
    
//MARK: private
    
    fileprivate func show() {
        UIView.animate(withDuration: TimeInterval(showDuration), animations: {
            self.backView.frame = CGRect(x: 0, y: self.frame.size.height - self.backView.frame.size.height, width: self.frame.size.width, height: self.backView.frame.size.height);
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2);
        }) 
    }
    
    fileprivate func dismiss() {
        self.backgroundColor = UIColor.clear;
        UIView.animate(withDuration: TimeInterval(dismissDuration), animations: { 
            self.backView.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: self.backView.frame.size.height);
            }, completion: { (finished) in
            self.removeFromSuperview();
        }) 
    }
    
    func btnAction(_ btn: UIButton) {
        delegate?.yzActionSheet(self, index: btn.tag - 100);
        self.dismiss();
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss();
    }
    
//MARK: UI
    fileprivate func resetFrame() {
        let width = self.frame.size.width;
        var itemHeight: CGFloat = 0.0;
        if itemsArray != nil {
            itemHeight = 50.5 * CGFloat(itemsArray!.count);
        }
        var backViewHeight = 50 + 5 + itemHeight;
        if titleItem != nil {
            backViewHeight += (1 + 60);
            let label = backView.viewWithTag(1000);
            label!.frame = CGRect(x: 0, y: 0, width: width, height: 60);
        }else{
            if itemHeight < 1 {
                backViewHeight -= 5;
            }
        }
        backView.frame = CGRect(x: 0, y: backView.frame.origin.y, width: width, height: backViewHeight);
        
        let cancel = backView.viewWithTag(100);
        cancel!.frame = CGRect(x: 0, y: backViewHeight - 50, width: width, height: 50);
        if itemsArray != nil {
            for i: Int in 0 ..< (itemsArray?.count)! {
                let itemBtn = backView.viewWithTag(101 + i);
                itemBtn!.frame = CGRect(x: 0, y: backViewHeight - 55 - 50.5 * CGFloat(i + 1), width: width, height: 50);
            }
        }
    }
    
    fileprivate func configUI() {
        self.backgroundColor = UIColor.clear;
        self.backView = UIView();
        self.backView.clipsToBounds = true;
        self.backView.backgroundColor = UIColor(red: 229/255.0, green: 229/255.0, blue: 231/255.0, alpha: 1.0);
        self.addSubview(self.backView);
        //取消
        let cancel = UIButton(type: .system);
        cancel.backgroundColor = UIColor.white;
        cancel.tag = 100;
        var cancelTitle = "取消";
        var cancelColor = UIColor(red: 22/255.0, green: 22/255.0, blue: 22/255.0, alpha: 1.0);
        var cancelFont = CGFloat(18);
        if cancelItem != nil {
            if cancelItem!.title != nil {
                cancelTitle = cancelItem!.title;
            }
            if cancelItem?.titleColor != nil {
                cancelColor = cancelItem!.titleColor!;
            }
            if cancelItem?.titleFont != nil {
                if cancelItem?.titleFont > 0 {
                    cancelFont = cancelItem!.titleFont!;
                }
            }
        }
        cancel.setTitle(cancelTitle, for: UIControlState());
        cancel.setTitleColor(cancelColor, for: UIControlState());
        cancel.titleLabel?.font = UIFont.systemFont(ofSize: cancelFont);
        cancel.addTarget(self, action: #selector(self.btnAction(_:)), for: .touchUpInside);
        backView.addSubview(cancel);
        //item
        if itemsArray != nil {
            for i: Int in 0 ..< itemsArray!.count {
                let item = itemsArray![i];
                let itemBtn = UIButton(type: .system);
                itemBtn.backgroundColor = UIColor.white;
                itemBtn.tag = 101 + i;
                var itemColor = UIColor(red: 222/255.0, green: 63/255.0, blue: 65/255.0, alpha: 1.0);
                var itemFont = CGFloat(18);
                if item.titleColor != nil {
                    itemColor = item.titleColor!;
                }
                if item.titleFont != nil {
                    if item.titleFont > 0 {
                        itemFont = item.titleFont!;
                    }
                }
                itemBtn.setTitle(item.title, for: UIControlState());
                itemBtn.setTitleColor(itemColor, for: UIControlState());
                itemBtn.titleLabel?.font = UIFont.systemFont(ofSize: itemFont);
                itemBtn.addTarget(self, action: #selector(self.btnAction(_:)), for: .touchUpInside);
                backView.addSubview(itemBtn);
            }
        }
                //title
        if titleItem != nil {
            let label = UILabel();
            label.tag = 1000;
            label.backgroundColor = UIColor.white;
            label.textAlignment = .center;
            label.text = titleItem?.title;
            var labelColor = UIColor(red: 147/255.0, green: 148/255.0, blue: 149/255.0, alpha: 1.0);
            var labelFont = CGFloat(15);
            if titleItem!.titleColor != nil {
                labelColor = titleItem!.titleColor!;
            }
            if titleItem!.titleFont != nil {
                if titleItem!.titleFont > 0 {
                    labelFont = titleItem!.titleFont!;
                }
            }
            label.textColor = labelColor;
            label.font = UIFont.systemFont(ofSize: labelFont);
            backView.addSubview(label);
        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
