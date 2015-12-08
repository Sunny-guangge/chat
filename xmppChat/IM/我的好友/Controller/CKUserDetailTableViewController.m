//
//  CKUserDetailTableViewController.m
//  xmppChat
//
//  Created by user on 15/12/1.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKUserDetailTableViewController.h"
#import "CKUIHelper.h"
#import "CKSetting.h"
#import "CKFounctionCell.h"
#import "CKUserDetailCell.h"

@interface CKUserDetailTableViewController ()

@property (nonatomic,strong) NSMutableArray *userDetailArray;

@end

@implementation CKUserDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView setTableHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 15)]];
    
    self.view.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    
    self.navigationItem.title = @"详细资料";
    
    [self initWithData];
}

- (void)initWithData
{
    _userDetailArray = [CKUIHelper getDetailVCItems];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _userDetailArray.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    }
    
    CKSettingGroup *group = [_userDetailArray objectAtIndex:section - 1];
    
    return group.itemsCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        CKUserDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userdetail"];
        if (cell == nil) {
            cell = [[CKUserDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userdetail"];
        }
        cell.userDetailType = CKUserDetailCellTypeFriends;
        cell.user = self.user;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.topLineStyle = CellLineStyleFill;
        cell.bottomLineStyle = CellLineStyleFill;
        
        return cell;
    }
    
    CKFounctionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"founction"];
    
    if (cell == nil) {
        cell = [[CKFounctionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"founction"];
    }

    cell.accessoryType = indexPath.section > 2 ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
    
    CKSettingGroup *group = [_userDetailArray objectAtIndex:indexPath.section - 1];
    CKSettingItem *item = [group itemAtIndex:indexPath.row];
    
    cell.item = item;
    
    if (item.type == CKSettingItemTypeButton) {
        if ([item.title isEqualToString:@"发消息"]) {
            [cell setButtonBackgroundGColor:DEFAULT_GREEN_COLOR];
            [cell setButtonTitleColor:[UIColor whiteColor]];
        }
        [cell setTopLineStyle:CellLineStyleNone];
        [cell setBottomLineStyle:CellLineStyleNone];
        return cell;
    }
    

    cell.topLineStyle = indexPath.row == 0  ? CellLineStyleFill : CellLineStyleNone;
    cell.bottomLineStyle = indexPath.row == group.itemsCount - 1 ? CellLineStyleFill : CellLineStyleDefault;
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90.0f;
    }
    
    CKSettingGroup *group = [_userDetailArray objectAtIndex:indexPath.section - 1];
    CKSettingItem *item = [group itemAtIndex:indexPath.row];
    if (item.type == CKSettingItemTypeButton) {
        return 50.0f;
    }
    else if ([item.title isEqualToString:@"个人相册"]) {
        return 86.0f;
    }
    return 43.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *foot = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"foot"];
    
    if (foot == nil) {
        foot = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"foot"];
        [foot setBackgroundView:[UIView new]];
    }
    
    return foot;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
