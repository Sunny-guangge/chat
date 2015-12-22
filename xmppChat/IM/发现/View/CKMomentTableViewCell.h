//
//  CKMomentTableViewCell.h
//  xmppChat
//
//  Created by user on 15/12/18.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKCommonTableViewCell.h"
#import "CKMoment.h"

@protocol CKMomentTableViewCellDelegate <NSObject>

- (void)clickUserAvatarORUserNameWithUser:(CKUser *)user;

- (void)clickUserLocation:(CKLocation *)location;

@end

@interface CKMomentTableViewCell : CKCommonTableViewCell

@property (nonatomic,strong) CKMoment *moment;

@property (nonatomic,assign) id<CKMomentTableViewCellDelegate>delegate;

@end
