//
//  CKUser.m
//  xmppChat
//
//  Created by user on 15/11/26.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKUser.h"
#import "NSString+TL.h"

@implementation CKUser


- (void) setUsername:(NSString *)username
{
    _username = username;
    _pinyin = username.pinyin;
    _initial = username.pinyinInitial;
}

@end
