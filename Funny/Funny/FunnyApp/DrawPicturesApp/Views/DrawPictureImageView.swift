//
//  DrawPictureImageView.swift
//  Funny
//
//  Created by yanzhen on 16/1/18.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

protocol DrawPictureImageViewProtocol : NSObjectProtocol{
    func drawImage(_ image: UIImage)
}
class DrawPictureImageView: UIView,UIGestureRecognizerDelegate {

    weak var delegate: DrawPictureImageViewProtocol?
    fileprivate var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.clipsToBounds = true;
        self.configUI();
    }
    
    func drawInPictureStart() {
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.imageView.alpha = 0.3;
        }, completion: { (finished) -> Void in
            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                self.imageView.alpha = 1;
            }, completion: { (finished) -> Void in
                let newImage = FunnyManager.manager.ScreenShot(self);
                self.delegate?.drawImage(newImage);
                self.removeFromSuperview();
            })
        }) 
    }
    
    var image: UIImage! {
        didSet{
            imageView.image = image;
        }
    }
//MARK: - gesture
    fileprivate func configUI(){
        imageView = UIImageView(frame: self.bounds);
        imageView.isUserInteractionEnabled = true;
        self.addSubview(imageView);
        
        let pin = UIPinchGestureRecognizer(target: self, action: #selector(self.pinAction(_:)));
        pin.delegate = self;
        imageView.addGestureRecognizer(pin);
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(self.rotation(_:)));
        rotation.delegate = self;
        imageView.addGestureRecognizer(rotation);
    }
    
    
    func pinAction(_ pin: UIPinchGestureRecognizer) {
        imageView.transform = imageView.transform.scaledBy(x: pin.scale, y: pin.scale);
        pin.scale = 1;
    }
    
    func rotation(_ rotation: UIRotationGestureRecognizer) {
        imageView.transform=imageView.transform.rotated(by: rotation.rotation);
        rotation.rotation = 0;
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true;
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
