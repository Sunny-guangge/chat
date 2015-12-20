//
//  CKDiscoverTableViewController.m
//  xmppChat
//
//  Created by user on 15/11/24.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKDiscoverTableViewController.h"
#import "CKFounctionCell.h"
#import "CKUIHelper.h"
#import "CKSetting.h"
#import "CKShakeViewController.h"
#import "CKShopViewController.h"
#import "CKMomentsViewController.h"

@interface CKDiscoverTableViewController ()

@property (nonatomic,strong) NSMutableArray *discoverArray;

@end

@implementation CKDiscoverTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    
    self.tableView.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = footView;
    
    [self.tableView setTableHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 15.0f)]];
    
    _discoverArray = [CKUIHelper getDiscoverItems];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _discoverArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    CKSettingGroup *group = [_discoverArray objectAtIndex:section];
    
    return group.itemsCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CKSettingGroup *group = [_discoverArray objectAtIndex:indexPath.section];
    CKSettingItem *item = [group itemAtIndex:indexPath.row];
    
    CKFounctionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"founctionCell"];
    
    if (cell == nil) {
        cell = [[CKFounctionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"founctionCell"];
    }
    [cell setItem:item];
    [cell setUserInteractionEnabled:YES];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    indexPath.row == 0 ? [cell setTopLineStyle:CellLineStyleFill] :[cell setTopLineStyle:CellLineStyleNone];
    indexPath.row == group.itemsCount - 1 ? [cell setBottomLineStyle:CellLineStyleFill] : [cell setBottomLineStyle:CellLineStyleDefault];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerview"];
    
    if (footView == nil) {
        footView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"footerview"];
        [footView setBackgroundView:[UIView new]];
    }
    
    return footView;
}

#pragma mark - UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        CKMomentsViewController *momentVC = [[CKMomentsViewController alloc] init];
        
        [self.navigationController pushViewController:momentVC animated:YES];
        
    }
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        
        CKShakeViewController *shakeVC = [[CKShakeViewController alloc]init];
        
        [self.navigationController pushViewController:shakeVC animated:YES];
        
    }
    
    if (indexPath.section == 3 && indexPath.row == 0) {
        
        CKShopViewController *shopVC = [[CKShopViewController alloc] init];
        
        [self.navigationController pushViewController:shopVC animated:YES];
        
    }
    
     [tableView deselectRowAtIndexPath:indexPath animated:NO]; 
}


@end
