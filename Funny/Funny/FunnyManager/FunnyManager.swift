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
    
    func fileSize(_ filePath: String) ->Int {
        var fileSize: Int = 0;
        let fileManager = FileManager.default;
        var isDir = ObjCBool(false);
        let exist = fileManager.fileExists(atPath: filePath, isDirectory: &isDir);
        if exist {
            if isDir.boolValue {
                let subPaths = fileManager.subpaths(atPath: filePath);
                for (_,value) in subPaths!.enumerated() {
                    let path = filePath + "/" + value;
                    var isDirectory = ObjCBool(false);
                    fileManager.fileExists(atPath: path, isDirectory: &isDirectory);
                    if !isDirectory.boolValue{
                        let size = try! fileManager.attributesOfItem(atPath: path)[FileAttributeKey.size] as! NSNumber;
                        fileSize += size.intValue;
                    }
                }
                
            }else{
                let size = try! fileManager.attributesOfItem(atPath: filePath)[FileAttributeKey.size] as! NSNumber;
                fileSize = size.intValue;
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
        let exist = FileManager.default.fileExists(atPath: cachePath);
        if exist {
            do {
                try FileManager.default.removeItem(atPath: cachePath)
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
    func LabelSize(_ text: String, width: CGFloat, font: CGFloat) ->CGSize {
        
        let oldSize = CGSize(width: width, height: 9999.0);
        let newSize = text.boundingRect(with: oldSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: font)], context: nil).size;
        return newSize;
    }

//MARK: - date
    func dateWithTimeInterval(_ time: Int32) ->String {
        
        let date = Date(timeIntervalSince1970: Double(time));
        let format = DateFormatter();
        format.dateFormat = "yyyy-MM-dd HH:mm:ss";
        return format.string(from: date);
    }
    
    func currentTime() ->String {
        let currentTime = Date().timeIntervalSince1970;
        let intTime = Int32(currentTime);
        return String(intTime);
    }
    
    func timeIntervalWithDateString(_ dateString: String) ->NSNumber {
        let f = DateFormatter();
        f.dateFormat = "yyyy-MM-dd HH:mm:ss";
        let date = f.date(from: dateString);
        let time = date?.timeIntervalSince1970;
        return NSNumber(value: Int32(time!) as Int32);
    }
//MARK: - 网址判断
    /**       判断是不是网址           */
    func isNetURL(_ str: String) ->Bool {
        var url: String!
        if !str.hasPrefix("http://") {
            url = "http://" + str;
        }else{
            url = str;
        }
        let range = url.range(of: "^http://([\\w-]+\\.)+[\\w-]+[\\w:]+(/[\\w-./?%&=]*)?$", options: NSString.CompareOptions.regularExpression, range: nil, locale: nil);
        if range != nil {
            if !range!.isEmpty {
                return true;
            }
        }
        
        return false;
    }

    /**  圆   */
    func cornerRadian(_ view: UIView) {
        view.layer.masksToBounds = true;
        view.layer.cornerRadius = view.frame.size.width / 2;
    }
    
//MARK: - color
    func color(_ R: CGFloat,G: CGFloat,B: CGFloat) ->UIColor {
        return UIColor(red: R / 255.0, green: G / 255.0, blue: B / 255.0, alpha: 1);
    }
//MARK: - 单例
    struct Static {
        static var onceToken: Int = 0;
        static var instance: FunnyManager? = nil;
    }
    
    private static var __once: () = {
        Static.instance = FunnyManager();
    }()
    
    class var manager : FunnyManager {
        
        _ = FunnyManager.__once
        return Static.instance!
    }
//MARK: - 截图
    /*  全屏截图  */
    func ScreenShot(_ view: UIView) ->UIImage{
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0);
        let ctx=UIGraphicsGetCurrentContext();
        view.layer.render(in: ctx!);
        let image=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!;
    }
    
    /**   部分截图   */
    func ScreenShotPart(_ view: UIView,rect: CGRect) ->UIImage{
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0);
        let ctx=UIGraphicsGetCurrentContext();
        view.layer.render(in: ctx!);
        let image=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return self.shotPart(image!, rect: rect);
    }
    
    func shotPart(_ oldImage: UIImage,rect: CGRect) ->UIImage{
        let scale = UIScreen.main.scale;
        let frame = CGRect(x: rect.origin.x * scale, y: rect.origin.y * scale, width: rect.size.width * scale, height: rect.size.height * scale);
        let imageRef=oldImage.cgImage;
        let subImageRef=imageRef?.cropping(to: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height));
        UIGraphicsBeginImageContext(frame.size);
        
        let context = UIGraphicsGetCurrentContext();
        context?.draw(subImageRef!, in: frame);
        let newImage=UIImage(cgImage: subImageRef!);
        UIGraphicsEndImageContext();
        return newImage;
    }
    
    //MARK: - save-Image
    func saveImage(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil);
    }
    
    func image(_ image: UIImage, didFinishSavingWithError: NSError?, contextInfo: AnyObject) {
        if didFinishSavingWithError != nil {
            MBProgressHUD.showMessage("保存失败", success: false, stringColor: UIColor.red);
            return
        }
        MBProgressHUD.showMessage("截图成功,已保存到相册", success: true, stringColor: UIColor.red);
    }


}
