//
//  RoomDetailViewController.h
//  TORA-NET
//
//  Created by 祖父江亮 on 2015/06/24.
//  Copyright (c) 2015年 Ryo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *roomwebview;

@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationbartitle;
@property (nonatomic) NSString *gettitle;
@end
