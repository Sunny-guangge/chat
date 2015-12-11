//
//  CKChatMessageTableViewController.h
//  xmppChat
//
//  Created by user on 15/12/11.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKMessage.h"

@class CKChatMessageTableViewController;
@protocol CKChatMessageTableViewControllerDelegate <NSObject>

- (void)didTapMessageView:(CKChatMessageTableViewController *)chatMessageController;

@end

@interface CKChatMessageTableViewController : UITableViewController

@property (nonatomic,weak) id<CKChatMessageTableViewControllerDelegate>delegate;
@property (nonatomic,strong) NSMutableArray *data;


- (void)addChatMessage:(CKMessage *)message;
- (void)scrollToBottom;

@end
