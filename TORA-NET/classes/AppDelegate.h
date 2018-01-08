//
//  AppDelegate.h
//  test-addtabs
//
//  Created by 祖父江亮 on 2015/04/24.
//  Copyright (c) 2015年 Ryo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSData *jsondata;
@property (strong, nonatomic) NSArray *roomlist;

@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

