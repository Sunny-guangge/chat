//
//  CKSetTableViewController.m
//  xmppChat
//
//  Created by user on 15/11/30.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKSetTableViewController.h"
#import "CKUIHelper.h"
#import "CKSetting.h"
#import "CKFounctionCell.h"
#import "CKNewsTableViewController.h"
#import "AppDelegate.h"

@interface CKSetTableViewController ()

@property (nonatomic,strong) NSMutableArray *setArray;

@end

@implementation CKSetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"设置";
    
    self.view.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    
    self.tableView.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    
    [self.tableView setTableHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 15.0f)]];
    
    [self initData];
}

- (void)initData
{
    _setArray = [CKUIHelper getSettingVCItems];
    
    [self.tableView reloadData];
}

- (AppDelegate *)appDelegate
{
    return [[UIApplication sharedApplication] delegate];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _setArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    CKSettingGroup *group = [_setArray objectAtIndex:section];
    
    return group.itemsCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CKSettingGroup *group = [_setArray objectAtIndex:indexPath.section];
    
    CKSettingItem *item = [group itemAtIndex:indexPath.row];
    
    CKFounctionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"founction"];
    
    if (cell == nil) {
        cell = [[CKFounctionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"founction"];
    }
    
    cell.item = item;
    
    cell.topLineStyle = indexPath.row == 0 ? CellLineStyleFill : CellLineStyleNone;
    cell.bottomLineStyle = indexPath.row == group.itemsCount - 1 ? CellLineStyleFill : CellLineStyleDefault;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"foot"];
    
    if (footerView == nil) {
        footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"foot"];
        [footerView setBackgroundView:[UIView new]];
    }
    
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        
        [[self appDelegate] logout];
        
        return;
        
    }
    
    CKNewsTableViewController *newsVC = [[CKNewsTableViewController alloc] init];
    
    [self.navigationController pushViewController:newsVC animated:YES];
    
     [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}


@end
