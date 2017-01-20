//
//  XCBottomMenu.m
//  VideoPlayer
//
//  Created by buoumall on 2017/1/20.
//  Copyright © 2017年 buoumall. All rights reserved.
//

#import "XCBottomMenu.h"
#import "UIView+SCYCategory.h"
#import "SCYLayerAddition.h"

@interface XCBottomMenu ()
{
    BOOL isPlay;
    BOOL isHour;
}

@property (nonatomic, strong)UIButton *playOrPauseBtn;//播放/暂停
@property (nonatomic, strong) UIButton *nextPlayerBtn;//下一个视屏（全屏时有）
@property (nonatomic, strong) UIProgressView *loadProgressView;//缓冲进度条
@property (nonatomic, strong) UISlider *playSlider;//播放滑动条
@property (nonatomic, strong) UILabel *timeLabel;//时间标签
@property (nonatomic, strong) UIButton *fullOrSmallBtn;//放大/缩小按钮

@end

@implementation XCBottomMenu

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    [self addSubview:self.playOrPauseBtn];
    [self addSubview:self.nextPlayerBtn];
    [self addSubview:self.loadProgressView];
    [self addSubview:self.playSlider];
    [self addSubview:self.timeLabel];
    [self addSubview:self.fullOrSmallBtn];
}

- (UIButton *)playOrPauseBtn{
    if (_playOrPauseBtn == nil) {
        _playOrPauseBtn = [[UIButton alloc] init];
        [_playOrPauseBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [_playOrPauseBtn addTarget:self action:@selector(playOrPauseAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playOrPauseBtn;
}

- (UIButton *)nextPlayerBtn{
    if (_nextPlayerBtn == nil) {
        _nextPlayerBtn = [[UIButton alloc] init];
        [_nextPlayerBtn setImage:[UIImage imageNamed:@"button_forward"] forState:UIControlStateNormal];
        [_nextPlayerBtn addTarget:self action:@selector(nextPlayerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextPlayerBtn;
}

- (UIProgressView *)loadProgressView{
    if (_loadProgressView == nil) {
        _loadProgressView = [[UIProgressView alloc] init];
    }
    return _loadProgressView;
}

- (UISlider *)playSlider{
    if (_playSlider == nil) {
        _playSlider = [[UISlider alloc] init];
        _playSlider.minimumValue = 0.0;
        
        UIGraphicsBeginImageContextWithOptions((CGSize){1,1}, NO, 0.0f);
        UIImage *transparentImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self.playSlider setThumbImage:[UIImage imageNamed:@"icon_progress"] forState:UIControlStateNormal];
        [self.playSlider setMinimumTrackImage:transparentImage forState:UIControlStateNormal];
        [self.playSlider setMaximumTrackImage:transparentImage forState:UIControlStateNormal];
        
        [_playSlider addTarget:self action:@selector(playSliderValueChanging:) forControlEvents:UIControlEventValueChanged];
        [_playSlider addTarget:self action:@selector(playSliderValueDidChanged:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playSlider;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:11.0];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.text = @"00:00:00/00:00:00";
    }
    return _timeLabel;
}

- (UIButton *)fullOrSmallBtn{
    if (_fullOrSmallBtn == nil) {
        _fullOrSmallBtn = [[UIButton alloc] init];
        [_fullOrSmallBtn setImage:[UIImage imageNamed:@"tobig"] forState:UIControlStateNormal];
        [_fullOrSmallBtn addTarget:self action:@selector(fullOrSmallAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullOrSmallBtn;
}

#pragma mark - actions
//开始/暂停
- (void)playOrPauseAction{
    if (isPlay) {
        isPlay = NO;
        [self.playOrPauseBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }else{
        isPlay = YES;
        [self.playOrPauseBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }
    
    if (self.didClickPlayOrPauseBtnBlock) {
        self.didClickPlayOrPauseBtnBlock(isPlay);
    }
}

//下一个
- (void)nextPlayerAction{
    if (self.didClickNextBtnBlock) {
        self.didClickNextBtnBlock();
    }
}

//放大/缩小
- (void)fullOrSmallAction{
    if (self.isFullScreen) {
        self.isFullScreen = NO;
    }else{
        self.isFullScreen = YES;
    }
    if (self.didClickFullOrSmallBtnBlock) {
        self.didClickFullOrSmallBtnBlock(self.isFullScreen);
    }
}

//slider拖动时
- (void)playSliderValueChanging:(id)sender{
    isPlay = NO;
    UISlider *slider = (UISlider*)sender;
    if (self.didSliderValueChangingBlock) {
        self.didSliderValueChangingBlock(slider.value);
    }
}

//slider完成拖动时
- (void)playSliderValueDidChanged:(id)sender{
    UISlider *slider = (UISlider*)sender;
    if (self.didSliderValueChangedBlock) {
        self.didSliderValueChangedBlock(slider.value);
    }
    [self playOrPauseAction];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.playOrPauseBtn.frame = CGRectMake(self.left+5, 8, 36, 23);
    if (self.isFullScreen) {
        self.nextPlayerBtn.frame = CGRectMake(self.playOrPauseBtn.right, 5, 30, 30);
        [_fullOrSmallBtn setImage:[UIImage imageNamed:@"small"] forState:UIControlStateNormal];
    }else{
        self.nextPlayerBtn.frame = CGRectMake(self.playOrPauseBtn.right+5, 5, 0, 0);
        [_fullOrSmallBtn setImage:[UIImage imageNamed:@"big"] forState:UIControlStateNormal];
    }
    self.fullOrSmallBtn.frame = CGRectMake(self.width-35, 0, 35, self.height);
    self.timeLabel.frame = CGRectMake(self.fullOrSmallBtn.left-108, 10, 108, 20);
    self.loadProgressView.frame = CGRectMake(self.playOrPauseBtn.right+self.nextPlayerBtn.width+7, 20,self.timeLabel.left-self.playOrPauseBtn.right-self.nextPlayerBtn.width-14, 31);
    self.playSlider.frame = CGRectMake(self.playOrPauseBtn.right+self.nextPlayerBtn.width+5, 5, self.loadProgressView.width+4, 31);
}

#pragma mark - tool
//定义视屏时长样式
- (NSString *)xjPlayerTimeStyle:(CGFloat)time{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (time/3600>1) {
        isHour = YES;
        [formatter setDateFormat:@"HH:mm:ss"];
    }else{
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showTimeStyle = [formatter stringFromDate:date];
    return showTimeStyle;
}




@end
