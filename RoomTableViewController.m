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
#import <NCMB/NCMB.h>

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
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
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

- (void)getRecentTabledata{
    NSMutableArray *recentTableData = [NSMutableArray array];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    // roomlistクラスを検索するクエリを作成
    NCMBQuery *query = [NCMBQuery queryWithClassName:@"roomlist"];
    
    // scoreの降順でデータを取得するように設定する
    [query addAscendingOrder:@"num"];
    
    // データストアを検索
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            // 検索に失敗した場合の処理
            NSLog(@"検索に失敗しました。エラーコード：%ld", error.code);
        } else {
            // 検索に成功した場合の処理
            NSLog(@"検索に成功しました。");
            //取得したオブジェクトの中の"num"のカラムをレコードごとに取得、空にしたテーブルリストに追加していく
            for (id object in objects){
                [recentTableData addObject:[object objectForKey:@"num"]];
            }
        }
        if (objects) {
            //値をappdelegateに置いてある共有変数にぶち込む
            appDelegate.roomlist = recentTableData;
            // テーブルビューをリロード
            [self.roomtable reloadData];
        }else{
            //取得に失敗したらアラートを発生させる
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"接続失敗" message:@"講義室情報の更新に失敗しました。\n電波の良いところでもう一度お試しください。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alertView show];
        }

        

    }];
}

#pragma mark - 引っ張ってリフレッシュ
- (void)controlRefresh:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    //データのコピー、各変数へデータを更新させる
        //ここで一気にテーブルビューも更新するよ！
        [self getRecentTabledata];
    self.dataSource = appDelegate.roomlist;
    self.searchlist = appDelegate.roomlist;

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

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString;
{
    [self filterContainsWithSearchText:searchString];
    
    return YES;
}

@end
