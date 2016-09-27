//
//  YZAnimatedTransitioning.swift
//  test
//
//  Created by yanzhen on 16/7/12.
//  Copyright © 2016年 v2tech. All rights reserved.
//

import UIKit

class YZAnimatedTransitioning: NSObject,UIViewControllerAnimatedTransitioning {

    var rotation: Rotation!
    var type: YZTransitionType
    var duration: TimeInterval
    var presented: Bool = false;
    
    init(type: YZTransitionType, rotation: Rotation, duration: CGFloat, presented: Bool) {
        self.type = type;
        self.rotation = rotation;
        self.duration = TimeInterval(duration);
        self.presented = presented;
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration;
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch type {
        case .system:
            self.fromTopOrBottom(false, transitionContext: transitionContext);
        case .fromTop:
            self.fromTopOrBottom(true, transitionContext: transitionContext);
        case .fromLeft:
            self.fromLeftOrRight(true, transitionContext: transitionContext);
        case .fromRight:
            self.fromLeftOrRight(false, transitionContext: transitionContext);
        default:
            self.custom(transitionContext);
        }
    }
    
    fileprivate func fromTopOrBottom(_ top: Bool, transitionContext: UIViewControllerContextTransitioning){
        let h: CGFloat = top ? -1 : 1;
        if presented {
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to);
            toView!.frame = CGRect(x: 0, y: h * toView!.frame.size.height, width: toView!.frame.size.width, height: toView!.frame.size.height);
            UIView.animate(withDuration: self.duration, animations: { 
                toView!.frame = CGRect(x: 0, y: 0, width: toView!.frame.size.width, height: toView!.frame.size.height);
                }, completion: { (finished) in
                    transitionContext.completeTransition(true);
            });
        }else{
            let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from);
            UIView.animate(withDuration: self.duration, animations: {
                fromView!.frame = CGRect(x: 0, y: h * fromView!.frame.size.height, width: fromView!.frame.size.width, height: fromView!.frame.size.height);
                }, completion: { (finished) in
                    transitionContext.completeTransition(true);
            });
        }
    }
    
    fileprivate func fromLeftOrRight(_ left: Bool, transitionContext: UIViewControllerContextTransitioning){
        let w: CGFloat = left ? -1 : 1;
        if presented {
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to);
            toView!.frame = CGRect(x: w * toView!.frame.size.width, y: 0, width: toView!.frame.size.width, height: toView!.frame.size.height);
            UIView.animate(withDuration: self.duration, animations: {
                toView!.frame = CGRect(x: 0, y: 0, width: toView!.frame.size.width, height: toView!.frame.size.height);
                }, completion: { (finished) in
                    transitionContext.completeTransition(true);
            });
        }else{
            let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from);
            UIView.animate(withDuration: self.duration, animations: {
                fromView!.frame = CGRect(x: w * fromView!.frame.size.width, y: 0, width: fromView!.frame.size.width, height: fromView!.frame.size.height);
                }, completion: { (finished) in
                    transitionContext.completeTransition(true);
            });
        }
    }
    
    fileprivate func custom(_ transitionContext: UIViewControllerContextTransitioning){
        if presented {
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to);
            toView!.layer.transform = CATransform3DMakeRotation(rotation.angle, rotation.x, rotation.y, rotation.z);
            UIView.animate(withDuration: self.duration, animations: {
                toView!.layer.transform = CATransform3DIdentity;
                }, completion: { (finished) in
                    transitionContext.completeTransition(true);
            });
        }else{
            let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from);
            UIView.animate(withDuration: self.duration, animations: {
                fromView!.layer.transform = CATransform3DMakeRotation(self.rotation.angle, self.rotation.x, self.rotation.y, self.rotation.z);
                }, completion: { (finished) in
                    transitionContext.completeTransition(true);
            });
        }
    }
}
