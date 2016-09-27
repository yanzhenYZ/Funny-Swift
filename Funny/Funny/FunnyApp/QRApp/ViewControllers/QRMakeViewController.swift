//
//  QRMakeViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/21.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class QRMakeViewController: UIViewController,UITextViewDelegate {

    @IBOutlet fileprivate weak var textView: UITextView!
    @IBOutlet fileprivate weak var QRImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textView.resignFirstResponder();
    }
  
    @IBAction func QRMake(_ sender: AnyObject) {
        if textView.text.isEmpty {
            return;
        }
        textView.resignFirstResponder();
        self.startMakeQR(textView.text);
    }
    
    
    fileprivate func startMakeQR(_ string: String) {
        let filter: CIFilter = CIFilter(name: "CIQRCodeGenerator")!;
        filter.setDefaults();
        
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true);
        filter.setValue(data, forKey: "inputMessage");
        filter.setValue("H", forKey: "inputCorrectionLevel");
        
        let outImage = filter.outputImage;
        let image1 = self.createNonInterpolatedUIImageFormCIImage(outImage!, size: QRImageView.width);
        let image2 = QRImageTool.imageBlack(toTransparent: image1, withRed: 0.0, andGreen: 99.0, andBlue: 251.0);
        QRImageView.image = image2;
        
    }
    
    fileprivate func createNonInterpolatedUIImageFormCIImage(_ image: CIImage, size:CGFloat) ->UIImage{
        let extent = image.extent.integral;
        let scale  = min(size / extent.width, size / extent.height);
        let width  = extent.width * scale;
        let height = extent.height * scale;
        
        let cs = CGColorSpaceCreateDeviceGray();
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: UInt32(0));
        let context = CIContext(options: nil);
        let bitmapImage = context.createCGImage(image, from: extent);
        bitmapRef!.interpolationQuality = CGInterpolationQuality.none;
        bitmapRef?.scaleBy(x: scale, y: scale);
        bitmapRef?.draw(bitmapImage!, in: extent);
        let scaledImage = bitmapRef?.makeImage();
        
        return UIImage(cgImage: scaledImage!);
        
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder();
            return false;
        }
        return true;
    }
}
