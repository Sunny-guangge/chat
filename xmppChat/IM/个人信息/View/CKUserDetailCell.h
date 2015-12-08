//
//  CKUserDetailCell.h
//  xmppChat
//
//  Created by user on 15/11/30.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKCommonTableViewCell.h"
#import "CKUser.h"

typedef NS_ENUM(NSInteger,CKUserDetailCellType) {
    CKUserDetailCellTypeFriends,
    CKUserDetailCellTypeMine,
};

@interface CKUserDetailCell : CKCommonTableViewCell

@property (nonatomic,assign) CKUserDetailCellType userDetailType;

@property (nonatomic,strong) CKUser *user;

@end
