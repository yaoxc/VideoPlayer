//
//  XCTopMenu.m
//  VideoPlayer
//
//  Created by buoumall on 2017/1/20.
//  Copyright © 2017年 buoumall. All rights reserved.
//

#import "XCTopMenu.h"

@interface XCTopMenu ()

@property (nonatomic, strong)UIButton *backButton;
@property (nonatomic, strong)UILabel *titleLabel;

@end

@implementation XCTopMenu

- (UIButton *)backButton{
    if (_backButton == nil) {
        _backButton = [[UIButton alloc] init];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(onPressBackButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    
    [self addSubview:self.backButton];
    [self addSubview:self.titleLabel];
}

- (void)setVideoTitle:(NSString *)videoTitle
{
    _videoTitle = videoTitle;
    self.titleLabel.text = videoTitle;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewHeight = self.frame.size.height;
    CGFloat btnWH = 30;
    if (self.isHideBackBtn) {
        self.backButton.frame = CGRectMake(10, (viewHeight - btnWH)*0.5 , 0, btnWH);
    }else{
        self.backButton.frame = CGRectMake(10, (viewHeight - btnWH)*0.5 , btnWH, btnWH);
    }
    
    if (self.isHideBackBtn) {
        self.titleLabel.frame = CGRectMake(10, (viewHeight - btnWH)*0.5 , 200, btnWH);
    }else{
        self.titleLabel.frame = CGRectMake(50, (viewHeight - btnWH)*0.5 , 200, btnWH);
    }
}

- (void)onPressBackButton{
    if (self.topMenuBackBtnClickBlock) {
        self.topMenuBackBtnClickBlock();
    }
}

@end
