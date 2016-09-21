//
//  BuDeJieTextModel.swift
//  Funny
//
//  Created by yanzhen on 15/12/29.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit


let BuDeJieDefaultPushFooterURL = "&ver=6.0.6"
//ranking
let BudeJieRankingDefaultURL = "http://api.budejie.com/api/api_open.php?market=xiaomi&order=repost&udid=864312021030956&a=list&appname=baisibudejie&c=data&os=4.2.1&client=android&page=1&per=20&sub_flag=1&visiting=&type=1&mac=68%3Adf%3Add%3A57%3A4e%3Abe&maxtime=&ver=6.0.6"
let BuDeJieRankingPushHeadURL = "http://api.budejie.com/api/api_open.php?market=xiaomi&order=repost&udid=864312021030956&a=list&appname=baisibudejie&c=data&os=4.2.1&client=android&page=1&per=20&sub_flag=1&visiting=&type=1&mac=68%3Adf%3Add%3A57%3A4e%3Abe&maxtime="


//MARK: - Text
let BuDeJieTextUrl = "http://api.budejie.com/api/api_open.php?market=xiaomi&maxid=&udid=864312021030956&a=list&appname=baisibudejie&c=data&os=4.2.1&client=android&page=1&fresh=1&per=20&sub_flag=1&visiting=&type=29&time=week&mac=68%3Adf%3Add%3A57%3A4e%3Abe&ver=6.0.6"
let BuDeJieTextPushHeaderURL = "http://api.budejie.com/api/api_open.php?market=xiaomi&maxid="
let BuDeJieTextPushFooterURL = "&udid=864312021030956&a=list&appname=baisibudejie&c=data&os=4.2.1&client=android&page=1&fresh=1&per=20&sub_flag=1&visiting=&type=29&time=week&mac=68%3Adf%3Add%3A57%3A4e%3Abe&ver=6.0.6"
class BuDeJieTextModel: BuDeJieModel {
   
    
}

//MARK: - Video
let BuDeJieVideoDefaultURL = "http://api.budejie.com/api/api_open.php?market=xiaomi&udid=864312021030956&a=list&appname=baisibudejie&c=video&os=4.2.1&client=android&userID=&page=1&per=20&sub_flag=1&visiting=&type=41&mac=68%3Adf%3Add%3A57%3A4e%3Abe&maxtime=&ver=6.0.6"
let BuDeJieVideoPushHeadURL = "http://api.budejie.com/api/api_open.php?market=xiaomi&udid=864312021030956&a=list&appname=baisibudejie&c=video&os=4.2.1&client=android&userID=&page=1&per=20&sub_flag=1&visiting=&type=41&mac=68%3Adf%3Add%3A57%3A4e%3Abe&maxtime="
class BuDeJieVideoModel: BuDeJieModel {
    
    /**        图片地址       */
    var bimageuri: String!
    /**        视频高度       */
    var height: String!
    /**        视频宽度       */
    var width: String!
    /**        视频地址       */
    var videouri: String!

    
}

//MARK: - Picture
let BuDeJiePictureDefaultURL = "http://api.budejie.com/api/api_open.php?market=xiaomi&maxid=&udid=864312021030956&a=list&appname=baisibudejie&c=data&os=4.2.1&client=android&page=1&fresh=1&per=20&sub_flag=1&visiting=&type=10&time=week&mac=68%3Adf%3Add%3A57%3A4e%3Abe&ver=6.0.6"
let BuDeJiePicturePushHeadURL = "http://api.budejie.com/api/api_open.php?market=xiaomi&maxid="
let BuDeJiePicturePushFootURL = "&udid=864312021030956&a=list&appname=baisibudejie&c=data&os=4.2.1&client=android&page=1&fresh=1&per=20&sub_flag=1&visiting=&type=10&time=week&mac=68%3Adf%3Add%3A57%3A4e%3Abe&ver=6.0.6"
class BuDeJiePictureModel: BuDeJieModel {
    
    /**        图片地址       */
    var cdn_img: String!
    /**        图片高度       */
    var height: String!
    /**        图片宽度       */
    var width: String!
    /**        是否GIF       */
    var is_gif: String!

    
}

class BuDeJieModel: NSObject {
    
    /**        头像地址       */
    var profile_image: String!
    /**        创建时间       */
    var create_time: String!
    /**        用户昵称       */
    var name: String!
    /**        说明文字       */
    var text: String!
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
