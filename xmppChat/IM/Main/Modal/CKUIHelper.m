//
//  CKUIHelper.m
//  xmppChat
//
//  Created by user on 15/11/30.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKUIHelper.h"

@implementation CKUIHelper


+ (NSMutableArray *) getMineVCItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    CKSettingItem *album = [[CKSettingItem alloc] initWithTitle:@"相册" imageName:@"MoreMyAlbum"];
    CKSettingItem *favorite = [[CKSettingItem alloc] initWithTitle:@"收藏" imageName:@"MoreMyFavorites"];
    CKSettingItem *bank = [[CKSettingItem alloc] initWithTitle:@"钱包" imageName:@"MoreMyBankCard"];
    CKSettingItem *card = [[CKSettingItem alloc] initWithTitle:@"卡包" imageName:@"MyCardPackageIcon"];
    CKSettingGroup *group1 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:album, favorite, bank, card, nil];
    [items addObject:group1];
    
    CKSettingItem *expression = [[CKSettingItem alloc] initWithTitle:@"表情" imageName:@"MoreExpressionShops"];
    CKSettingGroup *group2 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:expression, nil];
    [items addObject:group2];
    
    CKSettingItem *setting = [[CKSettingItem alloc] initWithTitle:@"设置" imageName:@"MoreSetting"];
    CKSettingGroup *group3 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:setting, nil];
    [items addObject:group3];
    
    return items;
}

+ (NSMutableArray *) getDiscoverItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    CKSettingItem *friendsAlbum = [[CKSettingItem alloc] initWithTitle:@"朋友圈" subTitle:nil imageName:@"ff_IconShowAlbum" subImageName:@"2.jpg"];
    CKSettingGroup *group1 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:friendsAlbum, nil];
    [items addObject:group1];
    
    CKSettingItem *qrCode = [[CKSettingItem alloc] initWithTitle:@"扫一扫" imageName:@"ff_IconQRCode"];
    CKSettingItem *shake = [[CKSettingItem alloc] initWithTitle:@"摇一摇" imageName:@"ff_IconShake"];
    CKSettingGroup *group2 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:qrCode, shake, nil];
    [items addObject:group2];
    
    CKSettingItem *loacation = [[CKSettingItem alloc] initWithTitle:@"附近的人" subTitle:@"" imageName:@"ff_IconLocationService" subImageName:@"FootStep" type: CKSettingItemTypeDefaultL];
    CKSettingItem *bottle = [[CKSettingItem alloc] initWithTitle:@"漂流瓶" imageName:@"ff_IconBottle"];
    CKSettingGroup *group3 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:loacation, bottle, nil];
    [items addObject:group3];
    
    CKSettingItem *shopping = [[CKSettingItem alloc] initWithTitle:@"购物" imageName:@"CreditCard_ShoppingBag"];
    CKSettingItem *game = [[CKSettingItem alloc] initWithTitle:@"游戏" subTitle:@"超火力新枪战" imageName:@"MoreGame" subImageName:@"game_tag_icon"];
    CKSettingGroup *group4 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:shopping, game, nil];
    [items addObject:group4];
    
    return items;
}

+ (NSMutableArray *) getDetailVCItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    CKSettingItem *tag = [[CKSettingItem alloc] initWithTitle:@"设置备注和标签"];
    CKSettingItem *phone = [[CKSettingItem alloc] initWithTitle:@"电话号码" subTitle:@"18888888888" type:CKSettingItemTypeLeft];
    CKSettingGroup *group1 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:tag, phone, nil];
    [items addObject:group1];
    CKSettingItem *position = [[CKSettingItem alloc] initWithTitle:@"地区" subTitle:@"北京 望京" type:CKSettingItemTypeLeft];
    CKSettingItem *album = [[CKSettingItem alloc] initWithTitle:@"个人相册" subImages:[NSMutableArray arrayWithObjects:@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg", nil]];
    CKSettingItem *more = [[CKSettingItem alloc] initWithTitle:@"更多" type:CKSettingItemTypeLeft];
    CKSettingGroup *group2 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:position, album, more, nil];
    [items addObject:group2];
    
    CKSettingItem *chatButton = [[CKSettingItem alloc] initWithTitle:@"发消息"  type:CKSettingItemTypeButton];
    CKSettingItem *videoButton = [[CKSettingItem alloc] initWithTitle:@"视频聊天"  type:CKSettingItemTypeButton];
    CKSettingGroup *group3 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:chatButton, videoButton, nil];
    [items addObject:group3];
    
    return items;
}

+ (NSMutableArray *) getMineDetailVCItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    CKSettingItem *avatar = [[CKSettingItem alloc] initWithTitle:@"头像" subImageName:@"JustChat_User_avatar" type:CKSettingItemTypeAvatar];
    CKSettingItem *name = [[CKSettingItem alloc] initWithTitle:@"名字" subTitle:@"Sunny"];
    CKSettingItem *num = [[CKSettingItem alloc] initWithTitle:@"微信号" subTitle:@"Sunny"];
    CKSettingItem *code = [[CKSettingItem alloc] initWithTitle:@"我的二维码"];
    CKSettingItem *address = [[CKSettingItem alloc] initWithTitle:@"我的地址"];
    CKSettingGroup *frist = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:avatar, name, num, code, address, nil];
    [items addObject:frist];
    
    CKSettingItem *sex = [[CKSettingItem alloc] initWithTitle:@"性别" subTitle:@"男"];
    CKSettingItem *pos = [[CKSettingItem alloc] initWithTitle:@"地址" subTitle:@"北京 望京"];
    CKSettingItem *proverbs = [[CKSettingItem alloc] initWithTitle:@"个性签名" subTitle:@"Try my best do everything!"];
    CKSettingGroup *second = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:sex, pos, proverbs, nil];
    [items addObject:second];
    
    return items;
}

+ (NSMutableArray *) getSettingVCItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    CKSettingItem *safe = [[CKSettingItem alloc] initWithTitle:@"账号和安全" subTitle:@"已保护" imageName:nil subImageName:@"ProfileLockOn" type:CKSettingItemTypeDefaultL];
    CKSettingGroup *group1 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:safe, nil];
    [items addObject:group1];
    
    CKSettingItem *noti = [[CKSettingItem alloc] initWithTitle:@"新消息通知"];
    CKSettingItem *privacy = [[CKSettingItem alloc] initWithTitle:@"隐私"];
    CKSettingItem *normal = [[CKSettingItem alloc] initWithTitle:@"通用"];
    CKSettingGroup *group2 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:noti, privacy, normal, nil];
    [items addObject:group2];
    
    CKSettingItem *about = [[CKSettingItem alloc] initWithTitle:@"关于微信"];
    CKSettingGroup *group3 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:about, nil];
    [items addObject:group3];
    
    CKSettingItem *exit = [[CKSettingItem alloc] initWithTitle:@"退出登陆" type:CKSettingItemTypeMidTitle];
    CKSettingGroup *group4 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:exit, nil];
    [items addObject:group4];
    
    return items;
}

+ (NSMutableArray *) getDetailSettingVCItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    CKSettingItem *tag = [[CKSettingItem alloc] initWithTitle:@"设置备注及标签"];
    CKSettingGroup *group1 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:tag, nil];
    [items addObject:group1];
    
    CKSettingItem *recommend = [[CKSettingItem alloc] initWithTitle:@"把他推荐给好友"];
    CKSettingGroup *group2 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:recommend, nil];
    [items addObject:group2];
    
    CKSettingItem *starFriend = [[CKSettingItem alloc] initWithTitle:@"把它设为星标朋友" type:CKSettingItemTypeSwitch];
    CKSettingGroup *group3 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:starFriend, nil];
    [items addObject:group3];
    
    CKSettingItem *prohibit = [[CKSettingItem alloc] initWithTitle:@"不让他看我的朋友圈" type:CKSettingItemTypeSwitch];
    CKSettingItem *ignore = [[CKSettingItem alloc] initWithTitle:@"不看他的朋友圈" type:CKSettingItemTypeSwitch];
    CKSettingGroup *group4 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:prohibit, ignore, nil];
    [items addObject:group4];
    
    CKSettingItem *addBlacklist = [[CKSettingItem alloc] initWithTitle:@"加入黑名单" type:CKSettingItemTypeSwitch];
    CKSettingItem *report = [[CKSettingItem alloc] initWithTitle:@"举报"];
    CKSettingGroup *group5 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:addBlacklist, report, nil];
    [items addObject:group5];
    
    CKSettingItem *delete = [[CKSettingItem alloc] initWithTitle:@"删除好友" type:CKSettingItemTypeButton];
    CKSettingGroup *group6 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:delete, nil];
    [items addObject:group6];
    
    return items;
}

+ (NSMutableArray *) getNewNotiVCItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    CKSettingItem *recNoti = [[CKSettingItem alloc] initWithTitle:@"接受新消息通知" subTitle:@"已开启"];
    CKSettingGroup *group1 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:@"如果你要关闭或开启微信的新消息通知，请在iPhone的\"设置\" - \"通知\"功能中，找到应用程序\"微信\"更改。" settingItems:recNoti, nil];
    [items addObject:group1];
    
    CKSettingItem *showDetail = [[CKSettingItem alloc] initWithTitle:@"通知显示详情信息" type:CKSettingItemTypeSwitch];
    CKSettingGroup *group2 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:@"关闭后，当收到微信消息时，通知提示将不显示发信人和内容摘要。" settingItems:showDetail, nil];
    [items addObject:group2];
    
    CKSettingItem *disturb = [[CKSettingItem alloc] initWithTitle:@"功能消息免打扰"];
    CKSettingGroup *group3 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:@"设置系统功能消息提示声音和振动时段。" settingItems:disturb, nil];
    [items addObject:group3];
    
    CKSettingItem *voice = [[CKSettingItem alloc] initWithTitle:@"声音" type:CKSettingItemTypeSwitch];
    CKSettingItem *shake = [[CKSettingItem alloc] initWithTitle:@"震动" type:CKSettingItemTypeSwitch];
    CKSettingGroup *group4 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:@"当微信在运行时，你可以设置是否需要声音或者振动。" settingItems:voice, shake, nil];
    [items addObject:group4];
    
    CKSettingItem *friends = [[CKSettingItem alloc] initWithTitle:@"朋友圈照片更新" type:CKSettingItemTypeSwitch];
    CKSettingGroup *group5 = [[CKSettingGroup alloc] initWithHeaderTitle:nil footerTitle:@"关闭后，有朋友更新照片时，界面下面的“发现”切换按钮上不再出现红点提示。" settingItems:friends, nil];
    [items addObject:group5];
    
    return items;
}


@end
