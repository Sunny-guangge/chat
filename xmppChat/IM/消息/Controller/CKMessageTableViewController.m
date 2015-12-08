//
//  CKMessageTableViewController.m
//  xmppChat
//
//  Created by user on 15/11/20.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKMessageTableViewController.h"
#import "CKMessageTableViewCell.h"
#import "CKMessage.h"
#import "CKChatViewController.h"

@interface CKMessageTableViewController ()

@property (nonatomic,strong) NSMutableArray *messageArray;

@end

@implementation CKMessageTableViewController

- (NSMutableArray *)messageArray
{
    if (_messageArray == nil) {
        
        _messageArray = [NSMutableArray array];
        
        CKMessage *message1 = [[CKMessage alloc] init];
        message1.message_AvatarURL = @"1.jpg";
        message1.message_Content = @"昨天我已经看到了！";
        message1.message_Name = @"Sunny";
        message1.message_Time = @"刚刚";
        [_messageArray addObject:message1];
        
        CKMessage *message2 = [[CKMessage alloc] init];
        message2.message_AvatarURL = @"2.jpg";
        message2.message_Content = @"您好，好久不见呀！";
        message2.message_Name = @"昨日伤痕";
        message2.message_Time = @"22:10";
        [_messageArray addObject:message2];
        
        CKMessage *message3 = [[CKMessage alloc] init];
        message3.message_AvatarURL = @"3.jpg";
        message3.message_Content = @"地球在转动，而你却在那里伤心！";
        message3.message_Name = @"一辈子孤单";
        message3.message_Time = @"10:09";
        [_messageArray addObject:message3];
        
        CKMessage *message4 = [[CKMessage alloc] init];
        message4.message_AvatarURL = @"4.jpg";
        message4.message_Content = @"见到你非常开心！";
        message4.message_Name = @"野人";
        message4.message_Time = @"昨天";
        [_messageArray addObject:message4];
        
        CKMessage *message5 = [[CKMessage alloc] init];
        message5.message_AvatarURL = @"5.jpg";
        message5.message_Content = @"你好！";
        message5.message_Name = @"望京篮球";
        message5.message_Time = @"星期三";
        [_messageArray addObject:message5];
        
        CKMessage *message6 = [[CKMessage alloc] init];
        message6.message_AvatarURL = @"6.jpg";
        message6.message_Content = @"又给找的车！";
        message6.message_Name = @"阿雅";
        message6.message_Time = @"星期二";
        [_messageArray addObject:message6];
        
        CKMessage *message7 = [[CKMessage alloc] init];
        message7.message_AvatarURL = @"7.jpg";
        message7.message_Content = @"收到！";
        message7.message_Name = @"二哥";
        message7.message_Time = @"星期六";
        [_messageArray addObject:message7];
        
        CKMessage *message8 = [[CKMessage alloc] init];
        message8.message_AvatarURL = @"8.jpg";
        message8.message_Content = @"恩！";
        message8.message_Name = @"道士";
        message8.message_Time = @"15-11-24";
        [_messageArray addObject:message8];
        
        CKMessage *message9 = [[CKMessage alloc] init];
        message9.message_AvatarURL = @"9.jpg";
        message9.message_Content = @"我先抽藏了！";
        message9.message_Name = @"Cathy";
        message9.message_Time = @"15-11-23";
        [_messageArray addObject:message9];
        
        CKMessage *message10 = [[CKMessage alloc] init];
        message10.message_AvatarURL = @"10.jpg";
        message10.message_Content = @"额！";
        message10.message_Name = @"April";
        message10.message_Time = @"15-11-20";
        [_messageArray addObject:message10];
        
        CKMessage *message11 = [[CKMessage alloc] init];
        message11.message_AvatarURL = @"11.jpg";
        message11.message_Content = @"收到红包！";
        message11.message_Name = @"张明明";
        message11.message_Time = @"12-11-19";
        [_messageArray addObject:message11];
        
        CKMessage *message12 = [[CKMessage alloc] init];
        message12.message_AvatarURL = @"12.jpg";
        message12.message_Content = @"【动画表情】！";
        message12.message_Name = @"老王";
        message12.message_Time = @"15-11-19";
        [_messageArray addObject:message12];
        
        CKMessage *message13 = [[CKMessage alloc] init];
        message13.message_AvatarURL = @"13.jpg";
        message13.message_Content = @"包瑞娜！";
        message13.message_Name = @"包瑞娜";
        message13.message_Time = @"15-11-19";
        [_messageArray addObject:message13];
        
        CKMessage *message14 = [[CKMessage alloc] init];
        message14.message_AvatarURL = @"14.jpg";
        message14.message_Content = @"架桥！";
        message14.message_Name = @"嘉喬";
        message14.message_Time = @"15-11-18";
        [_messageArray addObject:message14];
        
        CKMessage *message15 = [[CKMessage alloc] init];
        message15.message_AvatarURL = @"15.jpg";
        message15.message_Content = @"周杰伦的歌还可以！";
        message15.message_Name = @"周杰伦";
        message15.message_Time = @"15-11-17";
        [_messageArray addObject:message15];
        
        CKMessage *message16 = [[CKMessage alloc] init];
        message16.message_AvatarURL = @"16.jpg";
        message16.message_Content = @"你好，周杰伦！";
        message16.message_Name = @"May";
        message16.message_Time = @"15-11-17";
        [_messageArray addObject:message16];
        
        CKMessage *message17 = [[CKMessage alloc] init];
        message17.message_AvatarURL = @"17.jpg";
        message17.message_Content = @"真的好开心呀！";
        message17.message_Name = @"hehe";
        message17.message_Time = @"15-11-16";
        [_messageArray addObject:message17];
        
        CKMessage *message18 = [[CKMessage alloc] init];
        message18.message_AvatarURL = @"18.jpg";
        message18.message_Content = @"雪下得好大呀！";
        message18.message_Name = @"Snow";
        message18.message_Time = @"15-11-15";
        [_messageArray addObject:message18];
        
    }
    return _messageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.tableView registerClass:[CKMessageTableViewCell class] forCellReuseIdentifier:@"CKMessageTableViewCell"];
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = footView;
    
    NSLog(@"%f",self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CKMessageTableViewCell *cell = [CKMessageTableViewCell messageTableViewCellWithTableView:tableView];
    
    [cell setTopLineStyle:CellLineStyleNone];
    
    if (indexPath.row == self.messageArray.count - 1) {
        
        [cell setBottomLineStyle:CellLineStyleFill];
        
    }else
    {
        [cell setBottomLineStyle:CellLineStyleDefault];
    }
    
    cell.message = self.messageArray[indexPath.row];
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.messageArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (NSString *) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPat{
    return @"删除";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 63;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    CKChatViewController *chatVC = [[CKChatViewController alloc] init];
    
    chatVC.navigationItem.title = @"Sunny";
    
    [self.navigationController pushViewController:chatVC animated:YES];
    
     [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
