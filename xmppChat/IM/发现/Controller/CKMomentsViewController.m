//
//  CKMomentsViewController.m
//  xmppChat
//
//  Created by user on 15/12/18.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKMomentsViewController.h"
#import "CKMomentTableViewCell.h"

@interface CKMomentsViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

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
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, WIDTH_SCREEN)];
    headerView.backgroundColor = [UIColor redColor];
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

@end
