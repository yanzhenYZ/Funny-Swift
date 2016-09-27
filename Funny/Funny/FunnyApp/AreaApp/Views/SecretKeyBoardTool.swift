//
//  SecretKeyBoardTool.swift
//  Funny
//
//  Created by yanzhen on 16/1/14.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

enum SecretKBTool: Int {
    /**  上一个  */
    case pre
    /**  下一个  */
    case next
    /**  完成   */
    case done
}

protocol SecretKeyBoardToolProtocol : NSObjectProtocol {
    func SecretKeyBoardItemAction(_ index: Int);
}
class SecretKeyBoardTool: UIView {

    weak var delegate: SecretKeyBoardToolProtocol?
    @IBAction func pre(_ sender: AnyObject) {
        self.delegate?.SecretKeyBoardItemAction(SecretKBTool.pre.rawValue);
    }
    
    @IBAction func next(_ sender: AnyObject) {
        self.delegate?.SecretKeyBoardItemAction(SecretKBTool.next.rawValue);
    }
    
    @IBAction func done(_ sender: AnyObject) {
        self.delegate?.SecretKeyBoardItemAction(SecretKBTool.done.rawValue);
    }

}
