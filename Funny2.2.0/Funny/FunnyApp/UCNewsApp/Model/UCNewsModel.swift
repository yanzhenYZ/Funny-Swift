//
//  UCNewsModel.swift
//  Funny
//
//  Created by yanzhen on 15/12/31.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

import UIKit

/*************************UC新闻*********************/
//推荐
let UCNewsRecommendHeadURL = "http://iflow.sm.cn/iflow/api/v1/channel/100?method=new&ftime="
let UCNewsRecommendMiddleURL = "&recoid=10677767073685024614&count=20&content_ratio=0&app=uc-iflow&no_op=0&auto=0&_tm="
let UCNewsRecommendFootURL = "&uc_param_str=dnnivebichfrmintcpgieiwidsudsv&user_tag=bTkwBOMv7JHbxm%2Bzgw%3D%3D&dn=4856707842-f65933e2&ni=bTkwBAIxIIL5r73W34ipnh0y76uJdfMO7wtXMxHwkvjfPg%3D%3D&ve=10.7.0.634&bi=800&ch=chens%40xmsd&fr=android&mi=2013022&nt=2&cp=isp:%E7%A7%BB%E5%8A%A8;prov:%E5%8C%97%E4%BA%AC;city:%E5%8C%97%E4%BA%AC;na:%E4%B8%AD%E5%9B%BD;cc:CN;ac:&gi=bTkwBNdtCtHxtgIM9sxPy%2BZNgghg1fqvNxfBBtdKnbxybuI%3D&ei=bTkwBC%2B9Bh7NEUawLnpHdbQtmOQybLu1LQ%3D%3D&wi=bTkwBMABGDi2R7SqRw%3D%3D&ds=bTkwBCDGtHqwd3OsXjdT0yl6QsisKoREuFjabOHA2ubsKg%3D%3D&ud=bTkwBDLcdjXJddOoE17UZrxquTQnolm8Jkkdcw%3D%3D&sv=ucrelease4&sign=bTkwBNk0myfb30S5jPw4Zu5O4tNmd49eUE7gdbT5UrN80EWvumA85UXt"

//NBA
let UCNewsNBAHeadURL = "http://iflow.sm.cn/iflow/api/v1/channel/90002?method=new&ftime="
let UCNewsNBAMiddleURL = "&recoid=1461289352020274806&count=10&content_ratio=0&app=uc-iflow&no_op=0&auto=1&_tm="
let UCNewsNBAFootURL = "&uc_param_str=dnnivebichfrmintcpgieiwidsudsv&user_tag=bTkwBA6j0jqmUgnOFw%3D%3D&dn=4856707842-f65933e2&ni=bTkwBAIxIIL5r73W34ipnh0y76uJdfMO7wtXMxHwkvjfPg%3D%3D&ve=10.7.0.634&bi=800&ch=chens%40xmsd&fr=android&mi=2013022&nt=2&cp=isp:%E7%A7%BB%E5%8A%A8;prov:%E5%8C%97%E4%BA%AC;city:%E5%8C%97%E4%BA%AC;na:%E4%B8%AD%E5%9B%BD;cc:CN;ac:&gi=bTkwBNdtCtHxtgIM9sxPy%2BZNgghg1fqvNxfBBtdKnbxybuI%3D&ei=bTkwBC%2B9Bh7NEUawLnpHdbQtmOQybLu1LQ%3D%3D&wi=bTkwBMABGDi2R7SqRw%3D%3D&ds=bTkwBCDGtHqwd3OsXjdT0yl6QsisKoREuFjabOHA2ubsKg%3D%3D&ud=bTkwBDLcdjXJddOoE17UZrxquTQnolm8Jkkdcw%3D%3D&sv=ucrelease4&sign=bTkwBPOnfsyPU6kH23Tftj213gaqGkWOJ%2BB4anZuTj3wgLhssBWsfbC0"
//娱乐
let UCNewsPlayHeadURL = "http://iflow.sm.cn/iflow/api/v1/channel/179223212?method=new&ftime="
let UCNewsPlayMiddleURL = "&recoid=10401317567056716457&count=20&content_ratio=0&app=uc-iflow&no_op=0&auto=1&_tm="
let UCNewsPlayFootURL = "&uc_param_str=dnnivebichfrmintcpgieiwidsudsv&user_tag=bTkwBA%2BAImintbnP8A%3D%3D&dn=4856707842-f65933e2&ni=bTkwBAIxIIL5r73W34ipnh0y76uJdfMO7wtXMxHwkvjfPg%3D%3D&ve=10.7.0.634&bi=800&ch=chens%40xmsd&fr=android&mi=2013022&nt=2&cp=isp:%E7%A7%BB%E5%8A%A8;prov:%E5%8C%97%E4%BA%AC;city:%E5%8C%97%E4%BA%AC;na:%E4%B8%AD%E5%9B%BD;cc:CN;ac:&gi=bTkwBNdtCtHxtgIM9sxPy%2BZNgghg1fqvNxfBBtdKnbxybuI%3D&ei=bTkwBC%2B9Bh7NEUawLnpHdbQtmOQybLu1LQ%3D%3D&wi=bTkwBMABGDi2R7SqRw%3D%3D&ds=bTkwBCDGtHqwd3OsXjdT0yl6QsisKoREuFjabOHA2ubsKg%3D%3D&ud=bTkwBDLcdjXJddOoE17UZrxquTQnolm8Jkkdcw%3D%3D&sv=ucrelease4&sign=bTkwBOWFXRqa3vlH4CiKccnobvpC3gxjAijQXCiEm1JKHD8gja0gRQld"
//社会
let UCNewsSocialHeadURL = "http://iflow.sm.cn/iflow/api/v1/channel/1192652582?method=new&ftime="
let UCNewsSocialMiddleURL = "&recoid=&count=20&content_ratio=0&app=uc-iflow&no_op=0&auto=1&_tm="
let UCNewsSocialFootURL = "&uc_param_str=dnnivebichfrmintcpgieiwidsudsv&user_tag=bTkwBNvse6nTCdC7TA%3D%3D&dn=4856707842-f65933e2&ni=bTkwBAIxIIL5r73W34ipnh0y76uJdfMO7wtXMxHwkvjfPg%3D%3D&ve=10.7.0.634&bi=800&ch=chens%40xmsd&fr=android&mi=2013022&nt=2&cp=isp:%E7%A7%BB%E5%8A%A8;prov:%E5%8C%97%E4%BA%AC;city:%E5%8C%97%E4%BA%AC;na:%E4%B8%AD%E5%9B%BD;cc:CN;ac:&gi=bTkwBNdtCtHxtgIM9sxPy%2BZNgghg1fqvNxfBBtdKnbxybuI%3D&ei=bTkwBC%2B9Bh7NEUawLnpHdbQtmOQybLu1LQ%3D%3D&wi=bTkwBMABGDi2R7SqRw%3D%3D&ds=bTkwBCDGtHqwd3OsXjdT0yl6QsisKoREuFjabOHA2ubsKg%3D%3D&ud=bTkwBDLcdjXJddOoE17UZrxquTQnolm8Jkkdcw%3D%3D&sv=ucrelease4&sign=bTkwBPsBL7PwXqksqc3m7l%2BXzMrmou7BO%2BkeomJ3K2vnKfD6J7kekt4S"
//笑话
let UCNewsFunnyHeadURL = "http://iflow.sm.cn/iflow/api/v1/channel/10013?method=new&ftime="
let UCNewsFunnyMiddleURL = "&recoid=&count=20&content_ratio=0&app=uc-iflow&no_op=0&auto=1&_tm="
let UCNewsFunnyFootURL = "&uc_param_str=dnnivebichfrmintcpgieiwidsudsv&user_tag=bTkwBMe7qNX%2FeiOXPw%3D%3D&dn=4856707842-f65933e2&ni=bTkwBAIxIIL5r73W34ipnh0y76uJdfMO7wtXMxHwkvjfPg%3D%3D&ve=10.7.0.634&bi=800&ch=chens%40xmsd&fr=android&mi=2013022&nt=2&cp=isp:%E7%A7%BB%E5%8A%A8;prov:%E5%8C%97%E4%BA%AC;city:%E5%8C%97%E4%BA%AC;na:%E4%B8%AD%E5%9B%BD;cc:CN;ac:&gi=bTkwBNdtCtHxtgIM9sxPy%2BZNgghg1fqvNxfBBtdKnbxybuI%3D&ei=bTkwBC%2B9Bh7NEUawLnpHdbQtmOQybLu1LQ%3D%3D&wi=bTkwBMABGDi2R7SqRw%3D%3D&ds=bTkwBCDGtHqwd3OsXjdT0yl6QsisKoREuFjabOHA2ubsKg%3D%3D&ud=bTkwBDLcdjXJddOoE17UZrxquTQnolm8Jkkdcw%3D%3D&sv=ucrelease4&sign=bTkwBNvRW3HiCYHu%2BmWKq5xzYTlSt3MxKXnQL8iTm1kTYELxpY00%2F1pW"
//军事
let UCNewsArmyHeadURL = "http://iflow.sm.cn/iflow/api/v1/channel/1105405272?method=his&ftime="
let UCNewsArmyMiddleURL = "&recoid=1923813405056863804&count=10&content_ratio=0&app=uc-iflow&no_op=0&auto=0&_tm="
let UCNewsArmyFootURL = "&uc_param_str=dnnivebichfrmintcpgieiwidsudsv&user_tag=bTkwBMMFiLr7MMOTdQ%3D%3D&dn=4856707842-f65933e2&ni=bTkwBAIxIIL5r73W34ipnh0y76uJdfMO7wtXMxHwkvjfPg%3D%3D&ve=10.7.0.634&bi=800&ch=chens%40xmsd&fr=android&mi=2013022&nt=2&cp=isp:%E7%A7%BB%E5%8A%A8;prov:%E5%8C%97%E4%BA%AC;city:%E5%8C%97%E4%BA%AC;na:%E4%B8%AD%E5%9B%BD;cc:CN;ac:&gi=bTkwBBLR4v20WjpYM2hgH3p0Vqfq7Sp3hHtJ%2BpiXDjQIHXU%3D&ei=bTkwBC%2B9Bh7NEUawLnpHdbQtmOQybLu1LQ%3D%3D&wi=bTkwBDWmlqfLPDLXPA%3D%3D&ds=bTkwBCDGtHqwd3OsXjdT0yl6QsisKoREuFjabOHA2ubsKg%3D%3D&ud=bTkwBDLcdjXJddOoE17UZrxquTQnolm8Jkkdcw%3D%3D&sv=ucrelease4&sign=bTkwBMkTWbm2Tvcs%2B6j61Iz8EzsONwqkpSzqt4ddrXROICujfpVGqwNv"


class UCNewsModel: NSObject {
    
    /**      标题        */
    var title: String!
    /**      网址        */
    var url: String!
    /**      来源        */
    var origin_src_name: String!
    /**      来源网址        */
    var original_url: String!
    /**      ？？？        */
    var style_type: NSNumber!
    /**      出版时间        */
    var publish_time: NSNumber!
    /**      存放图片网址的数组        */
    var thumbnails = [AnyObject]()

    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }

}
