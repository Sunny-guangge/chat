//
//  CKMoment.h
//  xmppChat
//
//  Created by user on 15/12/21.
//  Copyright © 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CKUser.h"
#import "CKMusic.h"
#import "CKWeb.h"
#import "CKLocation.h"

typedef NS_ENUM(NSInteger,CKMomentType) {
    CKMomentTypeImage,
    CKMomentTypeVideo,
    CKMomentTypeWeb,
    CKMomentTypeMusic,
    CKMomentTypeNone,
};


@interface CKMoment : NSObject

/**
 *  用户
 */
@property (nonatomic,strong) CKUser *user;

/**
 *  消息类型
 */
@property (nonatomic,assign) CKMomentType momentType;

/**
 *  时间
 */
@property (nonatomic,strong) NSString *time;

/**
 *  消息的来源
 */
@property (nonatomic,strong) NSString *from;

/**
 *  文字
 */
@property (nonatomic,strong) NSString *moment_text;

/**
 *  格式化文字
 */
@property (nonatomic,strong) NSAttributedString *attributedString;

/**
 *  文字消息整个的高度
 */
@property (nonatomic,assign) CGFloat cellHeight;

/**
 *  发送消息人得地理位置
 */
@property (nonatomic,strong) CKLocation *location;

/**
 *  音乐
 */
@property (nonatomic,strong) CKMusic *music;

/**
 *  网页
 */
@property (nonatomic,strong) CKWeb *web;

/**
 *  图片的链接组合
 */
@property (nonatomic,strong) NSMutableArray *imageArray;

@end
