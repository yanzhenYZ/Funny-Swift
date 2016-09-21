//
//  FunnyEnumAndMacro.swift
//  Funny
//
//  Created by yanzhen on 16/4/5.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

let WIDTH = UIScreen.main.bounds.size.width;
let HEIGHT = UIScreen.main.bounds.size.height;
let appDelegate = UIApplication.shared.delegate as! AppDelegate;
let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0];
let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0];
let PASSWORDISYESORWRONG = "PasswordIsYesOrWrong";
let NOTEXT = "NO_TEXT";
let JSON = "application/json";
let HTML = "text/html"
let test = "Test"
let PlayImage = UIImage(named: "play")!;
let HeadImage = UIImage(named: "大熊_2")!;
let SmallImage = UIImage(named: "small")!;
let BigImage = UIImage(named: "大熊_1")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
let FunnyColor = UIColor(red: 255 / 255.0, green: 133 / 255.0, blue: 25 / 255.0, alpha: 1.0);



class FunnyEnumAndMacro: NSObject {

}

//MARK: Enum
enum FunnyApp: Int {
    case content = 100
    case gifShow
    case buDeJie
    case walfare
    case ucNews
    case netEase
    case sinaNews
    case area
    case drawPicture
    case note
    case qrCode
}

enum MJRefresh : Int {
    case pull = -1
    case nomal
    case push
}

enum AddImageViewAction : Int {
    case screenShot=0
    case screenShotPart
    case homePage
    case exit
}
