//
//  WalfareModel.swift
//  Funny
//
//  Created by yanzhen on 15/12/30.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit


//MARK: - 内涵福利社 ->段子
let WalfareTextDefaultURL = "http://120.55.151.67/weibofun/weibo_list.php?apiver=10701&category=weibo_jokes&page=0&page_size=30&max_timestamp=-1&latest_viewed_ts=-1&platform=aphone&sysver=4.2.1&appver=1.1.1&buildver=1.1.1&app_ver=10101&uid=-1&udid=a_41099610831fa8ef&channel=xiaomi"
let WalfareTextPullHeadURL = "http://120.55.151.67/weibofun/weibo_list.php?apiver=10701&category=weibo_jokes&page=0&page_size=30&max_timestamp=-1&latest_viewed_ts="
let WalfareTextPushHeadURL = "http://120.55.151.67/weibofun/weibo_list.php?apiver=10701&category=weibo_jokes&page=1&page_size=15&max_timestamp="
class WalfareTextModel: WalfareModel {
    
}
//MARK: - 内涵福利社 ->图片
let WalfarePictureDefaultURL = "http://120.55.151.67/weibofun/weibo_list.php?apiver=10701&category=weibo_pics&page=0&page_size=30&max_timestamp=-1&latest_viewed_ts=-1&platform=aphone&sysver=4.2.1&appver=1.1.1&buildver=1.1.1&app_ver=10101&uid=-1&udid=a_41099610831fa8ef&channel=xiaomi"
let WalfarePicturePullHeadURL = "http://120.55.151.67/weibofun/weibo_list.php?apiver=10701&category=weibo_pics&page=0&page_size=30&max_timestamp=-1&latest_viewed_ts="
let WalfarePicturePushHeadURL = "http://120.55.151.67/weibofun/weibo_list.php?apiver=10701&category=weibo_pics&page=1&page_size=15&max_timestamp="
class WalfarePictureModel: WalfareModel {
    
    /**      图片高度      */
    var wpic_m_height: String!
    /**      图片宽度      */
    var wpic_m_width: String!
    /**      图片地址      */
    var wpic_middle: String!
    /**      是否GIF      */
    var is_gif: String!
}
//MARK: - 内涵福利社 ->视频
let WalfareVideoDefaultURL = "http://120.55.151.67/weibofun/weibo_list.php?apiver=10701&category=weibo_videos&page=0&page_size=30&max_timestamp=-1&latest_viewed_ts=-1&platform=aphone&sysver=4.2.1&appver=1.1.1&buildver=1.1.1&app_ver=10101&uid=-1&udid=a_41099610831fa8ef&channel=xiaomi"
let WalfareVideoPullHeadURL = "http://120.55.151.67/weibofun/weibo_list.php?apiver=10701&category=weibo_videos&page=0&page_size=30&max_timestamp=-1&latest_viewed_ts="
let WalfareVideoPushHeadURL = "http://120.55.151.67/weibofun/weibo_list.php?apiver=10701&category=weibo_videos&page=1&page_size=15&max_timestamp="
class WalfareVideoModel: WalfareModel {
    /*
    = property (nonatomic, copy) NSString *vsource_url;
    */
    /**      图片地址      */
    var vpic_small: String!
    /**      视频地址      */
    var vplay_url: String!
    /**      暂时未用      */
    var vsource_url: String!
}
//MARK: - 内涵福利社 ->美女
let WalfareGirlDefaultURL = "http://120.55.151.67/weibofun/weibo_list.php?apiver=10701&category=weibo_girls&page=0&page_size=30&max_timestamp=-1&latest_viewed_ts=-1&platform=aphone&sysver=4.2.1&appver=1.1.1&buildver=1.1.1&app_ver=10101&uid=-1&udid=a_41099610831fa8ef&channel=xiaomi"
let WalfareGirlPullHeadURL = "http://120.55.151.67/weibofun/weibo_list.php?apiver=10701&category=weibo_girls&page=0&page_size=30&max_timestamp=-1&latest_viewed_ts="
let WalfareGirlPushHeadURL = "http://120.55.151.67/weibofun/weibo_list.php?apiver=10701&category=weibo_girls&page=1&page_size=15&max_timestamp="
class WalfareGirlModel: WalfareModel {
    /*
    = property (nonatomic, copy) NSString *wpic_large;
    */
    /**      图片高度      */
    var wpic_m_height: String!
    /**      图片宽度      */
    var wpic_m_width: String!
    /**      图片地址      */
    var wpic_middle: String!
    /**      是否GIF      */
    var is_gif: String!
}

let WalfareDefaultFootURL = "&platform=aphone&sysver=4.2.1&appver=1.1.1&buildver=1.1.1&app_ver=10101&uid=-1&udid=a_41099610831fa8ef&channel=xiaomi"
let WalfarePushDefaultMiddleURL = "&latest_viewed_ts="
//MARK: - 内涵福利社 ->父类model
class WalfareModel: NSObject {
    /**      创建时间      */
    var update_time: String!
    /**      描述文字      */
    var wbody: String!
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
}