//
//  SinaNewsModel.swift
//  Funny
//
//  Created by yanzhen on 16/1/5.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

let SinaNewsDefaultHeadURL = "http://api.sina.cn/sinago/list.json?uid=aa31ca8b95d9be1d&loading_ad_timestamp=0&platfrom_version=4.2.1&wm=b207&imei=864312021030956&from=6048295012&connection_type=2&chwm=14010_0001&AndroidID=54311f315451935f5018874c7a46f88e&v=1&s=20&IMEI=aee8dee79e22198eedfc9a194387dbf5&p="
let SinaNewsDefaultFootURL = "&MAC=8334eea73efc71c74369fd0f31a64c5b&channel=news_"

//
let SinaRecommendNormalURL = "http://api.sina.cn/sinago/list.json?uid=aa31ca8b95d9be1d&loading_ad_timestamp=0&platfrom_version=4.2.1&wm=b207&imei=864312021030956&from=6048295012&connection_type=2&city=WMXX2971&chwm=14010_0001&AndroidID=54311f315451935f5018874c7a46f88e&v=1&IMEI=aee8dee79e22198eedfc9a194387dbf5&length=21&offset=0&MAC=8334eea73efc71c74369fd0f31a64c5b&channel=news_tuijian"
let SinaRecommendPullHeadURL = "http://api.sina.cn/sinago/list.json?uid=aa31ca8b95d9be1d&loading_ad_timestamp=0&platfrom_version=4.2.1&wm=b207&imei=864312021030956&from=6048295012&connection_type=2&city=WMXX2971&chwm=14010_0001&AndroidID=54311f315451935f5018874c7a46f88e&v=1&IMEI=aee8dee79e22198eedfc9a194387dbf5&length=6&offset="
let SinaRecommendPushHeadURL = "http://api.sina.cn/sinago/list.json?uid=aa31ca8b95d9be1d&loading_ad_timestamp=0&platfrom_version=4.2.1&wm=b207&imei=864312021030956&from=6048295012&connection_type=2&city=WMXX2971&chwm=14010_0001&AndroidID=54311f315451935f5018874c7a46f88e&v=1&IMEI=aee8dee79e22198eedfc9a194387dbf5&length=20&offset="

class SinaNewsModel: NSObject {
   
    /**
    ***标题
    */
    var title: String!
    /**
    ***小标题
    */
    var intro: String!
    /**
    ***图片网址
    */
    var kpic: String!
    /**
    ***web网址
    */
    var link: String!
    /**
    ***三张图片->list(NSArray)->(NSDictionary)->kpic
    */
    var pics: Dictionary<String,AnyObject>!
    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }

}
