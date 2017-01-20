//
//  BOMPlayerViewController.m
//  VideoPlayer
//
//  Created by buoumall on 2016/12/28.
//  Copyright © 2016年 buoumall. All rights reserved.
//

#import "BOMPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIDevice+XCDevice.h"

/**
 AVPlayer 切换播放源有三种方式：
 第一种：采用系统自带的方法：[self.player replaceCurrentItemWithPlayerItem:item]，但是在切换playItem前要把所有的通知，观察者移除，切换后重新添加。
 第二种：把通知，观察者全部移除，player 置为nil，然后重新创建。
 第三种可以使用AVQueuePlayer播放多个items，AVQueuePlayer是AVPlayer的子类，可以用一个数组来初始化一个AVQueuePlayer对象。代码如下：
 */

static void *PlayViewStatusObservationContext = &PlayViewStatusObservationContext;

@interface BOMPlayerViewController ()
//@property (strong, nonatomic) IBOutlet UIView *playerBGView;
//@property (strong, nonatomic) IBOutlet UIView *topView;
//@property (strong, nonatomic) IBOutlet UIView *playerContainerView;
//@property (strong, nonatomic) IBOutlet UIView *bottomView;
//
//@property (strong, nonatomic) IBOutlet UILabel *videoTitleLabel;
//@property (strong, nonatomic) IBOutlet UILabel *leftTimeLabel;
//@property (strong, nonatomic) IBOutlet UILabel *rightTimeLabel;
//
//@property (strong, nonatomic) IBOutlet UIButton *screenSwitchBtn;
//@property (strong, nonatomic) IBOutlet UIButton *backButton;
//@property (strong, nonatomic) IBOutlet UIButton *playOrPauseButton;
//
//
//@property (nonatomic, copy) NSString *videoUrlString;
//@property (nonatomic, assign) XCPlayerScreenState screenState;
//@property (nonatomic, assign) XCPlayerState state;
//@property (nonatomic, assign) BOOL isFullScreen;
//
//@property (nonatomic, strong) AVPlayer *player;
//@property (nonatomic, strong) AVPlayerLayer *playerLayer;
//@property (nonatomic, strong) AVPlayerItem *playerItem;

@end

@implementation BOMPlayerViewController


//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    self.screenState = XCPlayerScreenStatePortrait;
//    self.isFullScreen = NO;
//    
//    // 默认暂停按钮
//    [self.playOrPauseButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
//    [self.playOrPauseButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
//    
//    // 默认暂停按钮
//    [self.screenSwitchBtn setImage:[UIImage imageNamed:@"fullscreen"] forState:UIControlStateNormal];
//    [self.screenSwitchBtn setImage:[UIImage imageNamed:@"nonfullscreen"] forState:UIControlStateSelected];
//    
//    //旋转屏幕通知
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(onDeviceOrientationChange)
//                                                 name:UIDeviceOrientationDidChangeNotification
//                                               object:nil
//     ];
//}
//
//- (void)updateVideoUrlString:(NSString *)urlString
//{
//    if (urlString.length <= 0) {
//        NSLog(@"url length : %zd",urlString.length);
//        return;
//    }
//    self.videoUrlString = [urlString copy];
//    
//    self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:urlString]];
//    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
//    self.player.usesExternalPlaybackWhileExternalScreenIsActive=YES;
//    
//    AVPlayerLayer *preLayer = self.playerLayer;
//    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
//    self.playerLayer.frame = self.playerContainerView.bounds;
//    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
//    [self.playerContainerView.layer addSublayer:self.playerLayer];
//    // 移除之前的layer
//    [preLayer removeFromSuperlayer];
//    
//    self.state = XCPlayerStateBuffering;
//}
//
//
//- (void)addVideoKVO
//{
//    //KVO
//    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
//    [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
//    [_playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
//}
//- (void)removeVideoKVO {
//    [_playerItem removeObserver:self forKeyPath:@"status"];
//    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
//    [_playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
//}
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"status"]) {
//        AVPlayerItemStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
//        switch (status) {
//            case AVPlayerItemStatusReadyToPlay:
//            {
//                self.state = XCPlayerStateReadyToPlay;
//                
//                if (CMTimeGetSeconds(self.playerItem.duration)) {
//                    
//                    double _x = CMTimeGetSeconds(self.playerItem.duration);
//                    if (!isnan(_x)) {
//                       self.rightTimeLabel.text = [NSString stringWithFormat:@"%f",CMTimeGetSeconds(self.player.currentItem.duration)];
//                    }
//                }
//                
////                [self.player play];
//            }
//                break;
//            case AVPlayerItemStatusUnknown:
//            {
//                self.state = XCPlayerStateBuffering;
//            }
//                break;
//            case AVPlayerItemStatusFailed:
//            {
//                self.state = XCPlayerStateFailed;
//                NSLog(@"%@",self.playerItem.error);
//            }
//                break;
//                
//            default:
//                break;
//        }
//    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
//        
//    } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
//        
//    }
//}
//
//- (void)setVideoMaxDuration
//{
//    
//}
//
//- (BOOL)shouldAutorotate
//{
//    return NO;
//}
//
//// 设置支持的屏幕方向
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskPortrait;
//}
//
//#pragma mark - setting
//
//- (void)setPlayerItem:(AVPlayerItem *)playerItem
//{
//    if (_playerItem == playerItem) {
//        return;
//    }
//    
//    if (_playerItem) {
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
//        [self removeVideoKVO];
//    }
//    
//    _playerItem = playerItem;
//    if (_playerItem) {
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
//        // 注册观察者,观察AVPlayerItem的属性
//        [self addVideoKVO];
//    }
//}
//
///**
// *  设置播放的状态
// *  @param state WMPlayerState
// */
//- (void)setState:(XCPlayerState)state
//{
//    _state = state;
//    // 控制菊花显示、隐藏
//    if (state == XCPlayerStateBuffering) {
////        [self.loadingView startAnimating];
//        NSLog(@"AVPlayerItemStatusUnknown");
//    }else if(state == XCPlayerStatePlaying){
////        [self.loadingView stopAnimating];
//    }else if(state == XCPlayerStateReadyToPlay){
////        [self.loadingView stopAnimating];
//        NSLog(@"AVPlayerItemStatusReadyToPlay");
//    }else if(state == XCPlayerStateFailed){
//        NSLog(@"AVPlayerItemStatusFailed");
//    } else{
////        [self.loadingView stopAnimating];
//    }
//}
//
//- (void)setScreenState:(XCPlayerScreenState)screenState
//{
//    _screenState = screenState;
//    
//    switch (screenState) {
//        case XCPlayerScreenStatePortrait:
//            self.backButton.hidden = YES;
//            self.isFullScreen = NO;
//            break;
//        case XCPlayerScreenStateLandscape:
//            self.backButton.hidden = NO;
//            self.isFullScreen = YES;
//    }
//}
//
//#warning 横竖屏只需要处理这个方法了
//- (void)setIsFullScreen:(BOOL)isFullScreen
//{
//    _isFullScreen = isFullScreen;
//    if (isFullScreen) {
//        NSLog(@"to 大屏");
//        [self toFullScreen:UIInterfaceOrientationLandscapeLeft];
//    } else {
//        NSLog(@"to 小屏");
//        [self toSmallScreen];
//    }
//}
//#pragma mark - tool method
//- (void)toFullScreen:(UIInterfaceOrientation )interfaceOrientation
//{
//
//}
//
//- (void)toSmallScreen
//{
//
//}
//
//#pragma mark - 播放控制方法
//- (void)play
//{
//    [self.player play];
//}
//
//- (void)pause
//{
//    [self.player pause];
//}
//
//- (void)stop
//{
//    
//}
//
//#pragma mark - button action
//
//- (IBAction)onPressScreenSwitchBtn:(UIButton *)sender {
//    
//    sender.selected = !sender.selected;
//    if (sender.selected) {
//        self.isFullScreen = YES;
//    } else {
//        self.isFullScreen = NO;
//    }
//    
//}
//
//
//- (IBAction)onPressBackAction:(UIButton *)sender {
//    self.isFullScreen = NO;
//}
//
//
//- (IBAction)onPressPlayOrPauseButton:(UIButton *)sender {
//    sender.selected = !sender.selected;
//    if (sender.selected) {
//        [self play];
//    } else {
//        [self pause];
//    }
//    
//}
//
//#pragma mark - action
//
//- (void)moviePlayDidEnd:(NSNotification *)notice
//{
//    NSLog(@"播放完毕!");
//}
//
//- (void)onDeviceOrientationChange
//{
//    self.playerLayer.frame = self.playerContainerView.bounds;
//    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
//    switch (orientation)
//    {
//        case UIDeviceOrientationPortrait:
//            [UIDevice setOrientation:UIInterfaceOrientationPortrait];
//            self.isFullScreen = NO;
//            self.screenSwitchBtn.selected = NO;
//            self.screenState = XCPlayerScreenStatePortrait;
//            break;
//        case UIDeviceOrientationLandscapeLeft:
//            [UIDevice setOrientation:UIInterfaceOrientationLandscapeLeft];
//            self.isFullScreen = YES;
//            self.screenSwitchBtn.selected = YES;
//            self.screenState = XCPlayerScreenStateLandscape;
//            break;
//        case UIDeviceOrientationPortraitUpsideDown:
//            [UIDevice setOrientation:UIInterfaceOrientationPortraitUpsideDown];
//            self.isFullScreen = NO;
//            self.screenSwitchBtn.selected = NO;
//            self.screenState = XCPlayerScreenStatePortrait;
//            break;
//        case UIDeviceOrientationLandscapeRight:
//            [UIDevice setOrientation:UIInterfaceOrientationLandscapeRight];
//            self.isFullScreen = YES;
//            self.screenSwitchBtn.selected = YES;
//            self.screenState = XCPlayerScreenStateLandscape;
//            break;
//        default:
//            break;
//    }
//    
//    
//    
//}


@end
