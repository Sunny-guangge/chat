//
//  CKSetting.m
//  xmppChat
//
//  Created by user on 15/11/27.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKSetting.h"

@implementation CKSettingItem

- (id) initWithTitle:(NSString *)title
{
    return [self initWithTitle:title subTitle:nil imageName:nil subImageName:nil type:CKSettingItemTypeDefault];
}

- (id) initWithTitle:(NSString *)title subImageName:(NSString *)subImageName
{
    return [self initWithTitle:title subTitle:nil imageName:nil subImageName:subImageName type:CKSettingItemTypeDefault];
}

- (id) initWithTitle:(NSString *)title type:(CKSettingItemType)type
{
    return [self initWithTitle:title subTitle:nil imageName:nil subImageName:nil type:type];
}

- (id) initWithTitle:(NSString *)title subImages:(NSMutableArray *)subImages
{
    _subImages = subImages;
    return [self initWithTitle:title type:CKSettingItemTypeLeft];
}

- (id) initWithTitle:(NSString *)title imageName:(NSString *)imageName
{
    return [self initWithTitle:title subTitle:nil imageName:imageName subImageName:nil type:CKSettingItemTypeDefault];
}

- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    return [self initWithTitle:title subTitle:subTitle imageName:nil subImageName:nil type:CKSettingItemTypeDefault];
}

- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle type:(CKSettingItemType)type
{
    return [self initWithTitle:title subTitle:subTitle imageName:nil subImageName:nil type:type];
}

- (id) initWithTitle:(NSString *)title subImageName:(NSString *)subImageName type:(CKSettingItemType)type
{
    return [self initWithTitle:title subTitle:nil imageName:nil subImageName:subImageName type:type];
}

- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imageName subImageName:(NSString *)subImageName
{
    return [self initWithTitle:title subTitle:subTitle imageName:imageName subImageName:subImageName type:CKSettingItemTypeDefault];
}

- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imageName subImageName:(NSString *)subImageName type:(CKSettingItemType)type
{
    if (self = [super init]) {
        _title = title;
        _subTitle = subTitle;
        _imageName = imageName;
        _subImageName = subImageName;
        _subImageURL = nil;
        _type = type;
    }
    return self;
}

- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imageName subImageURL:(NSURL *)subImageURL type:(CKSettingItemType)type
{
    if (self = [super init]) {
        _title = title;
        _subTitle = subTitle;
        _imageName = imageName;
        _subImageName = nil;
        _subImageURL = subImageURL;
        _type = type;
    }
    return self;
}




@end


@implementation CKSettingGroup
- (id)initWithHeaderTitle:(NSString *)headerTitle footerTitl:(NSString *)footerTitle settingItems:(CKSettingItem *)firstObj, ...
{
    if (self = [super init]) {
        _headerTitle = headerTitle;
        _footerTitle = footerTitle;
        _items = [[NSMutableArray alloc] init];
        va_list argList;
        if (firstObj) {
            [_items addObject:firstObj];
            va_start(argList, firstObj);
            id arg;
            while ((arg = va_arg(argList, id))) {
                [_items addObject:arg];
            }
            va_end(argList);
        }
    }
    return self;

}

- (id) initWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle settingItems:(CKSettingItem *)firstObj, ...
{
    if (self = [super init]) {
        _headerTitle = headerTitle;
        _footerTitle = footerTitle;
        _items = [[NSMutableArray alloc] init];
        va_list argList;
        if (firstObj) {
            [_items addObject:firstObj];
            va_start(argList, firstObj);
            id arg;
            while ((arg = va_arg(argList, id))) {
                [_items addObject:arg];
            }
            va_end(argList);
        }
    }
    return self;
}

- (CKSettingItem *) itemAtIndex:(NSUInteger)index
{
    return [_items objectAtIndex:index];
}

- (NSUInteger) itemsCount
{
    return _itemsCount = _items.count;
}



@end
