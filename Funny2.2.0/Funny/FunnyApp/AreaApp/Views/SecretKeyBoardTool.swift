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
    case Pre
    /**  下一个  */
    case Next
    /**  完成   */
    case Done
}

protocol SecretKeyBoardToolProtocol : NSObjectProtocol {
    func SecretKeyBoardItemAction(index: Int);
}
class SecretKeyBoardTool: UIView {

    weak var delegate: SecretKeyBoardToolProtocol?
    @IBAction func pre(sender: AnyObject) {
        self.delegate?.SecretKeyBoardItemAction(SecretKBTool.Pre.rawValue);
    }
    
    @IBAction func next(sender: AnyObject) {
        self.delegate?.SecretKeyBoardItemAction(SecretKBTool.Next.rawValue);
    }
    
    @IBAction func done(sender: AnyObject) {
        self.delegate?.SecretKeyBoardItemAction(SecretKBTool.Done.rawValue);
    }

}
