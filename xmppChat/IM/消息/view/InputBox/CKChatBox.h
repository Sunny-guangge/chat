//
//  CKChatBox.h
//  xmppChat
//
//  Created by user on 15/12/9.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKFace.h"

//输入框当前的情况
typedef NS_ENUM(NSInteger,CKChatBoxStatus) {
    CKChatBoxStatusNothing,
    CKChatBoxStatusShowVoice,
    CKChatBoxStatusShowFace,
    CKChatBoxStatusShowMore,
    CKChatBoxStatusShowKeyboard,
};

@class CKChatBox;
@protocol CKChatBoxDelegate <NSObject>
//输入框状态的改变
- (void)chatBox:(CKChatBox *)chatBox changeStatusForm:(CKChatBoxStatus)fromStatus to:(CKChatBoxStatus)toStatus;
//输入框发送的内容
- (void)chatBox:(CKChatBox *)chatBox sendTextMessage:(NSString *)textMessage;
//输入框改变高度
- (void)chatBox:(CKChatBox *)chatBox changeChatBoxHeight:(CGFloat)height;

@end

@interface CKChatBox : UIView

@property (nonatomic,assign) id<CKChatBoxDelegate> delegate;

@property (nonatomic,assign) CKChatBoxStatus status;

@property (nonatomic,assign) CGFloat curHeight;

- (void)addEmojiFace:(CKFace *)face;
- (void)sendCurrentMessage;
- (void)deleteButtonDown;

@end
