//
//  CKPersonalDataTableViewController.m
//  xmppChat
//
//  Created by user on 15/12/1.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKPersonalDataTableViewController.h"
#import "CKSetting.h"
#import "CKFounctionCell.h"

@interface CKPersonalDataTableViewController ()

@property (nonatomic,strong) NSMutableArray *mineDataArray;

@end

@implementation CKPersonalDataTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView setTableHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 15)]];
    
    self.navigationItem.title = @"个人信息";
    
    self.view.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    
    self.tableView.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    
    [self initWithData];
    
}

- (void)initWithData
{
    _mineDataArray = [CKUIHelper getMineDetailVCItems];
    
    [self.tableView reloadData];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _mineDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    CKSettingGroup *group = [_mineDataArray objectAtIndex:section];
    
    return group.itemsCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CKFounctionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"founction"];
    
    if (cell == nil) {
        cell = [[CKFounctionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"founction"];
    }
    
    CKSettingGroup *group = [_mineDataArray objectAtIndex:indexPath.section];
    
    CKSettingItem *item = [group itemAtIndex:indexPath.row];
    
    cell.item = item;
    
    [item.title isEqualToString:@"微信号"] ? [cell setAccessoryType:UITableViewCellAccessoryNone] : [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    cell.topLineStyle = indexPath.row == 0 ? CellLineStyleFill : CellLineStyleNone;
    cell.bottomLineStyle = indexPath.row == group.itemsCount - 1 ? CellLineStyleFill : CellLineStyleDefault;
    
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"foot"];
    
    if (footView == nil) {
        footView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"foot"];
        [footView setBackgroundView:[UIView new]];
    }
    
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 22.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) {
        return 80;
    }
    
    return 43.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
