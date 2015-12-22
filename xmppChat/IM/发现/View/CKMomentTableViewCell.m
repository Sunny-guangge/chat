//
//  CKMomentTableViewCell.m
//  xmppChat
//
//  Created by user on 15/12/18.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKMomentTableViewCell.h"
#import "NSString+Helper.h"

@interface CKMomentTableViewCell ()
/**
 *  用户头像
 */
@property (nonatomic,strong) UIImageView *avatarImageView;
/**
 *  点击用户头像的button
 */
@property (nonatomic,strong) UIButton *avatarButton;
/**
 *  用户的名字label
 */
@property (nonatomic,strong) UILabel *nameLabel;
/**
 *  用户的名字button
 */
@property (nonatomic,strong) UIButton *nameButton;
/**
 *  用户的音乐或者网页的整体链接背景
 */
@property (nonatomic,strong) UIView *backView;
/**
 *  时间label
 */
@property (nonatomic,strong) UILabel *timeLabel;
/**
 *  用户分享的内容的展示label
 */
@property (nonatomic,strong) UILabel *fromLabel;
/**
 *  自己发布的动态的删除button
 */
@property (nonatomic,strong) UIButton *deleteButton;
/**
 *  评论的button
 */
@property (nonatomic,strong) UIButton *commentButton;
/**
 *  用户发布的内容的文字label
 */
@property (nonatomic,strong) UILabel *contentLabel;
/**
 *  用户的地理位置信息button
 */
@property (nonatomic,strong) UIButton *locationButton;

@end

#define TOPDISTANCE 15
#define AVATARWIDTH 60
#define AVATARDISTANCE 15

@implementation CKMomentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.avatarImageView];
        [self addSubview:self.avatarButton];
        [self addSubview:self.nameLabel];
        [self addSubview:self.backView];
        [self addSubview:self.timeLabel];
        [self addSubview:self.fromLabel];
        [self addSubview:self.deleteButton];
        [self addSubview:self.commentButton];
        [self addSubview:self.contentLabel];
        
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat leftD = 0.03125 * WIDTH_SCREEN;
    _avatarImageView.frame = CGRectMake(leftD, TOPDISTANCE, AVATARWIDTH, AVATARWIDTH);
    
    CGSize nameSize = [self.moment.user.username sizeWithFont:[UIFont systemFontOfSize:16] maxW:MAXFLOAT];
    _nameButton.frame = CGRectMake(leftD + AVATARWIDTH + 10, TOPDISTANCE, nameSize.width, nameSize.height);
    
    CGSize contentSize = [self.moment.moment_text sizeWithFont:[UIFont systemFontOfSize:14] maxW:WIDTH_SCREEN - 20 - leftD + AVATARWIDTH + 10];
    _contentLabel.frame = CGRectMake(leftD + AVATARWIDTH + 10, CGRectGetMaxY(_nameButton.frame) + 10, contentSize.width, contentSize.height);
    
    switch (self.moment.momentType) {
        case CKMomentTypeImage:
            
            break;
        case CKMomentTypeMusic:
            
            break;
        case CKMomentTypeVideo:
            
            break;
        case CKMomentTypeWeb:
            
            break;
        case CKMomentTypeNone:
            
            break;
        default:
            break;
    }
}

- (void)setMoment:(CKMoment *)moment
{
    _moment = moment;
    
    [_nameButton setTitle:moment.user.username forState:UIControlStateNormal];
    
    _avatarImageView.image = [UIImage imageNamed:moment.user.avatarURL];
    
    _contentLabel.text = moment.moment_text;
    
    
    
}

#pragma mark - Common Method
- (void)didClickUserNameButtonWithUser
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickUserAvatarORUserNameWithUser:)]) {
        [_delegate clickUserAvatarORUserNameWithUser:self.moment.user];
    }
}

- (void)didClickUserAvatarButtonWithUser
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickUserAvatarORUserNameWithUser:)]) {
        [_delegate clickUserAvatarORUserNameWithUser:self.moment.user];
    }
}

- (void)didClickUserLocation
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickUserLocation:)]) {
        [_delegate clickUserLocation:self.moment.location];
    }
}

#pragma mark Getter
- (UIImageView *)avatarImageView
{
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc] init];
    }
    return _avatarImageView;
}

- (UIButton *)avatarButton
{
    if (_avatarButton == nil) {
        _avatarButton = [[UIButton alloc] init];
        [_avatarButton addTarget:self action:@selector(didClickUserAvatarButtonWithUser) forControlEvents:UIControlEventTouchDown];
    }
    return _avatarButton;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = [UIColor blueColor];
    }
    return _nameLabel;
}

- (UIButton *)nameButton
{
    if (_nameButton == nil) {
        _nameButton = [[UIButton alloc] init];
        _nameButton.tintColor = [UIColor blueColor];
        _nameButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_nameButton addTarget:self action:@selector(didClickUserNameButtonWithUser) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nameButton;
}

- (UIView *)backView
{
    if (_backView == nil) {
        
    }
    return _backView;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        
    }
    return _timeLabel;
}

- (UILabel *)fromLabel
{
    if (_fromLabel == nil) {
        
    }
    return _fromLabel;
}

- (UIButton *)deleteButton
{
    if (_deleteButton == nil) {
        
    }
    return _deleteButton;
}

- (UIButton *)commentButton
{
    if (_commentButton) {
        
    }
    return _commentButton;
}

- (UILabel *)contentLabel
{
    if (_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        [_contentLabel setFont:[UIFont systemFontOfSize:14]];
        [_contentLabel setTextColor:[UIColor blackColor]];
        
    }
    return _contentLabel;
}

- (UIButton *)locationButton
{
    if (_locationButton == nil) {
        
        _locationButton = [[UIButton alloc] init];
        [_locationButton addTarget:self action:@selector(didClickUserLocation) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _locationButton;
}

@end
