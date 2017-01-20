//
//  XCBottomMenu.h
//  VideoPlayer
//
//  Created by buoumall on 2017/1/20.
//  Copyright © 2017年 buoumall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCBottomMenu : UIView

@property (readwrite)BOOL isFullScreen;

@property (nonatomic, copy) void (^didClickPlayOrPauseBtnBlock)(BOOL isPlay);
@property (nonatomic, copy) void (^didClickNextBtnBlock)();
@property (nonatomic, copy) void (^didClickFullOrSmallBtnBlock)(BOOL isFullScreen);
@property (nonatomic, copy) void (^didSliderValueChangingBlock)(CGFloat value); // 拖动中
@property (nonatomic, copy) void (^didSliderValueChangedBlock)(CGFloat value); // 拖动完成


@end
