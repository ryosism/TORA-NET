//
//  FourthViewController.m
//  test-addtabs
//
//  Created by 祖父江亮 on 2015/04/26.
//  Copyright (c) 2015年 Ryo. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController ()
//@property (weak, nonatomic) IBOutlet UIWebView *url;


@end

@implementation FourthViewController

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // ステータスバーのインジケータ表示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL        *JRup      = [NSURL URLWithString:@"http://ekikara.jp/newdata/ekijikoku/2301021/up1_23206032.htm"];
    NSURLRequest *JRupreq   = [NSURLRequest requestWithURL:JRup];
    [_webviewup loadRequest: JRupreq];
    
    NSURL        *JRdown    = [NSURL URLWithString:@"http://ekikara.jp/newdata/ekijikoku/2301021/down1_23206032.htm"];
    NSURLRequest *JRdownreq = [NSURLRequest requestWithURL:JRdown];
    [_webviewdown loadRequest: JRdownreq];
    
    
    //NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    //[self.webview loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // ステータスバーのインジケータ非表示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

//以下、挫折した内容。選択したテーブルビューによって送るURLを変更する

/*-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexpath = [self.tableview indexPathForSelectedRow];
    NSURL *url = self.urls[indexpath.row];
    FourthViewController *viewController = (FourthViewController *)[segue destinationViewController];
    viewController.url = url;
}
*/

@end
