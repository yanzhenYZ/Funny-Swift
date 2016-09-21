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
    fileprivate var session: AVCaptureSession!
    @IBOutlet fileprivate weak var scanImageView: UIImageView!
    fileprivate var lineImageView: UIImageView!
    fileprivate var timer: Timer!
    fileprivate var upOrDown: Bool = false;
    fileprivate var num: Int! = 0
    
    init(isFromWindow: Bool){
        super.init(nibName: "QRStartScanViewController", bundle: nil);
        self.isFromWindow = isFromWindow;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.startScanning();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lineImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 220, height: 2));
        lineImageView.center = CGPoint(x: WIDTH / 2, y: scanImageView.y);
        lineImageView.image = UIImage(named: "line");
        self.view.addSubview(lineImageView);
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.lineMove), userInfo: nil, repeats: true);
        
        
    }

    func lineMove() {
        if !upOrDown {
            num = num + 1;
            lineImageView.frame = CGRect(x: lineImageView.x, y: scanImageView.y + 2.0 * CGFloat(num), width: 220.0, height: 2.0);
            if 2 * num == 300 {
                upOrDown = true;
            }
        } else {
            num = num - 1;
            lineImageView.frame = CGRect(x: lineImageView.x, y: scanImageView.y + 2.0 * CGFloat(num), width: 220.0, height: 2.0);
            if 2 * num == 0 {
                upOrDown = false;
            }
        }
    }
    
    
    
    fileprivate func startScanning() {
        
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo);
        
        let input = try! AVCaptureDeviceInput.init(device: device);
        let outPut = AVCaptureMetadataOutput();
        outPut.setMetadataObjectsDelegate(self, queue: DispatchQueue.main);
        
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
        previewLayer?.frame = CGRect(x: 10, y: 10, width: 280, height: 280);
        //scanImageView.layer.insertSublayer(previewLayer, atIndex: 0);
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill;
        previewLayer?.backgroundColor = UIColor.red.cgColor;
        
        print(scanImageView.frame)
        scanImageView.layer.addSublayer(previewLayer!);
        
        session.startRunning();
    }
    
//MARK: - delegate
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        if metadataObjects.count > 0 {
            let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject;
            if isFromWindow {
                if FunnyManager.manager.isNetURL(metadataObject.stringValue) {
                    UIApplication.shared.openURL(URL(string: metadataObject.stringValue)!);
                }else{
                    self.session.stopRunning();
                    self.timer.invalidate();
                    let alert = UIAlertController(title: "扫描结果", message: metadataObject.stringValue, preferredStyle: UIAlertControllerStyle.alert);
                    let cancel = UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel, handler: { (cancel) in
                        self.dismiss(animated: true, completion: nil);
                    });
                    alert.addAction(cancel);
                    self.present(alert, animated: true, completion: nil);
                    return;
                }
            }else{
                scanVC.scanningDone(metadataObject.stringValue);
            }
        }
        
        session.stopRunning();
        timer.invalidate();
        self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func cancel(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: { () -> Void in
            self.timer.invalidate();
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
