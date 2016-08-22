//
//  QRStartScanViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/21.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit
import AVFoundation

class QRStartScanViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    var isFromWindow: Bool = false
    var scanVC: QRScanningViewController!
    var session: AVCaptureSession!
    @IBOutlet weak var scanImageView: UIImageView!
    var lineImageView: UIImageView!
    var timer: NSTimer!
    var upOrDown: Bool = false;
    var num: Int! = 0
    
    init(isFromWindow: Bool){
        super.init(nibName: "QRStartScanViewController", bundle: nil);
        self.isFromWindow = isFromWindow;
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.startScanning();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lineImageView = UIImageView(frame: CGRectMake(0, 0, 220, 2));
        lineImageView.center = CGPointMake(WIDTH / 2, scanImageView.y);
        lineImageView.image = UIImage(named: "line");
        self.view.addSubview(lineImageView);
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(self.lineMove), userInfo: nil, repeats: true);
        
        
    }

    func lineMove() {
        if !upOrDown {
            num = num + 1;
            lineImageView.frame = CGRectMake(lineImageView.x, scanImageView.y + 2.0 * CGFloat(num), 220.0, 2.0);
            if 2 * num == 300 {
                upOrDown = true;
            }
        } else {
            num = num - 1;
            lineImageView.frame = CGRectMake(lineImageView.x, scanImageView.y + 2.0 * CGFloat(num), 220.0, 2.0);
            if 2 * num == 0 {
                upOrDown = false;
            }
        }
    }
    
    
    
    private func startScanning() {
        
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo);
        
        let input = try! AVCaptureDeviceInput.init(device: device);
        let outPut = AVCaptureMetadataOutput();
        outPut.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue());
        
        session = AVCaptureSession();
        session.sessionPreset = AVCaptureSessionPresetHigh;
        if session.canAddInput(input) {
            session.addInput(input);
        }
        if session.canAddOutput(outPut) {
            session.addOutput(outPut);
        }
        
        outPut.metadataObjectTypes = [AVMetadataObjectTypeQRCode];
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session);
        previewLayer.frame = CGRectMake(10, 10, 280, 280);
        //scanImageView.layer.insertSublayer(previewLayer, atIndex: 0);
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        previewLayer.backgroundColor = UIColor.redColor().CGColor;
        
        print(scanImageView.frame)
        scanImageView.layer.addSublayer(previewLayer);
        
        session.startRunning();
    }
    
//MARK: - delegate
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        if metadataObjects.count > 0 {
            let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject;
            if isFromWindow {
                if FunnyManager.manager.isNetURL(metadataObject.stringValue) {
                    UIApplication.sharedApplication().openURL(NSURL(string: metadataObject.stringValue)!);
                }else{
                    self.session.stopRunning();
                    self.timer.invalidate();
                    let alert = UIAlertController(title: "扫描结果", message: metadataObject.stringValue, preferredStyle: UIAlertControllerStyle.Alert);
                    let cancel = UIAlertAction(title: "确定", style: UIAlertActionStyle.Cancel, handler: { (cancel) in
                        self.dismissViewControllerAnimated(true, completion: nil);
                    });
                    alert.addAction(cancel);
                    self.presentViewController(alert, animated: true, completion: nil);
                    return;
                }
            }else{
                scanVC.scanningDone(metadataObject.stringValue);
            }
        }
        
        session.stopRunning();
        timer.invalidate();
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            self.timer.invalidate();
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
