//
//  CKMessage.h
//  xmppChat
//
//  Created by user on 15/11/25.
//  Copyright © 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CKMessage : NSObject

/**
 *消息的照片
 */
@property (nonatomic,copy) NSString *message_AvatarURL;

/**
 *消息的时间
 */
@property (nonatomic,copy) NSString *message_Time;

/**
 *消息的内容
 */
@property (nonatomic,copy) NSString *message_Content;

/**
 *消息的用户名字
 */
@property (nonatomic,copy) NSString *message_Name;

@end
