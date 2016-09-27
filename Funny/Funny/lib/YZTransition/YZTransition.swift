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
    case system
    case fromTop
    case fromLeft
    case fromRight
    case custom
}

class YZTransition: NSObject,UIViewControllerTransitioningDelegate {

    var rotation: Rotation! = Rotation(x: 1, y: 0, z: 0, angle: CGFloat(M_PI_2));
    var type: YZTransitionType = .system
    var duration: CGFloat = 0.53
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return YZPresentationController(presentedViewController: presented, presenting: presenting);
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return YZAnimatedTransitioning(type: type, rotation: rotation, duration: duration, presented: false);
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return YZAnimatedTransitioning(type: type, rotation: rotation, duration: duration, presented: true);
    }
    
}
