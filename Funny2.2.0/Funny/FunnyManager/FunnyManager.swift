//
//  FunnyManager.swift
//  Funny
//
//  Created by yanzhen on 16/4/5.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class FunnyManager: NSObject {
//MARK: - 清除缓存
    
    func fileSize(filePath: String) ->Int {
        var fileSize: Int = 0;
        let fileManager = NSFileManager.defaultManager();
        var isDir = ObjCBool(false);
        let exist = fileManager.fileExistsAtPath(filePath, isDirectory: &isDir);
        if exist {
            if isDir {
                let subPaths = fileManager.subpathsAtPath(filePath);
                for (_,value) in subPaths!.enumerate() {
                    let path = filePath + "/" + value;
                    var isDirectory = ObjCBool(false);
                    fileManager.fileExistsAtPath(path, isDirectory: &isDirectory);
                    if !isDirectory{
                        fileSize += try! (fileManager.attributesOfItemAtPath(path)[NSFileSize]?.integerValue)!;
                    }
                }
                
            }else{
                fileSize = try! (fileManager.attributesOfItemAtPath(filePath)[NSFileSize]?.integerValue)!;
            }
        }
        
        return fileSize;
    }
    
    func clearMemory() {
        let manage = SDWebImageManager();
        manage.cancelAll();
        manage.imageCache.clearMemory();
        manage.imageCache.clearDisk();
        
        //let file = cachePath + "/default";
        let exist = NSFileManager.defaultManager().fileExistsAtPath(cachePath);
        if exist {
            do {
                try NSFileManager.defaultManager().removeItemAtPath(cachePath)
            } catch {
                
            }
//            let error: NSErrorPointer = nil;
//            do {
//                try NSFileManager.defaultManager().removeItemAtPath(cachePath)
//            } catch let error1 as NSError {
//                //error.memory = error1
//            };
        }
    }
    /**  label.size  */
    func LabelSize(text: String, width: CGFloat, font: CGFloat) ->CGSize {
        
        let oldSize = CGSizeMake(width, 9999.0);
        let newSize = text.boundingRectWithSize(oldSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(font)], context: nil).size;
        return newSize;
    }

//MARK: - date
    func dateWithTimeInterval(time: Int32) ->String {
        
        let date = NSDate(timeIntervalSince1970: Double(time));
        let format = NSDateFormatter();
        format.dateFormat = "yyyy-MM-dd HH:mm:ss";
        return format.stringFromDate(date);
    }
    
    func currentTime() ->String {
        let currentTime = NSDate().timeIntervalSince1970;
        let intTime = Int32(currentTime);
        return String(intTime);
    }
    
    func timeIntervalWithDateString(dateString: String) ->NSNumber {
        let f = NSDateFormatter();
        f.dateFormat = "yyyy-MM-dd HH:mm:ss";
        let date = f.dateFromString(dateString);
        let time = date?.timeIntervalSince1970;
        return NSNumber(int: Int32(time!));
    }
//MARK: - 网址判断
    /**       判断是不是网址           */
    func isNetURL(str: String) ->Bool {
        var url: String!
        if !str.hasPrefix("http://") {
            url = "http://" + str;
        }else{
            url = str;
        }
        let range = url.rangeOfString("^http://([\\w-]+\\.)+[\\w-]+[\\w:]+(/[\\w-./?%&=]*)?$", options: NSStringCompareOptions.RegularExpressionSearch, range: nil, locale: nil);
        if range != nil {
            if !range!.isEmpty {
                return true;
            }
        }
        
        return false;
    }

    /**  圆   */
    func cornerRadian(view: UIView) {
        view.layer.masksToBounds = true;
        view.layer.cornerRadius = view.frame.size.width / 2;
    }
    
//MARK: - color
    func color(R: CGFloat,G: CGFloat,B: CGFloat) ->UIColor {
        return UIColor(red: R / 255.0, green: G / 255.0, blue: B / 255.0, alpha: 1);
    }
//MARK: - 单例
    class var manager : FunnyManager {
        
        struct Static {
            static var onceToken: dispatch_once_t = 0;
            static var instance: FunnyManager? = nil;
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = FunnyManager();
        }
        return Static.instance!
    }
//MARK: - 截图
    /*  全屏截图  */
    func ScreenShot(view: UIView) ->UIImage{
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0);
        let ctx=UIGraphicsGetCurrentContext();
        view.layer.renderInContext(ctx!);
        let image=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
    
    /**   部分截图   */
    func ScreenShotPart(view: UIView,rect: CGRect) ->UIImage{
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0);
        let ctx=UIGraphicsGetCurrentContext();
        view.layer.renderInContext(ctx!);
        let image=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return self.shotPart(image, rect: rect);
    }
    
    func shotPart(oldImage: UIImage,rect: CGRect) ->UIImage{
        let scale = UIScreen.mainScreen().scale;
        let frame = CGRectMake(rect.origin.x * scale, rect.origin.y * scale, rect.size.width * scale, rect.size.height * scale);
        let imageRef=oldImage.CGImage;
        let subImageRef=CGImageCreateWithImageInRect(imageRef, CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height));
        UIGraphicsBeginImageContext(frame.size);
        
        let context = UIGraphicsGetCurrentContext();
        CGContextDrawImage(context, frame, subImageRef);
        let newImage=UIImage(CGImage: subImageRef!);
        UIGraphicsEndImageContext();
        return newImage;
    }
    
    //MARK: - save-Image
    func saveImage(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil);
    }
    
    func image(image: UIImage, didFinishSavingWithError: NSError?, contextInfo: AnyObject) {
        if didFinishSavingWithError != nil {
            MBProgressHUD.showMessage("保存失败", success: false, stringColor: UIColor.redColor());
            return
        }
        MBProgressHUD.showMessage("截图成功,已保存到相册", success: true, stringColor: UIColor.redColor());
    }


}
