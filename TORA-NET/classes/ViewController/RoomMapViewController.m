//
//  RoomMapViewController.m
//  TORA-NET
//
//  Created by 祖父江亮 on 2015/09/23.
//  Copyright (c) 2015年 Ryo. All rights reserved.
//

#import "RoomMapViewController.h"

@interface RoomMapViewController ()

@end

@implementation RoomMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLLocationCoordinate2D co;
    NSString *pintitle;
    NSString *pincomment;

    if([_gettitle hasPrefix:@"9"])
    {
        self.navigationbartitle.title = @"9号館の位置";

        co.latitude  = 35.273644;
        co.longitude = 137.014000;
        pintitle = @"9号館";
        pincomment = @"921~959";
    }
    else if([_gettitle hasPrefix:@"10"])
    {
        self.navigationbartitle.title = @"10号館の位置";
        co.latitude  = 35.274610;
        co.longitude = 137.013550;
        pintitle = @"10号館";
        pincomment = @"1021~1034,103A~105G";
    }
    else if([_gettitle hasPrefix:@"21"])
    {
        self.navigationbartitle.title = @"21号館の位置";
        co.latitude  = 35.272650;
        co.longitude = 137.01230;
        pintitle = @"21号館";
        pincomment = @"2110~2140,4階以降ゼミ室";
    }
    else if([_gettitle hasPrefix:@"総合情報センター"])
    {
        self.navigationbartitle.title = @"総合情報センターの位置";
        co.latitude  = 35.272694;
        co.longitude = 137.012855;
        pintitle = @"総合情報センター";
//        pincomment = @"";
    }
    else if([_gettitle hasPrefix:@"不言実行館"] || [_gettitle hasPrefix:@"メインアリーナ"])
    {
        self.navigationbartitle.title = @"不言実行館の位置";
        co.latitude  = 35.274246;
        co.longitude = 137.014470;
        pintitle = @"不言実行館";
        pincomment = @"及びメインアリーナ";
    }
    else if([_gettitle hasPrefix:@"第１学生食堂"])
    {
        self.navigationbartitle.title = @"第１学生食堂の位置";
        co.latitude  = 35.273983;
        co.longitude = 137.013775;
        pintitle = @"第１学生食堂";
//        pincomment = @"";
    }
    else if([_gettitle hasPrefix:@"第２学生食堂"])
    {
        self.navigationbartitle.title = @"第２学生食堂の位置";
        co.latitude  = 35.274262;
        co.longitude = 137.014741;
        pintitle = @"第２学生食堂";
//        pincomment = @"";
    }
    else if([_gettitle hasPrefix:@"第３学生食堂"])
    {
        self.navigationbartitle.title = @"第３学生食堂の位置";
        co.latitude  = 35.275482;
        co.longitude = 137.013381;
        pintitle = @"第３学生食堂";
//        pincomment = @"";
    }
    else if([_gettitle hasPrefix:@"第４学生食堂"])
    {
        self.navigationbartitle.title = @"第４学生食堂の位置";
        co.latitude  = 35.276248;
        co.longitude = 137.014658;
        pintitle = @"第４学生食堂";
//        pincomment = @"";
    }
    else if([_gettitle hasPrefix:@"三浦記念図書館"])
    {
        self.navigationbartitle.title = @"三浦記念図書館の位置";
        co.latitude  = 35.273638;
        co.longitude = 137.013007;
        pintitle = @"三浦記念図書館";
//        pincomment = @"";
    }
    else
    {
        NSString *title = [_gettitle stringByAppendingString:@"の位置"];
        self.navigationbartitle.title = title;
        NSURL        *nopic    = [NSURL URLWithString:@"http://www.tora-net.tkg.xyz/iOS/resource/pic/room/nodata.png"];
        NSURLRequest *nopicreq = [NSURLRequest requestWithURL:nopic];
        [_pointmap loadRequest: nopicreq];
    }
    
    //ユーザーの現在地を追従、進行方向も表示する--------------------
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        // iOS バージョンが 8 以上
        // 位置情報取得の許可を求めるメッセージを表示する
        [self.locationManager requestWhenInUseAuthorization];
    } else {
        // iOS バージョンが 8 未満
        [self.locationManager startUpdatingLocation];
    }
    
    self.mapview.showsUserLocation = YES;
    self.locationManager.distanceFilter = 5; //５メートルごとに更新
    self.mapview.userTrackingMode = MKUserTrackingModeFollowWithHeading;

    //ピンを全て削除
    [self.mapview removeAnnotations: self.mapview.annotations];
    // 新しいピンを作成
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    MKPinAnnotationView *pin;
    // ピンの色をオレンジ色にする
    pin.pinTintColor = [UIColor orangeColor];
    pin.animatesDrop = true;
    
    annotation.coordinate = co;
    annotation.title = pintitle;
    annotation.subtitle = pincomment;
    // ピンを追加
    [self.mapview addAnnotation:annotation];
    
    //MapViewを中部大学に移動-----------------------------------
    MKCoordinateRegion cr = self.mapview.region;
    //座標と縮尺
    cr.center = co;
    cr.span = MKCoordinateSpanMake(0.003, 0.003);
    [self.mapview setRegion:cr animated:YES];
    
}

- (void)mapLoadingIsFinished{
    NSLog(@"DidFinishLoading!!!!!");
}

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    NSLog(@"DidFinishLoading");
}

- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered{
    NSLog(@"DidFinishLoading!!!");
}


- (MKAnnotationView *)mapview:(MKMapView *)mapview viewForAnnotation:(id<MKAnnotation>)annotation{
    
    MKPinAnnotationView *pin;
    // ピンの色をオレンジ色にする
    pin.pinTintColor = [UIColor orangeColor];
    pin.animatesDrop = true;
    NSLog(@"read");
    return pin;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
