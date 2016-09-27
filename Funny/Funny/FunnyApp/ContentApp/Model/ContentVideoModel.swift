//
//  ContentVideoModel.swift
//  Funny
//
//  Created by yanzhen on 15/12/25.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

//MARK: - 内涵段子 - recomendVideo
let ContentRecommendDefaultURL="http://ic.snssdk.com/neihan/stream/mix/v1/?mpic=1&essence=1&content_type=-101&message_cursor=-1&longitude=116.33265066504&latitude=39.974047906233&bd_longitude=116.338777&bd_latitude=39.97536&bd_city=%E5%8C%97%E4%BA%AC%E5%B8%82&am_longitude=116.338791&am_latitude=39.975492&am_city=%E5%8C%97%E4%BA%AC%E5%B8%82&am_loc_time=1443144342465&count=30&screen_width=720&iid=3084467728&device_id=3037163715&ac=wifi&channel=xiaomi&aid=7&app_name=joke_essay&version_code=432&device_platform=android&ssmix=a&device_type=2013022&os_api=17&os_version=4.2.1&uuid=864312021030956&openudid=41099610831fa8ef&manifest_version_code=432"

let ContentRecommendMaxHeadURL = "http://ic.snssdk.com/neihan/stream/mix/v1/?mpic=1&essence=1&content_type=-101&message_cursor=-1&longitude=116.33265066504&latitude=39.974047906233&bd_longitude=116.338777&bd_latitude=39.97536&bd_city=%E5%8C%97%E4%BA%AC%E5%B8%82&am_longitude=116.338791&am_latitude=39.975492&am_city=%E5%8C%97%E4%BA%AC%E5%B8%82&am_loc_time=1443144342465&count=30&max_time="
let ContentRecommendMaxFootURL = "&screen_width=720&iid=3084467728&device_id=3037163715&ac=wifi&channel=xiaomi&aid=7&app_name=joke_essay&version_code=432&device_platform=android&ssmix=a&device_type=2013022&os_api=17&os_version=4.2.1&uuid=864312021030956&openudid=41099610831fa8ef&manifest_version_code=432"
let ContentRecommendMinHeadURL = "http://ic.snssdk.com/neihan/stream/mix/v1/?mpic=1&essence=1&content_type=-101&message_cursor=-1&longitude=116.33265066504&latitude=39.974047906233&bd_longitude=116.338777&bd_latitude=39.97536&bd_city=%E5%8C%97%E4%BA%AC%E5%B8%82&am_longitude=116.338791&am_latitude=39.975492&am_city=%E5%8C%97%E4%BA%AC%E5%B8%82&am_loc_time=1443144342465&count=30&min_time="
let ContentRecommendMinFootURL = "&screen_width=720&iid=3084467728&device_id=3037163715&ac=wifi&channel=xiaomi&aid=7&app_name=joke_essay&version_code=432&device_platform=android&ssmix=a&device_type=2013022&os_api=17&os_version=4.2.1&uuid=864312021030956&openudid=41099610831fa8ef&manifest_version_code=432"
//MARK - Video
//video
let ConTentVideoMaxHeadURL = "http://ic.snssdk.com/neihan/stream/mix/v1/?mpic=1&essence=1&content_type=-104&message_cursor=-1&longitude=116.33265066504&latitude=39.974047906233&bd_longitude=116.338777&bd_latitude=39.97536&bd_city=%E5%8C%97%E4%BA%AC%E5%B8%82&am_longitude=116.338791&am_latitude=39.975492&am_city=%E5%8C%97%E4%BA%AC%E5%B8%82&am_loc_time=1443144342465&count=30&max_time="
let ContentVideoMaxFootURL = "&screen_width=720&iid=3084467728&device_id=3037163715&ac=wifi&channel=xiaomi&aid=7&app_name=joke_essay&version_code=432&device_platform=android&ssmix=a&device_type=2013022&os_api=17&os_version=4.2.1&uuid=864312021030956&openudid=41099610831fa8ef&manifest_version_code=432"
let ContentVideoMinHeadURL = "http://ic.snssdk.com/neihan/stream/mix/v1/?mpic=1&essence=1&content_type=-104&message_cursor=-1&longitude=116.33265066504&latitude=39.974047906233&bd_longitude=116.338777&bd_latitude=39.97536&bd_city=%E5%8C%97%E4%BA%AC%E5%B8%82&am_longitude=116.338791&am_latitude=39.975492&am_city=%E5%8C%97%E4%BA%AC%E5%B8%82&am_loc_time=1443144342465&count=30&min_time="
let ContentVideoMinFootURL = "&screen_width=720&iid=3084467728&device_id=3037163715&ac=wifi&channel=xiaomi&aid=7&app_name=joke_essay&version_code=432&device_platform=android&ssmix=a&device_type=2013022&os_api=17&os_version=4.2.1&uuid=864312021030956&openudid=41099610831fa8ef&manifest_version_code=432"

class ContentVideoModel: NSObject {
   
    var avatar_url: String!
    var name: String!
    //
    var create_time: NSNumber!
    var text: String!
    var share_url: String!
    var mp4_url: String!
    var duration: NSNumber!
    //
    var imageURL: String!
    var width: NSNumber!
    var height: NSNumber!
    var url: String!
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}

class ContentVideoDataModel: NSObject {
    
    var has_more: AnyObject?
    var has_new_message: AnyObject?
    var max_time: NSNumber!
    var min_time: NSNumber!
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}

class ContentVideoCommentsModel: NSObject {
    
    var avatar_url: String!
    var user_name: String!
    var text: String!
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
