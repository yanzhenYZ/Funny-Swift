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
    var duration: NSTimeInterval
    var presented: Bool = false;
    
    init(type: YZTransitionType, rotation: Rotation, duration: CGFloat, presented: Bool) {
        self.type = type;
        self.rotation = rotation;
        self.duration = NSTimeInterval(duration);
        self.presented = presented;
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration;
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        switch type {
        case .System:
            self.fromTopOrBottom(false, transitionContext: transitionContext);
        case .FromTop:
            self.fromTopOrBottom(true, transitionContext: transitionContext);
        case .FromLeft:
            self.fromLeftOrRight(true, transitionContext: transitionContext);
        case .FromRight:
            self.fromLeftOrRight(false, transitionContext: transitionContext);
        default:
            self.custom(transitionContext);
        }
    }
    
    private func fromTopOrBottom(top: Bool, transitionContext: UIViewControllerContextTransitioning){
        let h: CGFloat = top ? -1 : 1;
        if presented {
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey);
            toView!.frame = CGRectMake(0, h * toView!.frame.size.height, toView!.frame.size.width, toView!.frame.size.height);
            UIView.animateWithDuration(self.duration, animations: { 
                toView!.frame = CGRectMake(0, 0, toView!.frame.size.width, toView!.frame.size.height);
                }, completion: { (finished) in
                    transitionContext.completeTransition(true);
            });
        }else{
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey);
            UIView.animateWithDuration(self.duration, animations: {
                fromView!.frame = CGRectMake(0, h * fromView!.frame.size.height, fromView!.frame.size.width, fromView!.frame.size.height);
                }, completion: { (finished) in
                    transitionContext.completeTransition(true);
            });
        }
    }
    
    private func fromLeftOrRight(left: Bool, transitionContext: UIViewControllerContextTransitioning){
        let w: CGFloat = left ? -1 : 1;
        if presented {
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey);
            toView!.frame = CGRectMake(w * toView!.frame.size.width, 0, toView!.frame.size.width, toView!.frame.size.height);
            UIView.animateWithDuration(self.duration, animations: {
                toView!.frame = CGRectMake(0, 0, toView!.frame.size.width, toView!.frame.size.height);
                }, completion: { (finished) in
                    transitionContext.completeTransition(true);
            });
        }else{
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey);
            UIView.animateWithDuration(self.duration, animations: {
                fromView!.frame = CGRectMake(w * fromView!.frame.size.width, 0, fromView!.frame.size.width, fromView!.frame.size.height);
                }, completion: { (finished) in
                    transitionContext.completeTransition(true);
            });
        }
    }
    
    private func custom(transitionContext: UIViewControllerContextTransitioning){
        if presented {
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey);
            toView!.layer.transform = CATransform3DMakeRotation(rotation.angle, rotation.x, rotation.y, rotation.z);
            UIView.animateWithDuration(self.duration, animations: {
                toView!.layer.transform = CATransform3DIdentity;
                }, completion: { (finished) in
                    transitionContext.completeTransition(true);
            });
        }else{
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey);
            UIView.animateWithDuration(self.duration, animations: {
                fromView!.layer.transform = CATransform3DMakeRotation(self.rotation.angle, self.rotation.x, self.rotation.y, self.rotation.z);
                }, completion: { (finished) in
                    transitionContext.completeTransition(true);
            });
        }
    }
}