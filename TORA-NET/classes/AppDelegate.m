//
//  AppDelegate.m
//  test-addtabs
//
//  Created by 祖父江亮 on 2015/04/24.
//  Copyright (c) 2015年 Ryo. All rights reserved.
//

#import "AppDelegate.h"
#import "RoomTableViewController.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

#import <NCMB/NCMB.h>

@import Firebase;

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize path;
@synthesize jsondata;
@synthesize roomlist;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Firebaseの初期化
    [FIRApp configure];
    
    self.ref = [[FIRDatabase database] reference];
//    [[_ref child:@"roomnum"] setValue:@{@"923": @"923.png"}];
    
//    [_ref observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
//        NSDictionary *url = snapshot.value;
//        NSLog(@"%@",url[@"roomnum"]);
//    }];
    
    [Fabric with:@[CrashlyticsKit]];

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // 取得
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    
    //初期値
    [defaults setObject:@"NO" forKey:@"KEY_enableSwitch"];
    [defaults setObject:@"" forKey:@"KEY_userID"];
    [defaults setObject:@"" forKey:@"KEY_passwd"];
    [defaults setObject:@"YES" forKey:@"KEY_isFirstTime"];
    [ud registerDefaults:defaults];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
