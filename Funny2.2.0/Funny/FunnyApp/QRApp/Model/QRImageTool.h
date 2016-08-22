//
//  QRImageTool.h
//  QRMake
//
//  Created by yanzhen on 16/1/27.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QRImageTool : NSObject
+ (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;
@end
