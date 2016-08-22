//
//  SecretTool.swift
//  Funny
//
//  Created by yanzhen on 16/1/18.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class SecretTool: NSObject {
    
    /**      添加数据       */
    func addNewSecretItem(filePath: String, model: SecretModel) {
        var array = self.secretArrayOfFilePath(filePath);
        array?.append(model);
        NSKeyedArchiver.archiveRootObject(array!, toFile: filePath);
    }
    
    /**      删除数据       */
    func deleteSecretItem(filePath: String, index: Int) {
        var array = self.secretArrayOfFilePath(filePath);
        array?.removeAtIndex(index);
        NSKeyedArchiver.archiveRootObject(array!, toFile: filePath);
    }
    
    /**      修改数据       */
    func modifySecretItem(filePath: String, index: Int, model: SecretModel) {
        var array = self.secretArrayOfFilePath(filePath);
        array?.removeAtIndex(index);
        array?.insert(model, atIndex: index);
        NSKeyedArchiver.archiveRootObject(array!, toFile: filePath);
    }
   
    /**      加载指定路径下的数据       */
    func secretArrayOfFilePath(filePath: String) ->Array<AnyObject>? {
        var array = [SecretModel]();
        
        let exist = NSFileManager.defaultManager().fileExistsAtPath(filePath);
        if exist {
            array = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as! Array<SecretModel>;
        }
        return array;
    }

}
