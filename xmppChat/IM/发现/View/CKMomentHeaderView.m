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

@end

@implementation CKMomentHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.backImageView];
        [self addSubview:self.backButton];
        [self addSubview:self.avatarImageView];
        [self addSubview:self.avatarButton];
        [self addSubview:self.nameLabel];
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    
}

- (void)setUser:(CKUser *)user
{
    
}

- (void)setImage:(UIImage *)image
{
    
}

#pragma mark - Getter
- (UIImageView *)avatarImageView
{
    if (_avatarImageView == nil) {
        
    }
    return _avatarImageView;
}

- (UIButton *)avatarButton
{
    if (_avatarButton == nil) {
        
    }
    return _avatarButton;
}

- (UIImageView *)backImageView
{
    if (_backImageView == nil) {
        
    }
    return _backImageView;
}

- (UIButton *)backButton
{
    if (_backButton == nil) {
        
    }
    return _backButton;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        
    }
    return _nameLabel;
}

@end
