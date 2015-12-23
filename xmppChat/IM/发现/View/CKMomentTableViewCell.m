//
//  CKMomentTableViewCell.m
//  xmppChat
//
//  Created by user on 15/12/18.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKMomentTableViewCell.h"
#import "NSString+Helper.h"
#import "CKMusicMomentView.h"
#import "CKWebMomentView.h"
#import "CKImageListView.h"
#import <UIKit/UIKit.h>

@interface CKMomentTableViewCell ()<CKImageListViewDelegate,CKMusciMomentViewDelegate,CKWebMomentViewDelegate>
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
 *  图片、音乐、网页链接的背景
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

/**
 *  web信息
 */
@property (nonatomic,strong) CKWebMomentView *webMomentView;

/**
 *  music信息
 */
@property (nonatomic,strong) CKMusicMomentView *musicMomentView;

/**
 *  图片信息
 */
@property (nonatomic,strong) CKImageListView *imageListView;

@end

#define TOPDISTANCE 15
#define AVATARWIDTH 50
#define AVATARDISTANCE 15

@implementation CKMomentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.avatarImageView];
        [self addSubview:self.avatarButton];
        [self addSubview:self.nameLabel];
        [self addSubview:self.nameButton];
        [self addSubview:self.contentLabel];
        [self addSubview:self.backView];
        [self.backView addSubview:self.musicMomentView];
        [self.backView addSubview:self.webMomentView];
        [self.backView addSubview:self.imageListView];
        [self addSubview:self.locationButton];
        [self addSubview:self.timeLabel];
        [self addSubview:self.fromLabel];
        [self addSubview:self.deleteButton];
        [self addSubview:self.commentButton];
        
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat leftD = 0.03125 * WIDTH_SCREEN;
    _avatarImageView.frame = CGRectMake(leftD, TOPDISTANCE, AVATARWIDTH, AVATARWIDTH);
    
    _avatarButton.frame = CGRectMake(leftD, TOPDISTANCE, AVATARWIDTH, AVATARWIDTH);
    
    CGSize nameSize = [self.moment.user.username sizeWithFont:[UIFont systemFontOfSize:16] maxW:MAXFLOAT];
    _nameButton.frame = CGRectMake(leftD + AVATARWIDTH + 10, TOPDISTANCE, nameSize.width, nameSize.height);
    
    CGSize contentSize = [self.moment.moment_text sizeWithFont:[UIFont systemFontOfSize:14] maxW:WIDTH_SCREEN - 20 - leftD - AVATARWIDTH - 10];
    _contentLabel.frame = CGRectMake(leftD + AVATARWIDTH + 10, CGRectGetMaxY(_nameButton.frame) + 5, contentSize.width, contentSize.height);
    
    CGFloat imagew;
    CGFloat imageh;
    
    switch (self.moment.momentType) {
        case CKMomentTypeImage:
            
            if (self.moment.imageArray.count / 3 == 0) {
                imagew = (WIDTH_SCREEN - 100) / 3 * self.moment.imageArray.count;
                imageh = (WIDTH_SCREEN - 100) / 3 + 10;
            }
            else if(self.moment.imageArray.count / 3 == 1)
            {
                
                imagew = (WIDTH_SCREEN - 100);
                imageh = (WIDTH_SCREEN - 100) / 3 * 2;
                
            }else
            {
                imageh = (WIDTH_SCREEN - 100);
                imagew = (WIDTH_SCREEN - 100);
            }
            _backView.frame = CGRectMake(leftD + AVATARWIDTH + 10, CGRectGetMaxY(_contentLabel.frame) + 10, imagew, imageh);
            _imageListView.frame = CGRectMake(0, 0, imagew, imageh);
            _imageListView.hidden = NO;
            _webMomentView.hidden = YES;
            _musicMomentView.hidden = YES;
            break;
        case CKMomentTypeMusic:
            
            _backView.frame = CGRectMake(leftD + AVATARWIDTH + 10, CGRectGetMaxY(_contentLabel.frame) + 10, WIDTH_SCREEN - leftD - AVATARWIDTH - 10 - 15, 50);

            _musicMomentView.frame = CGRectMake(0, 0, WIDTH_SCREEN - leftD - AVATARWIDTH - 10 - 15, 50);
            
            _imageListView.hidden = YES;
            _webMomentView.hidden = YES;
            _musicMomentView.hidden = NO;
            
            break;
        case CKMomentTypeVideo:
            _backView.frame = CGRectMake(leftD + AVATARWIDTH + 10, CGRectGetMaxY(_contentLabel.frame) + 10, WIDTH_SCREEN - leftD + AVATARWIDTH, 0);
            break;
        case CKMomentTypeWeb:
            
            _backView.frame = CGRectMake(leftD + AVATARWIDTH + 10, CGRectGetMaxY(_contentLabel.frame) + 10, WIDTH_SCREEN - leftD - AVATARWIDTH - 10 - 15, 50);
            _webMomentView.frame = CGRectMake(0, 0, WIDTH_SCREEN - leftD - AVATARWIDTH - 10 - 15, 50);
            
            _imageListView.hidden = YES;
            _webMomentView.hidden = NO;
            _musicMomentView.hidden = YES;
            
            break;
        case CKMomentTypeNone:
            
            _backView.frame = CGRectMake(leftD + AVATARWIDTH + 10, CGRectGetMaxY(_contentLabel.frame) + 10, WIDTH_SCREEN - leftD + AVATARWIDTH, 0);
            _imageListView.hidden = YES;
            _webMomentView.hidden = YES;
            _musicMomentView.hidden = YES;
            
            break;
        default:
            break;
    }
    
    if (self.moment.location && self.moment.location.location_String.length > 0) {
        
        CGSize locationSize = [self.moment.location.location_String sizeWithFont:[UIFont systemFontOfSize:14] maxW:MAXFLOAT];
        
        _locationButton.frame = CGRectMake(leftD + AVATARWIDTH + 10, CGRectGetMaxY(self.backView.frame) + 10, locationSize.width, locationSize.height);
        _locationButton.hidden = NO;
        
    }else
    {
        _locationButton.hidden = YES;
    }
    
    if (_locationButton.hidden) {
        CGSize timeSize = [self.moment.time sizeWithFont:[UIFont systemFontOfSize:12] maxW:MAXFLOAT];
        _timeLabel.frame = CGRectMake(leftD + AVATARWIDTH + 10, CGRectGetMaxY(_backView.frame) + 5, timeSize.width, timeSize.height);
    }else
    {
        CGSize timeSize = [self.moment.time sizeWithFont:[UIFont systemFontOfSize:12] maxW:MAXFLOAT];
        _timeLabel.frame = CGRectMake(leftD + AVATARWIDTH + 10, CGRectGetMaxY(_locationButton.frame) + 5, timeSize.width, timeSize.height);
    }
    
    
    
    if (self.moment.from && self.moment.from.length > 0) {
        CGSize fromSize = [self.moment.from sizeWithFont:[UIFont systemFontOfSize:12] maxW:MAXFLOAT];
        
        _fromLabel.frame = CGRectMake(CGRectGetMaxX(_timeLabel.frame) + 10, _timeLabel.frame.origin.y, fromSize.width, fromSize.height);
        _fromLabel.hidden = NO;
    }else
    {
        _fromLabel.hidden = YES;
    }
    
    _commentButton.frame = CGRectMake(WIDTH_SCREEN - 38, CGRectGetMaxY(_locationButton.frame) + 5, 23, 23);
}

- (void)setMoment:(CKMoment *)moment
{
    _moment = moment;
    
    [_nameButton setTitle:moment.user.username forState:UIControlStateNormal];
    
    _avatarImageView.image = [UIImage imageNamed:moment.user.avatarURL];
    
    _contentLabel.text = moment.moment_text;
    
    _imageListView.imageArray = moment.imageArray;
    
    _musicMomentView.music = moment.music;
    
    _webMomentView.web = moment.web;
    
    if (self.moment.location && self.moment.location.location_String.length > 0) {
        
        [_locationButton setTitle:self.moment.location.location_String forState:UIControlStateNormal];
        _locationButton.hidden = NO;
        
    }
    
    _timeLabel.text = self.moment.time;
    _fromLabel.text = self.moment.from;
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

- (void)didClickDeleteUserSendMoment
{
    
}

#pragma mark - CKImageListViewDelegate
- (void)clickImageWitImageArray:(NSMutableArray *)imageArray tag:(NSInteger)tag
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickUserImageWithImageArray:tag:)]) {
        [_delegate clickUserImageWithImageArray:imageArray tag:tag];
    }
}

#pragma mark - CKMusciMomentViewDelegate
- (void)clickMusicWithMusic:(CKMusic *)music
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickUserMusicWithMusic:)]) {
        [_delegate clickUserMusicWithMusic:music];
    }
}

#pragma mark - CKWebMomentViewDelegate
- (void)clickWebMomentWithWeb:(CKWeb *)web
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickUserWebWithWeb:)]) {
        [_delegate clickUserWebWithWeb:web];
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
        _nameLabel.hidden = YES;
    }
    return _nameLabel;
}

- (UIButton *)nameButton
{
    if (_nameButton == nil) {
        _nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nameButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _nameButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_nameButton addTarget:self action:@selector(didClickUserNameButtonWithUser) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nameButton;
}

- (UIView *)backView
{
    if (_backView == nil) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor clearColor];
    }
    return _backView;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _timeLabel;
}

- (UILabel *)fromLabel
{
    if (_fromLabel == nil) {
        _fromLabel = [[UILabel alloc] init];
        _fromLabel.textColor = [UIColor grayColor];
        _fromLabel.font = [UIFont systemFontOfSize:12];
    }
    return _fromLabel;
}

- (UIButton *)deleteButton
{
    if (_deleteButton == nil) {
        _deleteButton = [[UIButton alloc] init];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(didClickDeleteUserSendMoment) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (UIButton *)commentButton
{
    if (_commentButton) {
        _commentButton = [[UIButton alloc] init];
        [_commentButton setImage:[UIImage imageNamed:@"Airobot_DynamicDetail_comment"] forState:UIControlStateNormal];
    }
    return _commentButton;
}

- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        
        _contentLabel = [[UILabel alloc] init];
        [_contentLabel setFont:[UIFont systemFontOfSize:14]];
        [_contentLabel setTextColor:[UIColor blackColor]];
        _contentLabel.numberOfLines = 0;
        
    }
    return _contentLabel;
}

- (UIButton *)locationButton
{
    if (_locationButton == nil) {
        
        _locationButton = [[UIButton alloc] init];
        [_locationButton addTarget:self action:@selector(didClickUserLocation) forControlEvents:UIControlEventTouchUpInside];
        [_locationButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_locationButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
    }
    return _locationButton;
}

- (CKImageListView *)imageListView
{
    if (_imageListView == nil) {
        _imageListView = [[CKImageListView alloc] init];
        _imageListView.hidden = YES;
    }
    return _imageListView;
}

- (CKMusicMomentView *)musicMomentView
{
    if (_musicMomentView == nil) {
        _musicMomentView = [[CKMusicMomentView alloc] init];
        _musicMomentView.hidden = YES;
    }
    return _musicMomentView;
}

- (CKWebMomentView *)webMomentView
{
    if (_webMomentView == nil) {
        _webMomentView = [[CKWebMomentView alloc] init];
        _webMomentView.hidden = YES;
    }
    return _webMomentView;
}

@end
