//
//  CKMomentHeaderView.m
//  xmppChat
//
//  Created by user on 15/12/18.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKMomentHeaderView.h"

@interface CKMomentHeaderView ()

@property (nonatomic,strong) UIImageView *avatarImageView;

@property (nonatomic,strong) UIImageView *backImageView;

@property (nonatomic,strong) UIButton *avatarButton;

@property (nonatomic,strong) UIButton *backButton;

@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UIImageView *blackImageView;

@property (nonatomic,strong) UIView *avatarBackView;

@end

@implementation CKMomentHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.backImageView];
        [self addSubview:self.blackImageView];
        [self addSubview:self.backButton];
        [self addSubview:self.avatarBackView];
        [self.avatarBackView addSubview:self.avatarImageView];
        [self.avatarBackView addSubview:self.avatarButton];
        [self addSubview:self.nameLabel];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _backImageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.width);
    _backButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.width);
    
    //用户个人头像的高度 宽度 70
    _avatarBackView.frame = CGRectMake(frame.size.width - 86, frame.size.width - 58, 76, 76);
    _avatarImageView.frame = CGRectMake(3, 3, 70, 70);
    _avatarButton.frame = CGRectMake(3, 3, 70, 70);
    
    _nameLabel.frame = CGRectMake(20, frame.size.width - 40, frame.size.width - 86 - 25, 40);
}

- (void)setUser:(CKUser *)user
{
    _user = user;
    
    _nameLabel.text = user.username;
    _avatarImageView.image = [UIImage imageNamed:user.avatarURL];
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    _backImageView.image = image;
}

#pragma mark - common method 
- (void)clickAvatar:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickMomentHeaderAvatar)]) {
        [_delegate clickMomentHeaderAvatar];
    }
}

- (void)clickBackImage:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickMomentHeaderBackImage)]) {
        [_delegate clickMomentHeaderBackImage];
    }
}


#pragma mark - Getter
- (UIImageView *)avatarImageView
{
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _avatarImageView;
}

- (UIButton *)avatarButton
{
    if (_avatarButton == nil) {
        _avatarButton = [[UIButton alloc] init];
        [_avatarButton addTarget:self action:@selector(clickAvatar:) forControlEvents:UIControlEventTouchDown];
    }
    return _avatarButton;
}

- (UIImageView *)backImageView
{
    if (_backImageView == nil) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backImageView;
}

- (UIButton *)backButton
{
    if (_backButton == nil) {
        _backButton = [[UIButton alloc] init];
        [_backButton addTarget:self action:@selector(clickBackImage:) forControlEvents:UIControlEventTouchDown];
    }
    return _backButton;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textAlignment = NSTextAlignmentRight;
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

- (UIImageView *)blackImageView
{
    if (_blackImageView == nil) {
        _blackImageView = [[UIImageView alloc] init];
        _blackImageView.backgroundColor = [UIColor blackColor];
        _blackImageView.alpha = 0.5;
    }
    return _blackImageView;
}

- (UIView *)avatarBackView
{
    if (_avatarBackView == nil) {
        _avatarBackView = [[UIView alloc] init];
        _avatarBackView.backgroundColor = [UIColor whiteColor];
        [_avatarBackView.layer setBorderWidth:0.5];
        [_avatarBackView.layer setBorderColor:[UIColor grayColor].CGColor];
        [_avatarBackView.layer setMasksToBounds:YES];
    }
    return _avatarBackView;
}

@end
