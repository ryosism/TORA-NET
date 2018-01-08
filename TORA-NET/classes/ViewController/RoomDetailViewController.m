//
//  RoomDetailViewController.m
//  TORA-NET
//
//  Created by 祖父江亮 on 2015/06/24.
//  Copyright (c) 2015年 Ryo. All rights reserved.
//

#import "AppDelegate.h"
#import "RoomDetailViewController.h"
#import "RoomMapViewController.h"
@import Firebase;

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
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    FIRStorage *storage = [FIRStorage storage];
    
    //firebaseの辞書型配列を使ってキーから該当講義室の画像へつながる値を手に入れる
    //gs://tora-net.appspot.com/roomPic/923.png みたいな
    NSString *gsURL = appDelegate.gsData[self.gettitle];
    NSLog(@"%@",gsURL);
    
    //gsURLはここでfirebase storageの参照に使われる
    FIRStorageReference *spaceRef = [storage referenceForURL:gsURL];
    
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 3.0;
    
    //firebase storageの参照からhttpsのURL(NSURL型)に変換させる
    [spaceRef downloadURLWithCompletion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
        if (error != nil){
            //URL作成失敗
            NSLog(@"convertion failed");
        }else{
            //URL作成成功
            NSData *myData = [NSData dataWithContentsOfURL:URL];
            UIImage *myImage = [UIImage imageWithData:myData];
            self.imageView.image = myImage;
        }
    }];
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
