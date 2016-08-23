//
//  QRMakeViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/21.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class QRMakeViewController: UIViewController,UITextViewDelegate {

    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var QRImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.textView.resignFirstResponder();
    }
  
    @IBAction func QRMake(sender: AnyObject) {
        if textView.text.isEmpty {
            return;
        }
        textView.resignFirstResponder();
        self.startMakeQR(textView.text);
    }
    
    
    private func startMakeQR(string: String) {
        let filter: CIFilter = CIFilter(name: "CIQRCodeGenerator")!;
        filter.setDefaults();
        
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true);
        filter.setValue(data, forKey: "inputMessage");
        filter.setValue("H", forKey: "inputCorrectionLevel");
        
        let outImage = filter.outputImage;
        let image1 = self.createNonInterpolatedUIImageFormCIImage(outImage!, size: QRImageView.width);
        let image2 = QRImageTool.imageBlackToTransparent(image1, withRed: 0.0, andGreen: 99.0, andBlue: 251.0);
        QRImageView.image = image2;
        
    }
    
    private func createNonInterpolatedUIImageFormCIImage(image: CIImage, size:CGFloat) ->UIImage{
        let extent = CGRectIntegral(image.extent);
        let scale  = min(size / CGRectGetWidth(extent), size / CGRectGetHeight(extent));
        let width  = CGRectGetWidth(extent) * scale;
        let height = CGRectGetHeight(extent) * scale;
        
        let cs = CGColorSpaceCreateDeviceGray();
        let bitmapRef = CGBitmapContextCreate(nil, Int(width), Int(height), 8, 0, cs, UInt32(0));
        let context = CIContext(options: nil);
        let bitmapImage = context.createCGImage(image, fromRect: extent);
        CGContextSetInterpolationQuality(bitmapRef, CGInterpolationQuality.None);
        CGContextScaleCTM(bitmapRef, scale, scale);
        CGContextDrawImage(bitmapRef, extent, bitmapImage);
        let scaledImage = CGBitmapContextCreateImage(bitmapRef);
        
        return UIImage(CGImage: scaledImage!);
        
    }
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder();
            return false;
        }
        return true;
    }
}
