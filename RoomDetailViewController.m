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

    self.subtitle.text = self.gettitle;
    self.navigationbartitle.title = self.gettitle;
}

- (void)viewDidAppear:(BOOL)animated{
    
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 3.0;
    
    BOOL bl = [_gettitle hasPrefix:@"["];
    if(bl==1)
    {
        NSURL        *nopic    = [NSURL URLWithString:@"https://mb.api.cloud.nifty.com/2013-09-01/applications/nRtYFHs36B0uKctM/publicFiles/nodata.png"];
        NSLog(@"Request url is %@",nopic);
        
        NSData *myData = [NSData dataWithContentsOfURL:nopic];
        UIImage *myImage = [UIImage imageWithData:myData];
        self.imageView.image = myImage;
    }else{
        NSString *str1 = @"https://mb.api.cloud.nifty.com/2013-09-01/applications/nRtYFHs36B0uKctM/publicFiles/";
        NSString *str2 = @".png";
        str1 = [str1 stringByAppendingString:_gettitle];
        
        NSString *url = [str1 stringByAppendingString:str2];
        NSLog(@"Request url is %@",url);
        NSURL        *roomdetail    = [NSURL URLWithString:url];
        NSData *myData = [NSData dataWithContentsOfURL:roomdetail];
        UIImage *myImage = [UIImage imageWithData:myData];
        self.imageView.image = myImage;
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
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
