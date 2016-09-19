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

@interface RoomTableViewController () <UISearchBarDelegate, UISearchDisplayDelegate,UITableViewDelegate, UITableViewDataSource>

@end

@implementation RoomTableViewController

@synthesize roomlist;

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    _roomtable.tableHeaderView = _searchbar;
    _searchbar.delegate =self;
    
    //jsonデータからroomlistを取得-------------------------------
    appDelegate.path = [[NSBundle mainBundle] pathForResource:@"roomlist" ofType:@"json"];
    appDelegate.jsondata = [NSData dataWithContentsOfFile:appDelegate.path];
    appDelegate.roomlist = [NSJSONSerialization JSONObjectWithData:appDelegate.jsondata options:0 error:nil];
    self.searchlist = appDelegate.roomlist;
    
    //UIRefreshControllの設定----------------------
    //引っ張って更新するときにFTP上のjsonを取得する、オフラインなら取得せずローカルにあるものを引き続き使用する
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(controlRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.roomtable addSubview:self.refreshControl];
    //--------------------------------------------
}

- (void)controlRefresh:(id)sender
{
    // 更新開始
    [self.refreshControl beginRefreshing];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSURL *url = [NSURL URLWithString:@"http://www.tora-net.tkg.xyz/iOS/resource/roomlist.json"];
    NSURLRequest *urlreq = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSData *jsondata = [NSURLConnection sendSynchronousRequest:urlreq returningResponse:&response error:nil];
    appDelegate.roomlist = [NSJSONSerialization JSONObjectWithData:jsondata options:0 error:nil];
    
    self.searchlist = appDelegate.roomlist;
    
    NSLog(@"%@",self.searchlist);
    NSLog(@"%lu",self.searchlist.count);
    
    [self.roomtable reloadData];
    
    // 更新終了
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger datacount;
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        datacount = self.dataSource.count;
        return datacount;
    }
    
    else
    {
        return self.searchlist.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        cell.textLabel.text = [appDelegate.roomlist objectAtIndex:indexPath.row];
    }
    return cell;
}
//------------------------------------------------------//検索結果によって表示するテーブルを変更、遷移機能
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        self.searchresult = self.dataSource;
        
        NSIndexPath *resultindexPath =self.searchresult[indexPath.row];
        
        NSString *searchtitle = resultindexPath;
        self.searchflag=1;
        self.room = searchtitle;
        
        [self performSegueWithIdentifier:@"showDetail" sender:self];
        [self.roomtable deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(self.searchflag==0)
    {
        NSIndexPath *indexPath =[self.roomtable indexPathForSelectedRow];
        
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
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
}
//--------------------------------------------------------------------------//

//検索部分
-(void)filterContainsWithSearchText:(NSString *)searchText
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
    NSLog(@"predicate = %@",searchText);
    self.dataSource = [self.searchlist filteredArrayUsingPredicate:predicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString;
{
    [self filterContainsWithSearchText:searchString];
    
    return YES;
}

@end
