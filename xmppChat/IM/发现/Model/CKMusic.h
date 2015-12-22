//
//  CKMusic.h
//  xmppChat
//
//  Created by user on 15/12/21.
//  Copyright © 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CKMusic : NSObject

/**
 *  音乐名
 */
@property (nonatomic,strong) NSString *music_Name;

/**
 *  音乐作者
 */
@property (nonatomic,strong) NSString *music_Singer;

/**
 *  音乐的链接
 */
@property (nonatomic,strong) NSString *music_URL;

/**
 *  音乐的图片
 */
@property (nonatomic,strong) NSString *music_ImageURL;

@end
