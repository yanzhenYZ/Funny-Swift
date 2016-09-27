//
//  SomeWhatPictureModel.swift
//  Funny
//
//  Created by yanzhen on 15/12/28.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

//有点意思
let SomeWhatDefaultPictureURL = "http://ic.snssdk.com/neihan/stream/category/data/v3/?screen_width=720&category_id=12&level=6&count=20&iid=3127363017&device_id=3037163715&ac=wifi&channel=xiaomi&aid=27&app_name=joke_zone&version_code=220&device_platform=android&device_type=2013022&os_api=17&os_version=4.2.1&uuid=864312021030956&openudid=41099610831fa8ef"
let SomeWhatPullHeadURL = "http://ic.snssdk.com/neihan/stream/category/data/v3/?screen_width=720&category_id=12&level=6&count=20&min_time="
let SomeWhatPushHeadURL = "http://ic.snssdk.com/neihan/stream/category/data/v3/?screen_width=720&category_id=12&level=6&count=20&max_time="
let SomeWhatDefaultFootURL = "&iid=3127363017&device_id=3037163715&ac=wifi&channel=xiaomi&aid=27&app_name=joke_zone&version_code=220&device_platform=android&device_type=2013022&os_api=17&os_version=4.2.1&uuid=864312021030956&openudid=41099610831fa8ef"
class SomeWhatPictureModel: NSObject {
   
    /**         用户头像           */
    var avatar_url: String!
    /**         用户昵称           */
    var name: String!
    /**         创建时间           */
    var create_time: NSNumber!
    /**         文字描述           */
    var text: String!
    /**         图片宽度           */
    var r_width: NSNumber!
    /**         图片高度           */
    var r_height: NSNumber!
    /**         图片地址           */
    var url: String!
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
