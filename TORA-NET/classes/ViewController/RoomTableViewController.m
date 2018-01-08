//
//  RoomTableViewController.m
//  TORA-NET
//
//  Created by 祖父江亮 on 2015/06/24.
//  Copyright (c) 2015年 Ryo. All rights reserved.
//

#import "AppDelegate.h"
#import "RoomTableViewController.h"
#import "RoomDetailViewController.h"

#import "SVProgressHUD.h"
@import Firebase;

@interface RoomTableViewController () <UISearchBarDelegate, UISearchDisplayDelegate,UITableViewDelegate, UITableViewDataSource>

@end

@implementation RoomTableViewController

@synthesize roomlist;

- (void)viewWillAppear:(BOOL)animated{
    //データのコピー、各変数へデータを更新させる
    [self getRecentTabledata];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _roomtable.tableHeaderView = _searchbar;
    _searchbar.delegate =self;
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(applyAllData) name:@"firebase" object:nil];
    
    //UIRefreshControllの設定----------------------
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(controlRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.roomtable addSubview:self.refreshControl];
    //--------------------------------------------
}

- (void)getRecentTabledata{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
//  firebaseからデータを取得、講義室データの辞書配列を*urlとして持ってくる
//  NSNotificationCenterによってクロージャを発動させて無視されずに呼んでくれるようになる
    
    self.ref = [[FIRDatabase database] reference];
    [_ref observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSDictionary *url = snapshot.value;
        appDelegate.gsData = url[@"roomnum"];
        appDelegate.roomlist = [url[@"roomnum"] allKeys];
        NSSortDescriptor* dec = [NSSortDescriptor sortDescriptorWithKey:@"" ascending:YES];
        appDelegate.roomlist = [appDelegate.roomlist sortedArrayUsingDescriptors:[NSArray arrayWithObject:dec]];
        
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter postNotificationName:@"firebase" object:nil];
    }];
}

- (void)applyAllData{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    self.searchlist = appDelegate.roomlist;
    self.dataSource = appDelegate.roomlist;
    [self.roomtable reloadData];
}

#pragma mark - 引っ張ってリフレッシュ
- (void)controlRefresh:(id)sender
{
    //データのコピー、各変数へデータを更新させる
    [self getRecentTabledata];
    // 更新終了
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - テーブルビュー
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        return self.dataSource.count;
    }
    else
    {
        return self.searchlist.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        cell.textLabel.text = self.dataSource[indexPath.row];
    }
    else
    {
        cell.textLabel.text = [appDelegate.roomlist objectAtIndex:indexPath.row];
    }
    return cell;
}

#pragma mark - 検索結果によって表示するテーブルを変更、遷移機能
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //検索中の黒い画面なら
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        self.searchresult = self.dataSource;
        
        NSIndexPath *resultindexPath =self.searchresult[indexPath.row];
        
        NSString *searchtitle = (NSString *)resultindexPath;
        self.searchflag=1;
        self.room = searchtitle;
        
        [self performSegueWithIdentifier:@"showDetail" sender:self];
        [self.roomtable deselectRowAtIndexPath:indexPath animated:YES];
    }
}
#pragma mark 画面遷移
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(self.searchflag==0)
    {
        NSIndexPath *indexPath =[self.roomtable indexPathForSelectedRow];
        
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSString *title = appDelegate.roomlist[indexPath.row];
        
        RoomDetailViewController *viewController = (RoomDetailViewController *)[segue destinationViewController];
        viewController.gettitle = title;
        NSLog(@"you selected %@",title);
        
        [self.roomtable deselectRowAtIndexPath:indexPath animated:YES];
    }
    else
    {
        RoomDetailViewController *viewController = (RoomDetailViewController *)[segue destinationViewController];
        NSLog(@"You selected %@",self.room);
        viewController.gettitle = self.room;
        self.searchflag=0;
    }
    [SVProgressHUD show];
}

-(void)viewDidDisappear:(BOOL)animated{
    [SVProgressHUD dismiss];
}

#pragma mark 検索部分
-(void)filterContainsWithSearchText:(NSString *)searchText
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
    NSLog(@"predicate = %@",searchText);
    self.dataSource = [self.searchlist filteredArrayUsingPredicate:predicate];
}

-(BOOL)searchDisplayController:(UISearchController *)controller shouldReloadTableForSearchString:(NSString *)searchString;
{
    [self filterContainsWithSearchText:searchString];
    
    return YES;
}

@end
