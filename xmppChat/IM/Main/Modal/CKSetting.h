//
//  CKSetting.h
//  xmppChat
//
//  Created by user on 15/11/27.
//  Copyright © 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKEnumerate.h"

@interface CKSettingItem : NSObject

@property (nonatomic,assign) CKSettingItemType type;

@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *subTitle;
@property (nonatomic,strong) NSString *subImageName;
@property (nonatomic,strong) NSMutableArray *subImages;
@property (nonatomic,strong) NSURL *subImageURL;


- (id) initWithTitle:(NSString *)title;
- (id) initWithTitle:(NSString *)title subImageName:(NSString *)subImageName;
- (id) initWithTitle:(NSString *)title subImages:(NSMutableArray *)subImages;
- (id) initWithTitle:(NSString *)title type:(CKSettingItemType)type;
- (id) initWithTitle:(NSString *)title imageName:(NSString *)imageName;
- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle;
- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle type:(CKSettingItemType)type;
- (id) initWithTitle:(NSString *)title subImageName:(NSString *)subImageName type:(CKSettingItemType)type;

- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imageName subImageName:(NSString *)subImageName;
- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imageName subImageName:(NSString *)subImageName type:(CKSettingItemType)type;
- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imageName subImageURL:(NSURL *)subImageURL type:(CKSettingItemType)type;



@end

@interface CKSettingGroup : NSObject

@property (nonatomic,strong) NSString *headerTitle;
@property (nonatomic,strong) NSString *footerTitle;
@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,assign) NSUInteger itemsCount;

- (id)initWithHeaderTitle:(NSString *)headerTitle footerTitl:(NSString *)footerTitle settingItems:(CKSettingItem *)firstObj, ...;

- (id) initWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle settingItems:(CKSettingItem *)firstObj, ...;

- (CKSettingItem *)itemAtIndex:(NSUInteger)index;



@end