//
//  DrawPicturesViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/18.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class DrawPicturesViewController: SuperSecondViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,DrawPictureImageViewProtocol{

    @IBOutlet fileprivate weak var paintView: DrawPicturePaintView!
    fileprivate var dpView: DrawPictureImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "画图";
        // Do any additional setup after loading the view.
    }
    
//MARK: - ToolBar-Action
    @IBAction func cancel(_ sender: AnyObject) {
        paintView.undo();
    }
    
    @IBAction func clear(_ sender: AnyObject) {
        paintView.clearScreen();
    }
   
    @IBAction func eraser(_ sender: AnyObject) {
        paintView.lineColor = UIColor.white;
    }
    
    @IBAction func photo(_ sender: AnyObject) {
        paintView.clearScreen();
        let imagePicker = UIImagePickerController();
        imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum;
        imagePicker.delegate = self;
        self.present(imagePicker, animated: true, completion: nil);
        paintView.clearScreen();
        
    }
    
    @IBAction func drawInPicture(_ sender: AnyObject) {
        if dpView != nil {
            dpView.drawInPictureStart();
        }
    }
    
    @IBAction func save(_ sender: AnyObject) {
        if !paintView.isDrawInView() {
            self.view.makeCenterToast("您没进行任何操作");
            return;
        }
        let image = FunnyManager.manager.ScreenShot(paintView);
        FunnyManager.manager.saveImage(image);
    }
//MARK: - delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage;
        dpView = DrawPictureImageView(frame: paintView.frame);
        dpView.delegate = self;
        dpView.image = image;
        self.view.addSubview(dpView);
        paintView.lineColor = UIColor.black;
        self.dismiss(animated: true, completion: nil);
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil);
    }
    
    func drawImage(_ image: UIImage) {
        paintView.image = image;
    }
    
//MARK: - bottomView - Action
    @IBAction func sliderChangeValue(_ sender: UISlider) {
        paintView.lineWidth = CGFloat(sender.value);
    }
    @IBAction func colorBtnClick(_ sender: UIButton) {
        paintView.lineColor = sender.backgroundColor;
    }
    
}
