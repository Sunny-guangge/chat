//
//  CKChatMessageTableViewController.m
//  xmppChat
//
//  Created by user on 15/12/11.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKChatMessageTableViewController.h"
#import "CKTextMessageTableViewCell.h"
#import "CKImageMessageTableViewCell.h"
#import "CKVoiceMessageTableViewCell.h"
#import "CKLocationMessageTableViewCell.h"
#import "CKSystemMessageCommonTableViewCell.h"

@interface CKChatMessageTableViewController ()<UITableViewDataSource,UITableViewDelegate>



@end

@implementation CKChatMessageTableViewController





- (void)viewDidLoad
{
    self.view.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.tableView registerClass:[CKTextMessageTableViewCell class] forCellReuseIdentifier:@"CKTextMessageTableViewCell"];
    [self.tableView registerClass:[CKImageMessageTableViewCell class] forCellReuseIdentifier:@"CKImageMessageTableViewCell"];
    [self.tableView registerClass:[CKVoiceMessageTableViewCell class] forCellReuseIdentifier:@"CKVoiceMessageTableViewCell"];
    [self.tableView registerClass:[CKLocationMessageTableViewCell class] forCellReuseIdentifier:@"CKLocationMessageTableViewCell"];
    [self.tableView registerClass:[CKSystemMessageCommonTableViewCell class] forCellReuseIdentifier:@"CKSystemMessageCommonTableViewCell"];
}


- (void)addChatMessage:(CKMessage *)message
{
    [self.data addObject:message];
    [self.tableView reloadData];
}


- (void)scrollToBottom
{
    if (_data.count > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_data.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CKMessage *message = [_data objectAtIndex:indexPath.row];
    
    id cell = [tableView dequeueReusableCellWithIdentifier:message.cellIndentify];
    
    [cell setMessage:message];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CKMessage *message = [_data objectAtIndex:indexPath.row];
    
    return message.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
}

- (NSMutableArray *)data
{
    if (_data == nil) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [];
    [super touchesBegan:touches withEvent:event];
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(didTapMessageView:)]) {
        [_delegate didTapMessageView:self];
    }
}


@end
