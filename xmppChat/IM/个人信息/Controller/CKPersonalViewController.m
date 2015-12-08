//
//  CKPersonalViewController.m
//  xmppChat
//
//  Created by user on 15/10/15.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "CKPersonalViewController.h"
#import "AppDelegate.h"
#import "XMPPvCardTemp.h"
#import "CKLoginUser.h"
#import "CKUIHelper.h"
#import "CKSetting.h"
#import "CKFounctionCell.h"
#import "CKUserDetailCell.h"
#import "CKUser.h"
#import "CKSetTableViewController.h"
#import "CKPersonalDataTableViewController.h"
//#import "CKEditViewController.h"

#define AvatarURL NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)

@interface CKPersonalViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (nonatomic,strong) UITableView *cardTableView;

@property (nonatomic,strong) NSMutableArray *mineArray;

@property (nonatomic,strong) CKUser *user;

@end

@implementation CKPersonalViewController


- (UITableView *)cardTableView
{
    if (!_cardTableView) {
        _cardTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height )];
        _cardTableView.delegate = self;
        _cardTableView.dataSource = self;
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 15.0f)];
        [_cardTableView setTableHeaderView:headerView];
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
        _cardTableView.tableFooterView = footerView;
    }
    return _cardTableView;
}

- (AppDelegate *)appDelegate
{
    return [[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    
    self.cardTableView.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    
    [self.view addSubview:self.cardTableView];
    
    [self initData];
    
    [self getUserData];
}

- (void)initData
{
    _mineArray = [CKUIHelper getMineVCItems];
    
    _user = [[CKUser alloc] init];
    _user.username = @"Sunny";
    _user.nikename = @"Sunny";
    _user.userID = @"88888888";
    _user.avatarURL = @"";
    
    [self.cardTableView reloadData];
}

- (void)getUserData
{
    //获取当前账号的电子名片
    XMPPvCardTemp *myCard = [[[self appDelegate] xmppvCardModule] myvCardTemp];
    
    //获取当前账号是否有电子名片
    if (myCard == nil) {
        //新建电子名片
        myCard = [XMPPvCardTemp vCardTemp];
        
        //设置昵称
        myCard.nickname = [CKLoginUser shareLoginUser].loginUserName;
        _user.username = [CKLoginUser shareLoginUser].loginUserName;
    }
    _user.username = myCard.nickname;
    //设置jid
    if (myCard.jid == nil) {
        myCard.jid = [XMPPJID jidWithString:[CKLoginUser shareLoginUser].loginUserJIDName];
        _user.userID = [myCard.jid full];
    }
    
    //更新或保存电子名片
    [[[self appDelegate] xmppvCardModule] updateMyvCardTemp:myCard];
    
    //使用myCard中得信息设置界面UI显示
    //照片
    NSData *photoData = [[xmppDelegate xmppvCardAvatarModule] photoDataForJID:myCard.jid];
    
    NSString *docDir = [[AvatarURL objectAtIndex:0] stringByAppendingFormat:@"%@.png",@"avatar"];
    
    [photoData writeToFile:docDir atomically:YES];
    
    _user.avatarURL = docDir;
    
    [self.cardTableView reloadData];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


#pragma mark - UITableVieDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _mineArray ? _mineArray.count + 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    
    CKSettingGroup *group = [_mineArray objectAtIndex:section - 1];
    
    return group.itemsCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CKUserDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell"];
        if (cell == nil) {
            cell = [[CKUserDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userCell"];
        }
        cell.user = _user;
        
        cell.userDetailType = CKUserDetailCellTypeMine;
        [cell setBackgroundColor:[UIColor whiteColor]];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setTopLineStyle:CellLineStyleFill];
        [cell setBottomLineStyle:CellLineStyleFill];
        
        return cell;
    }
    
    
    CKSettingGroup *group = [_mineArray objectAtIndex:indexPath.section - 1];
    
    CKSettingItem *item = [group itemAtIndex:indexPath.row];
    
    CKFounctionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"founctionCell"];
    
    if (cell == nil) {
        cell = [[CKFounctionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"founctionCell"];
    }
    
    cell.item = item;
    [cell setUserInteractionEnabled:YES];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    indexPath.row == 0 ? [cell setTopLineStyle:CellLineStyleFill] :[cell setTopLineStyle:CellLineStyleNone];
    indexPath.row == group.itemsCount - 1 ? [cell setBottomLineStyle:CellLineStyleFill] : [cell setBottomLineStyle:CellLineStyleDefault];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerview"];
    
    if (footerView == nil) {
        
        footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"footerview"];
        [footerView setBackgroundView:[UIView new]];
    }
    
    return footerView;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90.0f;
    }
    
    return 43.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        CKPersonalDataTableViewController *personalDataVC = [[CKPersonalDataTableViewController alloc] init];
        
        [self.navigationController pushViewController:personalDataVC animated:YES];
    }else
    {
        CKSetTableViewController *setVC = [[CKSetTableViewController alloc] init];
        
        [self.navigationController pushViewController:setVC animated:YES];
    }
    
    
    
     [tableView deselectRowAtIndexPath:indexPath animated:NO]; 
}

@end
