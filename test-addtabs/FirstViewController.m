//
//  FirstViewController.m
//  test-addtabs
//
//  Created by 祖父江亮 on 2015/04/24.
//  Copyright (c) 2015年 Ryo. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

// ページ読込開始時に
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // ステータスバーのインジケータ表示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL        *URLTORATop    = [NSURL URLWithString:@"https://tora-net.sti.chubu.ac.jp/portal/sptop.do?userId=ep14074&password=onionn27"];
    NSURLRequest *URLTORATopreq = [NSURLRequest requestWithURL:URLTORATop];
    [_toratop loadRequest: URLTORATopreq];
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
