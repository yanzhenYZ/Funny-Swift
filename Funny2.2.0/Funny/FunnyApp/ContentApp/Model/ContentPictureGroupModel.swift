//
//  ContentPictureGroupModel.swift
//  Funny
//
//  Created by yanzhen on 15/12/28.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

//picture
let ContentPictureMaxHeadURL = "http://ic.snssdk.com/neihan/stream/mix/v1/?mpic=1&essence=1&content_type=-103&message_cursor=-1&longitude=116.33265066504&latitude=39.974047906233&bd_longitude=116.338777&bd_latitude=39.97536&bd_city=%E5%8C%97%E4%BA%AC%E5%B8%82&am_longitude=116.338791&am_latitude=39.975492&am_city=%E5%8C%97%E4%BA%AC%E5%B8%82&am_loc_time=1443144342465&count=30&max_time="
let ContentPictureMaxTailURL = "&screen_width=720&iid=3084467728&device_id=3037163715&ac=wifi&channel=xiaomi&aid=7&app_name=joke_essay&version_code=432&device_platform=android&ssmix=a&device_type=2013022&os_api=17&os_version=4.2.1&uuid=864312021030956&openudid=41099610831fa8ef&manifest_version_code=432"
let ContentPictureMinHeadURL = "http://ic.snssdk.com/neihan/stream/mix/v1/?mpic=1&essence=1&content_type=-103&message_cursor=-1&longitude=116.33265066504&latitude=39.974047906233&bd_longitude=116.338777&bd_latitude=39.97536&bd_city=%E5%8C%97%E4%BA%AC%E5%B8%82&am_longitude=116.338791&am_latitude=39.975492&am_city=%E5%8C%97%E4%BA%AC%E5%B8%82&am_loc_time=1443144342465&count=30&min_time="
let ContentPictureMinTailURL = "&screen_width=720&iid=3084467728&device_id=3037163715&ac=wifi&channel=xiaomi&aid=7&app_name=joke_essay&version_code=432&device_platform=android&ssmix=a&device_type=2013022&os_api=17&os_version=4.2.1&uuid=864312021030956&openudid=41099610831fa8ef&manifest_version_code=432"
class ContentPictureGroupModel: NSObject {
  
    var share_url: String!
    var text: String!
    
    var create_time: NSNumber!
    var r_height: NSNumber!
    var r_width: NSNumber!
    
    var url: String!
    var avatar_url: String!
    var name: String!

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}

class ContentPictureDataModel: NSObject {

    var has_more: AnyObject?
    var has_new_message: AnyObject?
    var max_time: NSNumber!
    var min_time: NSNumber!
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}

class ContentPictureCommentModel: NSObject {
   
    var avatar_url: String!
    var user_name: String!
    var text: String!
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
