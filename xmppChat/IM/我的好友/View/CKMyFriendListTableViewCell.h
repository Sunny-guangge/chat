//
//  CKMyFriendListTableViewCell.h
//  xmppChat
//
//  Created by user on 15/11/26.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKCommonTableViewCell.h"
#import "CKUser.h"

@interface CKMyFriendListTableViewCell : CKCommonTableViewCell

+ (instancetype)friendListTableViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) CKUser *user;

@end
