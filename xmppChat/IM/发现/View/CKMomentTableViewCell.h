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

//点击用户头像
- (void)clickUserAvatarORUserNameWithUser:(CKUser *)user;
//点击用户位置信息
- (void)clickUserLocation:(CKLocation *)location;
//点击moment中得音乐
- (void)clickUserMusicWithMusic:(CKMusic *)music;
//点击moment中得web
- (void)clickUserWebWithWeb:(CKWeb *)web;
@optional
//点击moment中得图片
- (void)clickUserImageWithImageArray:(NSMutableArray *)imageArray tag:(NSInteger)tag;
//用户自己删除自己的动态
//- (void)clickUserDeleteSelfMomentWithMoment
@end

@interface CKMomentTableViewCell : CKCommonTableViewCell

@property (nonatomic,strong) CKMoment *moment;

@property (nonatomic,assign) id<CKMomentTableViewCellDelegate>delegate;

@end
