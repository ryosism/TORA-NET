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
#import "Flurry/Flurry.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize path;
@synthesize jsondata;
@synthesize roomlist;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //FTPオフラインだとクラッシュするための対策案だが効果なし
//    NSArray *roomlist = @[@"921",@"922",@"923",@"924",@"925",@"931",@"932",@"933",@"934",@"935",
//                          @"936",@"937",@"938",@"939",@"941",@"942",@"943",@"944",@"945",@"946",
//                          @"947",@"948",@"949",@"951",@"952",@"953",@"954",@"955",@"956",@"957",
//                          @"958",@"959",@"総合情報センター",@"不言実行館"];
//    RoomTableViewController *viewController;
//    viewController.roomlist = roomlist;
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"roomlist" ofType:@"json"];
//    NSData *jsondata = [NSData dataWithContentsOfFile:path];
//    NSArray *roomlist = [NSJSONSerialization JSONObjectWithData:jsondata options:0 error:nil];
    
    [Fabric with:@[CrashlyticsKit]];
    
    [Flurry startSession:@"2FB8KXS42NY2ZRPV6X56"];
    
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
