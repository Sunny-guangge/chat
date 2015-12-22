//
//  CKWeb.h
//  xmppChat
//
//  Created by user on 15/12/21.
//  Copyright © 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CKWeb : NSObject

/**
 *  标题
 */
@property (nonatomic,strong) NSString *web_Title;

/**
 *  链接地址
 */
@property (nonatomic,strong) NSString *web_URL;

/**
 *  链接的图片
 */
@property (nonatomic,strong) NSString *web_ImageURL;

@end
