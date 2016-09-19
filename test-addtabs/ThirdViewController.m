//
//  ThirdViewController.m
//  test-addtabs
//
//  Created by 祖父江亮 on 2015/04/26.
//  Copyright (c) 2015年 Ryo. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

// ページ読込開始時に
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // ステータスバーのインジケータ表示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL        *URLTimetable = [NSURL URLWithString:@"https://tora-net.sti.chubu.ac.jp/portal/kmyjikanwari.do?blockId=15000&asdpgId=15000&clearAccessData=true&targttbl=menuw&menuId=102"];
    NSURLRequest *URLTimetablereq = [NSURLRequest requestWithURL:URLTimetable];
    [_timetable loadRequest: URLTimetablereq];
}

// ページ読込完了時に
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // ステータスバーのインジケータ非表示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)goback:(UIStoryboardSegue *)segue {}

@end