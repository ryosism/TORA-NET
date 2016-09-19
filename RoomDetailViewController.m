//
//  RoomDetailViewController.m
//  TORA-NET
//
//  Created by 祖父江亮 on 2015/06/24.
//  Copyright (c) 2015年 Ryo. All rights reserved.
//

#import "RoomDetailViewController.h"
#import "RoomMapViewController.h"

@interface RoomDetailViewController ()

@end

@implementation RoomDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Room number is %@",_gettitle);
    
    BOOL bl = [_gettitle hasPrefix:@"["];
    if(bl==1)
    {
        NSLog(@"画像データがありません");
        NSURL        *nopic    = [NSURL URLWithString:@"https://mb.api.cloud.nifty.com/2013-09-01/applications/nRtYFHs36B0uKctM/publicFiles/nodata.png"];
        NSURLRequest *nopicreq = [NSURLRequest requestWithURL:nopic];
        [_roomwebview loadRequest: nopicreq];
        NSLog(@"Request url is %@",nopic);
    }
    else
    {
        NSString *str1 = @"https://mb.api.cloud.nifty.com/2013-09-01/applications/nRtYFHs36B0uKctM/publicFiles/";
        NSString *str2 = @".png";
        str1 = [str1 stringByAppendingString:_gettitle];
        
        NSString *url = [str1 stringByAppendingString:str2];
        NSLog(@"Request url is %@",url);
        
        NSURL        *roomdetail    = [NSURL URLWithString:url];
        NSURLRequest *roomdetailreq = [NSURLRequest requestWithURL:roomdetail];
        [_roomwebview loadRequest: roomdetailreq];
    }
    
    self.subtitle.text = self.gettitle;
    self.navigationbartitle.title = self.gettitle;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RoomMapViewController *viewController = (RoomMapViewController *)[segue destinationViewController];
    viewController.gettitle = self.gettitle;
}

@end
