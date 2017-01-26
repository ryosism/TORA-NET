//
//  FifthViewController.m
//  test-addtabs
//
//  Created by 祖父江亮 on 2015/04/26.
//  Copyright (c) 2015年 Ryo. All rights reserved.
//

#import "FifthViewController.h"

@interface FifthViewController ()

@end

@implementation FifthViewController

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // ステータスバーのインジケータ表示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL        *devTop    = [NSURL URLWithString:@"http://cupkentorabomiledevteam.blogspot.jp/2015/07/blog-post.html"];
    NSURLRequest *URLdevreq = [NSURLRequest requestWithURL:devTop];
    [_devblog loadRequest: URLdevreq];
    

    NSURL        *icons8    = [NSURL URLWithString:@"http://icons8.com/"];
    NSURLRequest *icons8req = [NSURLRequest requestWithURL:icons8];
    [_icons8 loadRequest: icons8req];
    
    
    NSURL        *issues    = [NSURL URLWithString:@"http://cupkentorabomiledevteam.blogspot.jp/2015/04/blog-post_29.html"];
    NSURLRequest *issuesreq = [NSURLRequest requestWithURL:issues];
    [_issues loadRequest: issuesreq];
    
    
    NSURL        *updates    = [NSURL URLWithString:@"http://cupkentorabomiledevteam.blogspot.jp/2015/04/blog-post_22.html"];
    NSURLRequest *updatesreq = [NSURLRequest requestWithURL:updates];
    [_updates loadRequest: updatesreq];
    
    NSURL        *opac    = [NSURL URLWithString:@"http://opac.bliss.chubu.ac.jp/mobileopac/"];
    NSURLRequest *opacreq = [NSURLRequest requestWithURL:opac];
    [_opac loadRequest: opacreq];
    
    NSURL        *e_hon    = [NSURL URLWithString:@"http://www.e-hon.ne.jp"];
    NSURLRequest *e_honreq = [NSURLRequest requestWithURL:e_hon];
    [_e_hon loadRequest: e_honreq];
    
    NSURL        *e_honregister    = [NSURL URLWithString:@"http://www.e-hon.ne.jp/bec/SHOP53825"];
    NSURLRequest *e_honregisterreq = [NSURLRequest requestWithURL:e_honregister];
    [_e_honregister loadRequest: e_honregisterreq];
    
    NSURL        *hyouka    = [NSURL URLWithString:@"https://quest.chubu.ac.jp/LessonEvalS/login.do"];
    NSURLRequest *hyoukareq = [NSURLRequest requestWithURL:hyouka];
    [_hyouka loadRequest: hyoukareq];
    
    NSURL        *webmail    = [NSURL URLWithString:@"https://tora-net.sti.chubu.ac.jp/deepmail/cgi-bin/mobile/login.cgi"];
    NSURLRequest *webmailreq = [NSURLRequest requestWithURL:webmail];
    [_webmail loadRequest: webmailreq];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // ステータスバーのインジケータ非表示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
