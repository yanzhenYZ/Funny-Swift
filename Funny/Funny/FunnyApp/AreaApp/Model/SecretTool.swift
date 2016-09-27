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
    func addNewSecretItem(_ filePath: String, model: SecretModel) {
        var array = self.secretArrayOfFilePath(filePath);
        array?.append(model);
        NSKeyedArchiver.archiveRootObject(array!, toFile: filePath);
    }
    
    /**      删除数据       */
    func deleteSecretItem(_ filePath: String, index: Int) {
        var array = self.secretArrayOfFilePath(filePath);
        array?.remove(at: index);
        NSKeyedArchiver.archiveRootObject(array!, toFile: filePath);
    }
    
    /**      修改数据       */
    func modifySecretItem(_ filePath: String, index: Int, model: SecretModel) {
        var array = self.secretArrayOfFilePath(filePath);
        array?.remove(at: index);
        array?.insert(model, at: index);
        NSKeyedArchiver.archiveRootObject(array!, toFile: filePath);
    }
   
    /**      加载指定路径下的数据       */
    func secretArrayOfFilePath(_ filePath: String) ->Array<AnyObject>? {
        var array = [SecretModel]();
        
        let exist = FileManager.default.fileExists(atPath: filePath);
        if exist {
            array = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! Array<SecretModel>;
        }
        return array;
    }

}
