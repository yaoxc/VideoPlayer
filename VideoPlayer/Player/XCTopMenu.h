//
//  XCTopMenu.h
//  VideoPlayer
//
//  Created by buoumall on 2017/1/20.
//  Copyright © 2017年 buoumall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCTopMenu : UIView

/**
 *  视频标题
 */
@property (nonatomic, copy) NSString *videoTitle;

/**
 *  隐藏返回按钮
 *  默认为NO;
 */

@property (nonatomic, assign) BOOL *isHideBackBtn;

/**
 *  返回按钮操作
 */
@property (nonatomic, copy) void(^topMenuBackBtnClickBlock)();

@end
