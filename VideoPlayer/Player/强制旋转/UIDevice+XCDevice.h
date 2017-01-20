//
//  UIDevice+XCDevice.h
//  VideoPlayer
//
//  Created by buoumall on 2017/1/20.
//  Copyright © 2017年 buoumall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (XCDevice)
/**
 *  强制旋转设备
 *  @param  orientation 旋转方向
 */
+ (void)setOrientation:(UIInterfaceOrientation)orientation;

@end
