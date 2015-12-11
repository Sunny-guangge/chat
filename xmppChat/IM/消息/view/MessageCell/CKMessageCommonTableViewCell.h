//
//  CKMessageCommonTableViewCell.h
//  xmppChat
//
//  Created by user on 15/12/11.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKMessage.h"

@interface CKMessageCommonTableViewCell : UITableViewCell

@property (nonatomic,strong) CKMessage *message;

@property (nonatomic,strong) UIImageView *avatarImageView;   //头像
@property (nonatomic,strong) UIImageView *messageBackgroundImageView;   //消息背景
@property (nonatomic,strong) UIImageView *messageSendStatusImageView;   //消息发送状态

@end
