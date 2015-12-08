//
//  CKContactViewController.m
//  xmppChat
//
//  Created by user on 15/10/16.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "CKContactViewController.h"
#import "CKAddViewController.h"
#import "AppDelegate.h"
#import "CKMyFriendListTableViewCell.h"
#import "CKFriendListHeaderView.h"
#import "CKUser.h"
#import "CKDataHelper.h"
#import "CKUserDetailTableViewController.h"
#import <CoreData/CoreData.h>

@interface CKContactViewController ()<UITableViewDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate>
{
    NSFetchedResultsController *_fecthdeResultController;
    
    XMPPJID *jid;
}

@property (nonatomic,strong) UITableView *contactTableView;

@property (nonatomic,strong) NSMutableArray *friendSortArray;

@property (nonatomic,strong) NSMutableArray *friendArray;

@property (nonatomic,strong) NSMutableArray *indexArray;

@property (nonatomic,strong) NSMutableArray *firstSectionArray;

@end

@implementation CKContactViewController
{
    UILabel *footLabel;
}

- (AppDelegate *)appDelegate
{
    return [[UIApplication sharedApplication] delegate];
}

- (NSMutableArray *)firstSectionArray
{
    if (_firstSectionArray == nil) {
        
        _firstSectionArray = [NSMutableArray array];
        
    }
    return _firstSectionArray;
}

- (NSMutableArray *)friendSortArray
{
    if (_friendSortArray == nil) {
        
        _friendSortArray = [[NSMutableArray alloc] init];
                
    }
    return _friendSortArray;
}

- (NSMutableArray *)friendArray
{
    if (_friendArray == nil) {
        
        _friendArray = [NSMutableArray array];
        
    }
    return _friendArray;
}

- (NSMutableArray *)indexArray
{
    if (_indexArray == nil) {
        
        _indexArray = [NSMutableArray array];
        
    }
    return _indexArray;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didClickAddMycompany)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    [self.view addSubview:self.contactTableView];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self initData];
    
    [self setupFetchedController];
}

- (void)setupFetchedController
{
    //实例化NSManagedObjectContext
    NSManagedObjectContext *context = [[xmppDelegate xmppRosterStorage] mainThreadManagedObjectContext];
    
    //实例化NSFetchRequest
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPUserCoreDataStorageObject"];
    
    //实例化一个排序
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES];
    NSSortDescriptor *sort2 = [NSSortDescriptor sortDescriptorWithKey:@"jidStr" ascending:YES];
    
    [request setSortDescriptors:@[sort1,sort2]];
    
    //实例化_fetchedResultsController
    _fecthdeResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:@"sectionNum" cacheName:nil];
    
    //设置FetchedResultsController的代理
    [_fecthdeResultController setDelegate:self];
    
    //查询数据
    NSError *error = nil;
    if (![_fecthdeResultController performFetch:&error]) {
        NSLog(@"%@",error.localizedDescription);
    }
    
}

#pragma mark - NSFetchedResultsController代理方法
#pragma mark 控制器数据发生改变（因为Roster是添加了代理的）
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // 当数据发生变化时，重新刷新表格
//    [self.tableView reloadData];
    NSArray *sectionData = [_fecthdeResultController sections];
    
//    if (sectionData.count > 0) {
//        id <NSFetchedResultsSectionInfo> sectionInfo = sectionData[section];
//        
//        return [sectionInfo numberOfObjects];
//    }
    
}

- (UITableView *)contactTableView
{
    if (!_contactTableView) {
        _contactTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 49)];
        _contactTableView.delegate = self;
        _contactTableView.dataSource = self;
        _contactTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contactTableView.showsVerticalScrollIndicator = NO;
        [_contactTableView setSectionIndexBackgroundColor:[UIColor clearColor]];
        [_contactTableView setSectionIndexColor:DEFAULT_NAVBAR_COLOR];
        
        footLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 49.0f)];
        _contactTableView.tableFooterView = footLabel;
        footLabel.backgroundColor = [UIColor whiteColor];
        footLabel.textColor = [UIColor grayColor];
        footLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _contactTableView;
}

- (void)didClickAddMycompany
{
    CKAddViewController *addVC = [[CKAddViewController alloc] init];
    
    [self.navigationController pushViewController:addVC animated:YES];
}



#pragma mark - UITableView数据源方法
#pragma mark 表格分组数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.friendSortArray.count + 1;
}

#pragma mark 对应分组中表格的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.firstSectionArray.count;
    }
    
    NSMutableArray *sectionArray = [self.friendSortArray objectAtIndex:section - 1];
    
    return sectionArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    
    CKFriendListHeaderView *headerView = [CKFriendListHeaderView friendListHeaderViewWithTableView:tableView];
    
    [headerView setTitle:self.indexArray[section]];
    
    return headerView;
}


- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _indexArray;
}

#pragma mark 表格行内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CKMyFriendListTableViewCell *cell = [CKMyFriendListTableViewCell friendListTableViewCellWithTableView:tableView];
    
    cell.topLineStyle = CellLineStyleNone;
    
    
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == self.firstSectionArray.count - 1) {
            
            cell.bottomLineStyle = CellLineStyleNone;
            
        }else
        {
            cell.bottomLineStyle = CellLineStyleDefault;
        }
        
        cell.user = self.firstSectionArray[indexPath.row];
        
    }else
    {
        NSMutableArray *sectionArray = [self.friendSortArray objectAtIndex:indexPath.section - 1];
        
        if (indexPath.row == sectionArray.count - 1) {
            
            cell.bottomLineStyle = CellLineStyleNone;
            
        }else
        {
            cell.bottomLineStyle = CellLineStyleDefault;
        }
        
        if (indexPath.section == self.friendSortArray.count && indexPath.row == sectionArray.count - 1) {
            
            cell.bottomLineStyle = CellLineStyleFill;
            
        }
        
        cell.user = [[self.friendSortArray objectAtIndex:indexPath.section - 1] objectAtIndex:indexPath.row];
    }
    
//    if (indexPath.section == self.indexArray.count && indexPath.row == sectionArray.count) {
//        cell.bottomLineStyle = CellLineStyleFill;
//    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    
    return 22.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CKUserDetailTableViewController *userDetailVC = [[CKUserDetailTableViewController alloc] init];
    
    userDetailVC.user = [[self.friendSortArray objectAtIndex:indexPath.section - 1] objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:userDetailVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - loading本地数据
- (void)initData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
        CKUser *sectionUser1 = [[CKUser alloc] init];
        sectionUser1.username = @"新的朋友";
        sectionUser1.avatarURL = @"plugins_FriendNotify";
        [self.firstSectionArray addObject:sectionUser1];
        
        CKUser *sectionUser2 = [[CKUser alloc] init];
        sectionUser2.username = @"群聊";
        sectionUser2.avatarURL = @"add_friend_icon_addgroup";
        [self.firstSectionArray addObject:sectionUser2];
        
        CKUser *sectionUser3 = [[CKUser alloc] init];
        sectionUser3.username = @"标签";
        sectionUser3.avatarURL = @"Contact_icon_ContactTag";
        [self.firstSectionArray addObject:sectionUser3];
        
        CKUser *sectionUser4 = [[CKUser alloc] init];
        sectionUser4.username = @"公众号";
        sectionUser4.avatarURL = @"add_friend_icon_offical";
        [self.firstSectionArray addObject:sectionUser4];
        
        
        
        CKUser *thatuser1 = [[CKUser alloc] init];
        thatuser1.username = @"Sunny";
        thatuser1.userID = @"123456";
        thatuser1.avatarURL = @"1.jpg";
        [self.friendArray addObject:thatuser1];
        
        CKUser *thatuser2 = [[CKUser alloc] init];
        thatuser2.username = @"张文静";
        thatuser2.avatarURL = @"2.jpg";
        [self.friendArray addObject:thatuser2];
        
        CKUser *thatuser3 = [[CKUser alloc] init];
        thatuser3.username = @"孙凯";
        thatuser3.avatarURL = @"3.jpg";
        [self.friendArray addObject:thatuser3];
        
        CKUser *thatuser4 = [[CKUser alloc] init];
        thatuser4.username = @"雷子";
        thatuser4.avatarURL = @"4.jpg";
        [self.friendArray addObject:thatuser4];
        
        CKUser *thatuser5 = [[CKUser alloc] init];
        thatuser5.username = @"卢志宏";
        thatuser5.avatarURL = @"5.jpg";
        [self.friendArray addObject:thatuser5];
        
        CKUser *thatuser6 = [[CKUser alloc] init];
        thatuser6.username = @"包包";
        thatuser6.avatarURL = @"6.jpg";
        [self.friendArray addObject:thatuser6];
        
        CKUser *thatuser7 = [[CKUser alloc] init];
        thatuser7.username = @"曾诚";
        thatuser7.avatarURL = @"7.jpg";
        [self.friendArray addObject:thatuser7];
        
        CKUser *thatuser8 = [[CKUser alloc] init];
        thatuser8.username = @"郜林";
        thatuser8.avatarURL = @"8.jpg";
        [self.friendArray addObject:thatuser8];
        
        CKUser *thatuser9 = [[CKUser alloc] init];
        thatuser9.username = @"易建联";
        thatuser9.avatarURL = @"9.jpg";
        [self.friendArray addObject:thatuser9];
        
        CKUser *thatuser10 = [[CKUser alloc] init];
        thatuser10.username = @"詹姆斯";
        thatuser10.avatarURL = @"10.jpg";
        [self.friendArray addObject:thatuser10];
        
        CKUser *thatuser11 = [[CKUser alloc] init];
        thatuser11.username = @"韦德";
        thatuser11.avatarURL = @"11.jpg";
        [self.friendArray addObject:thatuser11];
        
        CKUser *user12 = [[CKUser alloc] init];
        user12.username = @"库里";
        user12.avatarURL = @"12.jpg";
        [self.friendArray addObject:user12];
        
        CKUser *user13 = [[CKUser alloc] init];
        user13.username = @"陈小春";
        user13.avatarURL = @"13.jpg";
        [self.friendArray addObject:user13];
        
        CKUser *user14 = [[CKUser alloc] init];
        user14.username = @"筷子";
        user14.avatarURL = @"14.jpg";
        [self.friendArray addObject:user14];
        
        CKUser *user15 = [[CKUser alloc] init];
        user15.username = @"凳子";
        user15.avatarURL = @"15.jpg";
        [self.friendArray addObject:user15];
        
        CKUser *user16 = [[CKUser alloc] init];
        user16.username = @"椅子";
        user16.avatarURL = @"16.jpg";
        [self.friendArray addObject:user16];
        
        CKUser *user17 = [[CKUser alloc] init];
        user17.username = @"安然";
        user17.avatarURL = @"17.jpg";
        [self.friendArray addObject:user17];
        
        CKUser *user18 = [[CKUser alloc] init];
        user18.username = @"186";
        user18.avatarURL = @"18.jpg";
        [self.friendArray addObject:user18];
        
        
        self.friendSortArray = [CKDataHelper getFriendListDataBy:self.friendArray];
        self.indexArray = [CKDataHelper getFriendListSectionBy:self.friendSortArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.contactTableView reloadData];
            footLabel.text = [NSString stringWithFormat:@"%d位联系人",self.friendArray.count];
        });

    });

    
}

@end
