//
//  CKMomentsViewController.m
//  xmppChat
//
//  Created by user on 15/12/18.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKMomentsViewController.h"
#import "CKMomentTableViewCell.h"
#import "CKMomentHeaderView.h"

@interface CKMomentsViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,CKMomentHeaderViewDelegate>

@property (nonatomic,strong) UIBarButtonItem *rightBarButtonItem;

@property (nonatomic,strong) UITableView *momentTableView;

@property (nonatomic,strong) NSMutableArray *momentArray;

@end

@implementation CKMomentsViewController

- (void)viewDidLoad
{
    self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
    self.navigationItem.title = @"朋友圈";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.momentTableView];

    
    CKMomentHeaderView *headerView = [[CKMomentHeaderView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, WIDTH_SCREEN + 30)];
    headerView.contentMode = UIViewContentModeScaleAspectFill;
    headerView.delegate = self;
    CKUser *user = [[CKUser alloc] init];
    user.username = @"Sunny";
    user.avatarURL = @"5.jpg";
    headerView.user = user;
    
    UIImage *image = [UIImage imageNamed:@"6.jpg"];
    headerView.image = image;
    [self.momentTableView setTableHeaderView:headerView];
    
    
    [self.momentTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}


#pragma mark - Getter
- (UIBarButtonItem *)rightBarButtonItem
{
    if (_rightBarButtonItem == nil) {
        
        _rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(didClickCamera)];
        
    }
    return _rightBarButtonItem;
}

- (void)didClickCamera
{//发布动态
    
    
    
}

- (UITableView *)momentTableView
{
    if (_momentTableView == nil) {
        
        _momentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, WIDTH_SCREEN, HEIGHT_SCREEN + 64)];
        _momentTableView.delegate = self;
        _momentTableView.dataSource = self;
        _momentTableView.backgroundColor = [UIColor colorWithRed:33 /255 green:36 / 255 blue:39 / 255 alpha:1.0f];
        
    }
    return _momentTableView;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return _momentArray.count;
    return 20;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CKMomentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"haha"];
    
    if (cell == nil) {
        cell = [[CKMomentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"haha"];
    }
    
    cell.textLabel.text = @(indexPath.row).description;
    
    cell.topLineStyle = CellLineStyleNone;
    cell.bottomLineStyle = CellLineStyleFill;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark CKMomentHeaderViewDelegate
- (void)clickMomentHeaderBackImage
{
    //点击用户封面图，切换背景图片
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认切换背景图片？" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"确认", nil];
    [alertView show];
}

- (void)clickMomentHeaderAvatar
{
    //点击进入到用户的个人页面
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"进入到个人主页？" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"确认", nil];
    [alertView show];
}

@end
