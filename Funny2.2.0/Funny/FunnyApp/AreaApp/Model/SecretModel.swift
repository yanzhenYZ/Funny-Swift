//
//  SecretModel.swift
//  Funny
//
//  Created by yanzhen on 16/1/7.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class SecretModel: NSObject,NSCoding {
    
    var company: String!
    var account: String!
    var password: String! = nil
    var remarks: String! = nil
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(company, forKey: COMPANY);
        aCoder.encode(account, forKey: ACCOUNT);
        aCoder.encode(password, forKey: PASSWORD);
        aCoder.encode(remarks, forKey: REMARKS);
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init();
        company = aDecoder.decodeObject(forKey: COMPANY) as! String;
        account = aDecoder.decodeObject(forKey: ACCOUNT) as! String;
        password = aDecoder.decodeObject(forKey: PASSWORD) as! String;
        remarks = aDecoder.decodeObject(forKey: REMARKS) as! String;
    }
    
    override init() {
        
    }
    
    //    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    //
    //    }
}
let COMPANY = "company";
let ACCOUNT = "account";
let PASSWORD = "password";
let REMARKS = "remarks";


let SecretPathHeader = documentPath + "/data";
let SecretV2FilePath = SecretPathHeader + "/v2.data";
let SecretAppleFilePath = SecretPathHeader + "/apple.data";
let SecretMailFilePath = SecretPathHeader + "/mail.data";
let SecretGameFilePath = SecretPathHeader + "/game.data";
let SecretBaiduFilePath = SecretPathHeader + "/baidu.data";
let SecretQQFilePath = SecretPathHeader + "/QQ.data";
let SecretAlibabaFilePath = SecretPathHeader + "/alibaba.data";
let SecretOtherFilePath = SecretPathHeader + "/other.data";
let SecretNowFilePath = SecretPathHeader + "/now.data";

let secretTitleArray = ["V2","Apple","Mail","Game","Baidu","QQ","Alibaba","Other","Now"];
let secretFilePathArray = [SecretV2FilePath,SecretAppleFilePath,SecretMailFilePath,SecretGameFilePath,SecretBaiduFilePath,SecretQQFilePath,SecretAlibabaFilePath,SecretOtherFilePath,SecretNowFilePath];
