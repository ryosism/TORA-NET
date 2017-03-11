//
//  RoomMapViewController.h
//  TORA-NET
//
//  Created by 祖父江亮 on 2015/09/23.
//  Copyright (c) 2015年 Ryo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface RoomMapViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>

@property (nonatomic) NSString *gettitle;
@property (weak, nonatomic) IBOutlet UIWebView *pointmap;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationbartitle;
@property (weak, nonatomic) IBOutlet MKMapView *mapview;

@property (strong, nonatomic) CLLocationManager *locationManager;

@end
