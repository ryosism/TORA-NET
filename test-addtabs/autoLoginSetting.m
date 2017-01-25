//
//  autoLoginSetting.m
//  TORA-NET
//
//  Created by 祖父江亮 on 2017/01/25.
//  Copyright © 2017年 Ryo. All rights reserved.
//

#import "AppDelegate.h"
#import "autoLoginSetting.h"

@interface autoLoginSetting ()

@end

@implementation autoLoginSetting

- (void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // 取得
    BOOL b = [ud boolForKey:@"KEY_enableSwitch"];
    NSString *userID = [ud stringForKey:@"KEY_userID"];
    NSString *passwd = [ud stringForKey:@"KEY_passwd"];
    
    if (b) {
        self.enableSwitch.on = YES;
    }else{
        self.enableSwitch.on = NO;
    }
    
    if (userID) {
        self.userID.text = userID;
    }
    if (passwd) {
        self.passwd.text = passwd;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (IBAction)saveButtonPushed:(id)sender {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // 取得
    [ud setObject:self.userID.text forKey:@"KEY_userID"];
    [ud setObject:self.passwd.text forKey:@"KEY_passwd"];
    [ud setBool:YES forKey:@"KEY_enableSwitch"];
    
    [ud synchronize];   //適用

    NSLog(@"userID = %@",self.userID.text);
    NSLog(@"passwd = %@",self.passwd.text);
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"保存完了！" message:@"ログイン情報を保存しました。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    
    self.enableSwitch.on = YES;
    [self.userID resignFirstResponder];
    [self.passwd resignFirstResponder];
    [alertView show];
}

- (IBAction)switchChanged:(id)sender {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // 取得
    
    if (self.enableSwitch.on == YES) {
        [ud setBool:YES forKey:@"KEY_enableSwitch"];
    }else{
        [ud setBool:NO forKey:@"KEY_enableSwitch"];
    }
    
    [ud synchronize];   //適用
}

@end
