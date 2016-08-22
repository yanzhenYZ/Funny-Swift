//
//  DrawPicturesViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/18.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class DrawPicturesViewController: SuperSecondViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,DrawPictureImageViewProtocol{

    @IBOutlet weak var paintView: DrawPicturePaintView!
    var dpView: DrawPictureImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "画图";
        // Do any additional setup after loading the view.
    }
    
//MARK: - ToolBar-Action
    @IBAction func cancel(sender: AnyObject) {
        paintView.undo();
    }
    
    @IBAction func clear(sender: AnyObject) {
        paintView.clearScreen();
    }
   
    @IBAction func eraser(sender: AnyObject) {
        paintView.lineColor = UIColor.whiteColor();
    }
    
    @IBAction func photo(sender: AnyObject) {
        paintView.clearScreen();
        let imagePicker = UIImagePickerController();
        imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
        imagePicker.delegate = self;
        self.presentViewController(imagePicker, animated: true, completion: nil);
        paintView.clearScreen();
        
    }
    
    @IBAction func drawInPicture(sender: AnyObject) {
        if dpView != nil {
            dpView.drawInPictureStart();
        }
    }
    
    @IBAction func save(sender: AnyObject) {
        if !paintView.isDrawInView() {
            self.view.makeCenterToast("您没进行任何操作");
            return;
        }
        let image = FunnyManager.manager.ScreenShot(paintView);
        FunnyManager.manager.saveImage(image);
    }
//MARK: - delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage;
        dpView = DrawPictureImageView(frame: paintView.frame);
        dpView.delegate = self;
        dpView.image = image;
        self.view.addSubview(dpView);
        paintView.lineColor = UIColor.blackColor();
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func drawImage(image: UIImage) {
        paintView.image = image;
    }
    
//MARK: - bottomView - Action
    @IBAction func sliderChangeValue(sender: UISlider) {
        paintView.lineWidth = CGFloat(sender.value);
    }
    @IBAction func colorBtnClick(sender: UIButton) {
        paintView.lineColor = sender.backgroundColor;
    }
    
}
