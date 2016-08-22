//
//  FunnyEnumAndMacro.swift
//  Funny
//
//  Created by yanzhen on 16/4/5.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

let WIDTH = UIScreen.mainScreen().bounds.size.width;
let HEIGHT = UIScreen.mainScreen().bounds.size.height;
let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
let documentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0];
let cachePath = NSSearchPathForDirectoriesInDomains(.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0];
let PASSWORDISYESORWRONG = "PasswordIsYesOrWrong";
let NOTEXT = "NO_TEXT";
let JSON = "application/json";
let HTML = "text/html"
let test = "Test"
let PlayImage = UIImage(named: "play")!;
let HeadImage = UIImage(named: "大熊_2")!;
let SmallImage = UIImage(named: "small")!;
let BigImage = UIImage(named: "大熊_1")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
let FunnyColor = UIColor(red: 255 / 255.0, green: 133 / 255.0, blue: 25 / 255.0, alpha: 1.0);



class FunnyEnumAndMacro: NSObject {

}

//MARK: Enum
enum FunnyApp: Int {
    case Content = 100
    case GifShow
    case BuDeJie
    case Walfare
    case UCNews
    case NetEase
    case SinaNews
    case Area
    case DrawPicture
    case Note
    case QRCode
}

enum MJRefresh : Int {
    case Pull = -1
    case Nomal
    case Push
}

enum AddImageViewAction : Int {
    case ScreenShot=0
    case ScreenShotPart
    case HomePage
    case Exit
}