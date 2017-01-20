//
//  XCPlayer.m
//  VideoPlayer
//
//  Created by buoumall on 2017/1/20.
//  Copyright © 2017年 buoumall. All rights reserved.
//

#import "XCPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface XCPlayer ()

@property (nonatomic, copy) NSString *videoUrlString;
@property (nonatomic, assign) XCPlayerScreenState screenState;
@property (nonatomic, assign) XCPlayerState state;
@property (nonatomic, assign) BOOL isFullScreen;

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayerItem *playerItem;

@end

@implementation XCPlayer

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:) name:UIDeviceOrientationDidChangeNotification object:nil];//注册监听，屏幕方向改变
    }
    return self;
}

- (void)updateVideoUrlString:(NSString *)urlString
{
    if (urlString.length <= 0) {
        NSLog(@"url length : %zd",urlString.length);
        return;
    }
    self.videoUrlString = [urlString copy];

    self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:urlString]];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.player.usesExternalPlaybackWhileExternalScreenIsActive=YES;

    AVPlayerLayer *preLayer = self.playerLayer;
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = self.bounds;
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.layer addSublayer:self.playerLayer];
    // 移除之前的layer
    [preLayer removeFromSuperlayer];

    self.state = XCPlayerStateBuffering;
}


- (void)addVideoKVO
{
    //KVO
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [_playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)removeVideoKVO {
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [_playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        switch (status) {
            case AVPlayerItemStatusReadyToPlay:
            {
                self.state = XCPlayerStateReadyToPlay;

                if (CMTimeGetSeconds(self.playerItem.duration)) {

                    double _x = CMTimeGetSeconds(self.playerItem.duration);
                    if (!isnan(_x)) {
//                       self.rightTimeLabel.text = [NSString stringWithFormat:@"%f",CMTimeGetSeconds(self.player.currentItem.duration)];
                    }
                }

                [self.player play];
            }
                break;
            case AVPlayerItemStatusUnknown:
            {
                self.state = XCPlayerStateBuffering;
            }
                break;
            case AVPlayerItemStatusFailed:
            {
                self.state = XCPlayerStateFailed;
                NSLog(@"%@",self.playerItem.error);
            }
                break;

            default:
                break;
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {

    } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {

    }
}

#pragma mark - setting

- (void)setPlayerItem:(AVPlayerItem *)playerItem
{
    if (_playerItem == playerItem) {
        return;
    }

    if (_playerItem) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
        [self removeVideoKVO];
    }

    _playerItem = playerItem;
    if (_playerItem) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
        // 注册观察者,观察AVPlayerItem的属性
        [self addVideoKVO];
    }
}

/**
 *  设置播放的状态
 *  @param state WMPlayerState
 */
- (void)setState:(XCPlayerState)state
{
    _state = state;
    // 控制菊花显示、隐藏
    if (state == XCPlayerStateBuffering) {
//        [self.loadingView startAnimating];
        NSLog(@"AVPlayerItemStatusUnknown");
    }else if(state == XCPlayerStatePlaying){
//        [self.loadingView stopAnimating];
    }else if(state == XCPlayerStateReadyToPlay){
//        [self.loadingView stopAnimating];
        NSLog(@"AVPlayerItemStatusReadyToPlay");
    }else if(state == XCPlayerStateFailed){
        NSLog(@"AVPlayerItemStatusFailed");
    } else{
//        [self.loadingView stopAnimating];
    }
}

- (void)setScreenState:(XCPlayerScreenState)screenState
{
    _screenState = screenState;

    switch (screenState) {
        case XCPlayerScreenStatePortrait:
            self.isFullScreen = NO;
            break;
        case XCPlayerScreenStateLandscape:
            self.isFullScreen = YES;
    }
}

#warning 横竖屏只需要处理这个方法了
- (void)setIsFullScreen:(BOOL)isFullScreen
{
    _isFullScreen = isFullScreen;
    if (isFullScreen) {
        NSLog(@"to 大屏");
        [self toFullScreen:UIInterfaceOrientationLandscapeLeft];
    } else {
        NSLog(@"to 小屏");
        [self toSmallScreen];
    }
}
#pragma mark - tool method
- (void)toFullScreen:(UIInterfaceOrientation )interfaceOrientation
{

}

- (void)toSmallScreen
{

}

#pragma mark - 播放控制方法
- (void)play
{
    [self.player play];
}

- (void)pause
{
    [self.player pause];
}

- (void)stop
{

}

- (void)orientChange:(NSNotification *)notice
{
    
}

@end
