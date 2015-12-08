//
//  CKEnumerate.h
//  xmppChat
//
//  Created by user on 15/11/27.
//  Copyright © 2015年 user. All rights reserved.
//

#ifndef xmppChat_CKEnumerate_h
#define xmppChat_CKEnumerate_h
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,CKSettingItemType) {
    CKSettingItemTypeDefault,       // image, title, rightTitle, rightImage
    CKSettingItemTypeDefaultL,      // image, title, leftImage, rightTitle
    CKSettingItemTypeLeft,          // iamge, title, leftTitle, leftImage
    CKSettingItemTypeButton,        // button
    CKSettingItemTypeAvatar,        // title, avatar
    CKSettingItemTypeMidTitle,      // title
    CKSettingItemTypeSwitch,        // title, Switch
};

#endif
