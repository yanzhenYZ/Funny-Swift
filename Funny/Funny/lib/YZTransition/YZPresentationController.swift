//
//  YZPresentationController.swift
//  test
//
//  Created by yanzhen on 16/7/12.
//  Copyright © 2016年 v2tech. All rights reserved.
//

import UIKit

class YZPresentationController: UIPresentationController {

    override func presentationTransitionWillBegin() {
        self.presentedView?.frame = self.containerView!.bounds;
        self.containerView?.addSubview(self.presentedView!);
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        self.presentedView?.removeFromSuperview();
    }
}
