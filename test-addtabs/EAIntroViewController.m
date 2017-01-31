//
//  EAIntroViewController.m
//  TORA-NET
//
//  Created by 祖父江亮 on 2017/01/30.
//  Copyright © 2017年 Ryo. All rights reserved.
//

#import "EAIntroViewController.h"
#import "EAIntroView.h"

@interface EAIntroViewController ()<EAIntroDelegate>

@end

@implementation EAIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // page1-------------------------------------------
    EAIntroPage *page1 = [EAIntroPage page];
    
    page1.titlePositionY = self.view.bounds.size.height/2 - 10;
    page1.titleFont = [UIFont systemFontOfSize:26];
    page1.descPositionY = self.view.bounds.size.height/2 - 70;
    page1.descFont = [UIFont systemFontOfSize:16];
    
    page1.title = @"こんにちは！";
    page1.desc = @"インストールありがとうございます。\n機能と画面の説明です！";

    
    page1.bgImage = [UIImage imageNamed:@"bg1"];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tora-256"]];

   // page2-------------------------------------------
    EAIntroPage *page2 = [EAIntroPage page];
    
    page2.titlePositionY = self.view.bounds.size.height/2 - 10;
    page2.titleFont = [UIFont systemFontOfSize:26];
    page2.descPositionY = self.view.bounds.size.height/2 - 70;
    page2.descFont = [UIFont systemFontOfSize:16];
    
    page2.title = @"TORA-NETに簡単ログイン！";
    page2.desc = @"すぐにスマホ版サイトにアクセスできます。\nしかも自動ログイン機能で文字を入力する必要なし！";
    page2.bgImage = [UIImage imageNamed:@"bg2"];

    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2]];
//    intro.skipButtonAlignment = EAViewAlignmentCenter;
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:1.0];
    NSLog(@"[intro setDelegate:self];");
}

- (void)introDidFinish:(EAIntroView *)introView wasSkipped:(BOOL)wasSkipped {
    if(wasSkipped) {
        NSLog(@"Intro skipped");
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // 取得
        [ud setBool:NO forKey:@"KEY_isFirstTime"];
        [ud synchronize];   //適用
        
        [self dismissViewControllerAnimated:YES completion:nil];

    } else {
        NSLog(@"Intro finished");
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // 取得
        [ud setBool:NO forKey:@"KEY_isFirstTime"];
        [ud synchronize];   //適用
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
