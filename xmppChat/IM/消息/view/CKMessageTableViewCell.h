//
//  CKMessageTableViewCell.h
//  xmppChat
//
//  Created by user on 15/11/25.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKCommonTableViewCell.h"
#import "CKMessage.h"

@interface CKMessageTableViewCell : CKCommonTableViewCell

+ (instancetype)messageTableViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) CKMessage *message;

@end
