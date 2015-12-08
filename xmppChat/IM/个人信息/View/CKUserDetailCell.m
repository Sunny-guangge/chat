//
//  CKUserDetailCell.m
//  xmppChat
//
//  Created by user on 15/11/30.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKUserDetailCell.h"
#import "UIView+TL.h"

#define AvatarURL NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)

@interface CKUserDetailCell ()

@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *userIDLabel;
@property (nonatomic, strong) UILabel *nikeNameLabel;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIImageView *subImageView;

@end


@implementation CKUserDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self addSubview:self.avatarImageView];
        [self addSubview:self.usernameLabel];
        [self addSubview:self.userIDLabel];
        [self addSubview:self.nikeNameLabel];
        
    }
    return self;
}

- (void)layoutSubviews
{
    self.leftfreespace = self.frameWidth * 0.05;
    [super layoutSubviews];
    
    float spaceX = self.frameWidth * 0.04;
    float spaceY = self.frameHeight * 0.15;
    float imageWidth = self.frameHeight - spaceY * 2;
    [_avatarImageView setFrame:CGRectMake(spaceX, spaceY, imageWidth, imageWidth)];
    
    float labelX = imageWidth + spaceX * 2;
    float labelWidth = self.frameWidth - labelX - spaceX * 1.5;
    CGSize size = [_userIDLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    float labelHeight = imageWidth * 0.42;
    size.width = size.width > labelWidth ? labelWidth : size.width;
    float labelY = _userDetailType == CKUserDetailCellTypeMine ? spaceY * 1.45 : spaceY;
    [_usernameLabel setFrame:CGRectMake(labelX, labelY, labelWidth, labelHeight)];
    
    size = [_userIDLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    size.width = size.width > labelWidth ? labelWidth : size.width;
    labelY += labelHeight + (_userDetailType == CKUserDetailCellTypeMine ? spaceY * 0.3 : spaceY * 0.2);
    [_userIDLabel setFrame:CGRectMake(labelX, labelY, size.width, size.height)];
    
    size = [_nikeNameLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    size.width = size.width > labelWidth ? labelWidth : size.width;
    labelY = _userIDLabel.originY + _userIDLabel.frameHeight + spaceY * 0.15;
    [_nikeNameLabel setFrame:CGRectMake(labelX, labelY, size.width, size.height)];
}

- (void)setUser:(CKUser *)user
{
//    [_avatarImageView setImage:[UIImage imageNamed:[NSString stringWithFormat: @"%@", user.avatarURL]]];
    _avatarImageView.image = [UIImage imageNamed:@"JustChat_User_avatar"];
    
//    NSData *data = [NSData dataWithContentsOfFile:user.avatarURL];
//    
//    UIImage *image = [UIImage imageWithData:data];
//    
//    _avatarImageView.image = image;
    
    if (user.username && user.username.length > 0) {
        [_usernameLabel setText:user.username];
        if (user.nikename && user.nikename.length > 0) {
            [_nikeNameLabel setText:[NSString stringWithFormat:@"昵称：%@", user.nikename]];
        }
        else {
            [_nikeNameLabel setText:@""];
        }
    }
    else if (user.nikename && user.nikename.length > 0) {
        [_usernameLabel setText:user.nikename];
    }
    
    if (user.userID && user.userID.length > 0) {
        [_userIDLabel setText:[NSString stringWithFormat:@"微信号：%@", user.userID]];
    }
    else {
        [_userIDLabel setText:@""];
    }
}

- (void)setUserDetailType:(CKUserDetailCellType)userDetailType
{
    _userDetailType = userDetailType;
    switch (_userDetailType) {
        case CKUserDetailCellTypeFriends:
            [_userIDLabel setTextColor:DEFAULT_TEXT_GRAY_COLOR];
            [_userIDLabel setFont:[UIFont systemFontOfSize:13.0f]];
            break;
        case CKUserDetailCellTypeMine:
            [_userIDLabel setTextColor:[UIColor blackColor]];
            
            [_userIDLabel setFont:[UIFont systemFontOfSize:14.0f]];
            [_nikeNameLabel setHidden:YES];
            break;
        default:
            break;
    }
    [self sizeToFit];
}

- (UIImageView *) avatarImageView
{
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc] init];
        [_avatarImageView.layer setMasksToBounds:YES];
        [_avatarImageView.layer setCornerRadius:5.0f];
    }
    return _avatarImageView;
}

- (UILabel *) usernameLabel
{
    if (_usernameLabel == nil) {
        _usernameLabel = [[UILabel alloc] init];
        [_usernameLabel setFont:[UIFont systemFontOfSize:17.0f]];
    }
    return _usernameLabel;
}

- (UILabel *) userIDLabel
{
    if (_userIDLabel == nil) {
        _userIDLabel = [[UILabel alloc] init];
        [_userIDLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_userIDLabel setTextColor:DEFAULT_TEXT_GRAY_COLOR];
    }
    return _userIDLabel;
}

- (UILabel *) nikeNameLabel
{
    if (_nikeNameLabel == nil) {
        _nikeNameLabel = [[UILabel alloc] init];
        [_nikeNameLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [_nikeNameLabel setTextColor:DEFAULT_TEXT_GRAY_COLOR];
    }
    return _nikeNameLabel;
}


@end
