//
//  CKWebMomentView.m
//  xmppChat
//
//  Created by user on 15/12/21.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKWebMomentView.h"

#define WSGColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@interface CKWebMomentView ()

@property (nonatomic,strong) UIButton *clickButton;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation CKWebMomentView

- (id)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = WSGColor(240.0f, 240.0f, 242.0f, 1.0f);
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.clickButton];
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    
}

- (void)setWeb:(CKWeb *)web
{
    
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        
    }
    return _titleLabel;
}

- (UIButton *)clickButton
{
    if (_clickButton == nil) {
        
    }
    return _clickButton;
}

@end
