//
//  RoomTableViewController.h
//  TORA-NET
//
//  Created by 祖父江亮 on 2015/06/24.
//  Copyright (c) 2015年 Ryo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomTableViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *roomtable;
@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic) NSArray *searchlist;
@property (nonatomic) NSArray *searchresult;
@property (weak,nonatomic) NSString *searchtitle;
@property (nonatomic) int searchflag;
@property (nonatomic) NSString *room;
@property (nonatomic) NSArray *roomlist;

@property(nonatomic) UIRefreshControl *refreshControl;

@end
