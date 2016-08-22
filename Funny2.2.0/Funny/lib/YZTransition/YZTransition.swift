//
//  YZTransition.swift
//  test
//
//  Created by yanzhen on 16/7/12.
//  Copyright © 2016年 v2tech. All rights reserved.
//

import UIKit

struct Rotation {
    var x: CGFloat
    var y: CGFloat
    var z: CGFloat
    var angle: CGFloat
}

enum YZTransitionType: Int {
    case System
    case FromTop
    case FromLeft
    case FromRight
    case Custom
}

class YZTransition: NSObject,UIViewControllerTransitioningDelegate {

    var rotation: Rotation! = Rotation(x: 1, y: 0, z: 0, angle: CGFloat(M_PI_2));
    var type: YZTransitionType = .System
    var duration: CGFloat = 0.53
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return YZPresentationController(presentedViewController: presented, presentingViewController: presenting);
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return YZAnimatedTransitioning(type: type, rotation: rotation, duration: duration, presented: false);
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return YZAnimatedTransitioning(type: type, rotation: rotation, duration: duration, presented: true);
    }
    
}
