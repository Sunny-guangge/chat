//
//  CKNewsTableViewController.m
//  xmppChat
//
//  Created by user on 15/11/30.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKNewsTableViewController.h"
#import "CKUIHelper.h"
#import "CKSetting.h"
#import "CKFounctionCell.h"
#import "CKTableViewHeaderFooterView.h"

@interface CKNewsTableViewController ()

@property (nonatomic,strong) NSMutableArray *newsArray;

@end

@implementation CKNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"新消息通知";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10.0f)];
    [self.tableView setTableHeaderView:headView];
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20.0f)];
    [self.tableView setTableFooterView:footerView];
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    
    [self initData];
}

- (void)initData
{
    _newsArray = [CKUIHelper getNewNotiVCItems];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _newsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    CKSettingGroup *group = [_newsArray objectAtIndex:section];
    
    return group.itemsCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CKSettingGroup *group = [_newsArray objectAtIndex:indexPath.section];
    
    CKSettingItem *item = [group itemAtIndex:indexPath.row];
    
    CKFounctionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"founction"];
    
    if (cell == nil) {
        cell = [[CKFounctionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"founction"];
    }
    
    cell.item = item;
    
    (item.type == CKSettingItemTypeSwitch || ![item.title isEqualToString:@"接受新消息提醒"]) ? [cell setAccessoryType:UITableViewCellAccessoryNone] : [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    indexPath.row == 0 ? [cell setTopLineStyle:CellLineStyleFill] : [cell setTopLineStyle:CellLineStyleNone];
    indexPath.row == group.itemsCount - 1 ? [cell setBottomLineStyle:CellLineStyleFill] : [cell setBottomLineStyle:CellLineStyleDefault];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CKTableViewHeaderFooterView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ckfoot"];
    
    if (footView == nil) {
        footView = [[CKTableViewHeaderFooterView alloc] initWithReuseIdentifier:@"ckfoot"];
    }
    
    CKSettingGroup *group = [_newsArray objectAtIndex:section];
    
    footView.text = group.footerTitle;
    
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CKSettingGroup *group = [_newsArray objectAtIndex:section];
    
    return [CKTableViewHeaderFooterView heightForTextToFitView:group.footerTitle];
}


@end
