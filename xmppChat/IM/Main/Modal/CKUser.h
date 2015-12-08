//
//  CKUser.h
//  xmppChat
//
//  Created by user on 15/11/26.
//  Copyright © 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CKUser : NSObject

///**
// *用户的id
// */
//@property (nonatomic,copy) NSString *user_ID;
//
///**
// *用户的名字
// */
//@property (nonatomic,copy) NSString *user_Name;
//
///**
// *用户的头像链接
// */
//@property (nonatomic,copy) NSString *user_Avatar;
//
///**
// *
// */



@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *nikename;
@property (nonatomic, copy) NSString *avatarURL;
@property (nonatomic, copy) NSString *motto;
@property (nonatomic, copy) NSString *phoneNumber;

@property (nonatomic,copy) NSString *pinyin;
@property (nonatomic,copy) NSString *initial;

@end
