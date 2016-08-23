//
//  DrawPictureImageView.swift
//  Funny
//
//  Created by yanzhen on 16/1/18.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

protocol DrawPictureImageViewProtocol : NSObjectProtocol{
    func drawImage(image: UIImage)
}
class DrawPictureImageView: UIView,UIGestureRecognizerDelegate {

    weak var delegate: DrawPictureImageViewProtocol?
    private var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.clipsToBounds = true;
        self.configUI();
    }
    
    func drawInPictureStart() {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.imageView.alpha = 0.3;
        }) { (finished) -> Void in
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.imageView.alpha = 1;
            }, completion: { (finished) -> Void in
                let newImage = FunnyManager.manager.ScreenShot(self);
                self.delegate?.drawImage(newImage);
                self.removeFromSuperview();
            })
        }
    }
    
    var image: UIImage! {
        didSet{
            imageView.image = image;
        }
    }
//MARK: - gesture
    private func configUI(){
        imageView = UIImageView(frame: self.bounds);
        imageView.userInteractionEnabled = true;
        self.addSubview(imageView);
        
        let pin = UIPinchGestureRecognizer(target: self, action: #selector(self.pinAction(_:)));
        pin.delegate = self;
        imageView.addGestureRecognizer(pin);
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(self.rotation(_:)));
        rotation.delegate = self;
        imageView.addGestureRecognizer(rotation);
    }
    
    
    func pinAction(pin: UIPinchGestureRecognizer) {
        imageView.transform = CGAffineTransformScale(imageView.transform, pin.scale, pin.scale);
        pin.scale = 1;
    }
    
    func rotation(rotation: UIRotationGestureRecognizer) {
        imageView.transform=CGAffineTransformRotate(imageView.transform, rotation.rotation);
        rotation.rotation = 0;
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true;
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
