//
//  ViewController.m
//  VideoPlayer
//
//  Created by buoumall on 2016/12/28.
//  Copyright © 2016年 buoumall. All rights reserved.
//

#import "ViewController.h"
#import "XCPlayer.h"

@interface ViewController ()
{
    int index ;
    NSArray *paths;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    index = 0;
    paths = @[@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4",
              @"http://ohqr75btq.bkt.clouddn.com/20170103%20%E6%9D%9C%E9%9B%B7%E6%9D%A807%20%281080p%29.mp4"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    XCPlayer *player = [[XCPlayer alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 260)];
    [player updateVideoUrlString:paths[1]];
    [self.view addSubview:player];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
