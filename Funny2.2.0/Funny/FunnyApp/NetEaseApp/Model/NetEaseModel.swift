//
//  NetEaseModel.swift
//  Funny
//
//  Created by yanzhen on 16/1/4.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit


/*************************网易新闻*********************/
//头条
let NetEaseDefaultFooterURL = "-20.html"
let NetEaseHeadLineDefaultURL = "http://c.m.163.com/nc/article/headline/T1348647909107/0-140.html"
let NetEaseHeadLinePushURL = "http://c.m.163.com/nc/article/list/T1348647909107/"
//原创
let NetEaseOriginalDefaultURL = "http://c.m.163.com/nc/article/list/T1370583240249/0-20.html"
let NetEaseOriginalPushURL = "http://c.m.163.com/nc/article/list/T1370583240249/"
//娱乐
let NetEasePlayDefaultURL = "http://c.m.163.com/nc/article/list/T1348648517839/0-20.html"
let NetEasePlayPushURL = "http://c.m.163.com/nc/article/list/T1348648517839/"
//段子
let NetEaseContentDefaultURL = "http://c.m.163.com/recommend/getChanListNews?passport=&devId=864312021030956&size=20&channel=duanzi"
let NetEaseContentPushURL = "http://c.m.163.com/recommend/getChanRecomNews?passport=&devId=864312021030956&size=20&channel=duanzi"
//体育
let NetEaseSportDefaultURL = "http://c.m.163.com/nc/article/list/T1348649079062/0-20.html"
let NetEaseSportPushURL = "http://c.m.163.com/nc/article/list/T1348649079062/"

class NetEaseModel: NSObject {
    /**
     ***主标题
     */
    var title: String!
    /**
    ***副标题
    */
    var digest: String!
    /**
    ***时间
    */
    var ptime: String!
    /**
    ***来源
    */
    var source: String!
    /**
    ***url
    */
    var url: String!
    /**
    ***源URL
    */
    var url_3w: String!
    /**
    ***一张图片
    */
    var imgsrc: String!
    /**
    ***三张图片(imgsrc)
    */
    var imgextra = [AnyObject]()
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
}
