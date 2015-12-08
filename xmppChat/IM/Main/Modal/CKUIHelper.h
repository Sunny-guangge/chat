//
//  CKUIHelper.h
//  xmppChat
//
//  Created by user on 15/11/30.
//  Copyright © 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKSetting.h"

@interface CKUIHelper : NSObject

+ (NSMutableArray *) getDiscoverItems;
+ (NSMutableArray *) getMineVCItems;
+ (NSMutableArray *) getDetailVCItems;
+ (NSMutableArray *) getDetailSettingVCItems;
+ (NSMutableArray *) getMineDetailVCItems;

+ (NSMutableArray *) getSettingVCItems;
+ (NSMutableArray *) getNewNotiVCItems;

@end
