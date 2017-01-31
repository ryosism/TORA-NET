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
    
    // アプリ実行端末のディスプレイサイズの高さを取得
    CGRect display = [UIScreen mainScreen].bounds;
    NSLog(@"dislay.size.height = %f",display.size.height);
    //4 = 568
    //4.7 = 667
    //5.5 = 736
    
    // page1-------------------------------------------
    EAIntroPage *page1 = [EAIntroPage page];
    
    page1.titlePositionY = self.view.bounds.size.height/2 - 30;
    page1.titleFont = [UIFont systemFontOfSize:26];
    page1.descPositionY = self.view.bounds.size.height/2 - 70;
    page1.descFont = [UIFont systemFontOfSize:16];
    
    page1.title = @"はじめまして！";
    page1.desc = @"インストールありがとうございます。\n機能と画面の説明です！\n\n続きは右にスワイプしてください。";

    
    page1.bgImage = [UIImage imageNamed:@"bg1"];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tora-256"]];

    // page2-------------------------------------------
    EAIntroPage *page2 = [EAIntroPage page];
    
    if (display.size.height == 568) {
        page2.titlePositionY = self.view.bounds.size.height/2 - 120;
        page2.titleFont = [UIFont systemFontOfSize:22];
        page2.descPositionY = self.view.bounds.size.height/2 - 140;
        page2.descFont = [UIFont systemFontOfSize:14];
    }else{
        page2.titlePositionY = self.view.bounds.size.height/2 - 140;
        page2.titleFont = [UIFont systemFontOfSize:26];
        page2.descPositionY = self.view.bounds.size.height/2 - 170;
        page2.descFont = [UIFont systemFontOfSize:16];
    }
    
    page2.title = @"TORA-NETに簡単ログイン！";
    page2.desc = @"すぐにスマホ版サイトにアクセスできます。\nしかも自動ログイン機能で文字を入力する必要なし！\n詳しくは右下の【設定】タブから。";
    page2.bgImage = [UIImage imageNamed:@"bg2"];

    // page3-------------------------------------------
    EAIntroPage *page3 = [EAIntroPage page];
    
    if (display.size.height == 568) {
        page3.titlePositionY = self.view.bounds.size.height/2 - 120;
        page3.titleFont = [UIFont systemFontOfSize:22];
        page3.descPositionY = self.view.bounds.size.height/2 - 140;
        page3.descFont = [UIFont systemFontOfSize:14];
    }else{
        page3.titlePositionY = self.view.bounds.size.height/2 - 140;
        page3.titleFont = [UIFont systemFontOfSize:26];
        page3.descPositionY = self.view.bounds.size.height/2 - 170;
        page3.descFont = [UIFont systemFontOfSize:16];
    }
    
    page3.title = @"講義室の検索機能";
    page3.desc = @"探している講義室がどこにあるかを検索することができます。\nさらに現在地と目的の建屋が一緒に学内地図で確認できます！";
    page3.bgImage = [UIImage imageNamed:@"bg3"];
    
    // page4-------------------------------------------
    EAIntroPage *page4 = [EAIntroPage page];
    
    if (display.size.height == 568) {
        page4.titlePositionY = self.view.bounds.size.height/2 - 120;
        page4.titleFont = [UIFont systemFontOfSize:22];
        page4.descPositionY = self.view.bounds.size.height/2 - 140;
        page4.descFont = [UIFont systemFontOfSize:14];
    }else{
        page4.titlePositionY = self.view.bounds.size.height/2 - 140;
        page4.titleFont = [UIFont systemFontOfSize:26];
        page4.descPositionY = self.view.bounds.size.height/2 - 170;
        page4.descFont = [UIFont systemFontOfSize:16];
    }
    
    page4.title = @"さぁ、使ってみよう！";
    page4.desc = @"他にも多くの機能を用意してます！\nキャンパスライフに少しでもお役に立てればと思います。どうぞよろしくお願いします！";
    page4.bgImage = [UIImage imageNamed:@"bg4"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4]];
    [intro.skipButton setTitle:@"スキップ" forState:UIControlStateNormal];
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:1.0];
    NSLog(@"[intro setDelegate:self];");
}

- (void)introDidFinish:(EAIntroView *)introView wasSkipped:(BOOL)wasSkipped {
    if(wasSkipped) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setBool:NO forKey:@"KEY_isFirstTime"];
        [ud synchronize];
        [self dismissViewControllerAnimated:YES completion:nil];

    } else {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setBool:NO forKey:@"KEY_isFirstTime"];
        [ud synchronize];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
