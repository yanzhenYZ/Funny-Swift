//
//  GifShowVideoModel.swift
//  Funny
//
//  Created by yanzhen on 15/12/28.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

/**                        */
let GifShowPage1 = "os=android&client_key=3c2cd3f3&last=62&count=20&token=&page=1&pcursor=&pv=false&mtype=2&type=7&sig=030d2819371a88871dfdcef832f8d553"
let GifShowPage2 = "os=android&client_key=3c2cd3f3&last=62&count=20&token=&page=2&pcursor=1&pv=false&mtype=2&type=7&sig=e36d8ea8f8467cbe7249308aee2ebff6"
let GifShowPage3 = "os=android&client_key=3c2cd3f3&last=62&count=20&token=&page=3&pcursor=1&pv=false&mtype=2&type=7&sig=99dbc70c2400608033ef75eb2a0e5d32"
let GifShowPage4 = "os=android&client_key=3c2cd3f3&last=62&count=20&token=&page=4&pcursor=1&pv=false&mtype=2&type=7&sig=9d3ddddf8e5f1bcd1245e51b350e386f"
let GifShowPage5 = "os=android&client_key=3c2cd3f3&last=62&count=20&token=&page=5&pcursor=1&pv=false&mtype=2&type=7&sig=97f5a97fef823c93a87103748427926a"
let GifShowPage6 = "os=android&client_key=3c2cd3f3&last=62&count=20&token=&page=6&pcursor=1&pv=false&mtype=2&type=7&sig=f2e0152a41aa5da7cc5ad319a2eab52b"
//上拉
let GifShowDown1 = "os=android&client_key=3c2cd3f3&last=543&count=20&token=&page=1&pcursor=&pv=false&mtype=2&type=7&sig=5f4fc7265650f27d32326f7b55e03f4d"
let GifShowDown2 = "os=android&client_key=3c2cd3f3&last=107&count=20&token=&page=1&pcursor=&pv=false&mtype=2&type=7&sig=de7e9abc2cf9621c54520da169941f43"
let GifShowDown3 = "os=android&client_key=3c2cd3f3&last=69&count=20&token=&page=1&pcursor=&pv=false&mtype=2&type=7&sig=c4aec912c4d5f4091b36ed79746e9e7c"
let GifShowDown4 = "os=android&client_key=3c2cd3f3&last=60&count=20&token=&page=1&pcursor=&pv=false&mtype=2&type=7&sig=d4a0b2798391cd1dddea0fda0d8b57a5"
let GifShowDown5 = "os=android&client_key=3c2cd3f3&last=53&count=20&token=&page=1&pcursor=&pv=false&mtype=2&type=7&sig=06f239d06cf6dd3e5392642c8c593508"

/*************************快手*********************/
//写死的接口----post请求？？？？？？？很多问题
let GifShowHeadURL = "http://api.gifshow.com/rest/n/feed/list?type=7&lat=39.975431&lon=116.338496&ver=4.34&ud=0&sys=ANDROID_4.2.1&c=XIAOMI&net=WIFI&did=ANDROID_41099610831fa8ef&mod=Xiaomi%282013022%29&app=0&language=zh-cn&country_code=CN"
let GifShowTest = "os=android&client_key=3c2cd3f3&last=62&count=20&token=&page=1&pcursor=&pv=false&mtype=2&type=7&sig=030d2819371a88871dfdcef832f8d553"

class GifShowVideoModel: NSObject {

    /**        头像地址       */
    var main_url: String!
    /**        创建时间       */
    var time: String!
    /**        用户昵称       */
    var user_name: String!
    /**        图片地址       */
    var thumbnail_url: String!
    /**        视频地址       */
    var main_mv_url: String!
    /**        时间       */
    var timestamp: NSNumber!
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}

class GifShowOutModel: NSObject {
    
    var llsid: NSNumber!
    var new_notify: NSNumber!
    var pcursor: NSNumber!
    var result: NSNumber!
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
