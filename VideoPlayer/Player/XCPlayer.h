//
//  XCPlayer.h
//  VideoPlayer
//
//  Created by buoumall on 2017/1/20.
//  Copyright © 2017年 buoumall. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 播放状态 */
typedef NS_ENUM(NSInteger, XCPlayerState) {
    /** 播放失败 */
    XCPlayerStateFailed = -1,
    /** 缓冲中 */
    XCPlayerStateBuffering,
    /** 准备完成，可以播放*/
    XCPlayerStateReadyToPlay,
    /** 播放中 */
    XCPlayerStatePlaying,
    /** 暂停 */
    XCPlayerStateStopped,
    /** 播放完成 */
    XCPlayerStateFinished
};

typedef NS_ENUM(NSInteger, XCPlayerScreenState){
    XCPlayerScreenStatePortrait,
    XCPlayerScreenStateLandscape
};

@interface XCPlayer : UIView

- (void)updateVideoUrlString:(NSString *)urlString;

- (void)play;

- (void)pause;

- (void)stop;

@end
