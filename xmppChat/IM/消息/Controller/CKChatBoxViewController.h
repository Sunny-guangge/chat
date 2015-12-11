//
//  CKChatBoxViewController.h
//  xmppChat
//
//  Created by user on 15/12/11.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKMessage.h"

@class CKChatBoxViewController;
@protocol CKChatBoxViewControllerDelegate <NSObject>

- (void)chatBoxViewController:(CKChatBoxViewController *)chatBoxViewController
                  sendMessage:(CKMessage *)message;
- (void)chatBoxViewCOntroller:(CKChatBoxViewController *)chatBoxViewController
       didChangeChatBoxHeight:(CGFloat)height;

@end

@interface CKChatBoxViewController : UIViewController

@property (nonatomic,weak) id<CKChatBoxViewControllerDelegate>delegate;

@end
