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
    NSURL        *URLTORATop    = [NSURL URLWithString:@"https://tora-net.sti.chubu.ac.jp/portal/sptop.do?"];
    NSURLRequest *URLTORATopreq = [NSURLRequest requestWithURL:URLTORATop];
    [_toratop loadRequest: URLTORATopreq];
}

// ページ読込完了時に
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // ステータスバーのインジケータ非表示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // 取得
    BOOL b = [ud boolForKey:@"KEY_enableSwitch"];
    NSString *userID = [ud stringForKey:@"KEY_userID"];
    NSString *passwd = [ud stringForKey:@"KEY_passwd"];
    
    if (b) {
        // テキストフィールドに入力するJSを実行する
        NSString *putUserID = [NSString stringWithFormat:@"jQuery('#userId').val('%@');",userID];
        NSString *putPasswd = [NSString stringWithFormat:@"jQuery('#password').val('%@');",passwd];
        
        [webView stringByEvaluatingJavaScriptFromString:putUserID];
        [webView stringByEvaluatingJavaScriptFromString:putPasswd];
        
        // サブミットするJSを実行する
        NSString *submit = @"jQuery('#loginSP').click();";
        [webView stringByEvaluatingJavaScriptFromString:submit];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)goback:(UIStoryboardSegue *)segue {}

@end
