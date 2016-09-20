//
//  SecondViewController.m
//  test-addtabs
//
//  Created by 祖父江亮 on 2015/04/24.
//  Copyright (c) 2015年 Ryo. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    学内地図（ピンが落ちていない）を表示
    NSString     *path2    = [[NSBundle mainBundle] pathForResource:@"map" ofType:@"pdf"];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path2]];
    
    [self.mapview loadRequest:request2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end