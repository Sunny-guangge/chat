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
    
    _imageView.frame = CGRectMake(5, 5, 40, 40);
    _titleLabel.frame = CGRectMake(50, 5, frame.size.width - 55, 40);
    _clickButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

- (void)setWeb:(CKWeb *)web
{
    _imageView.image = [UIImage imageNamed:web.web_ImageURL];
    
    _titleLabel.text = web.web_Title;
}

- (void)didCLickWeb
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickWebMomentWithWeb:)]) {
        [_delegate clickWebMomentWithWeb:self.web];
    }
}

#pragma mark - Getter
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 2;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (UIButton *)clickButton
{
    if (_clickButton == nil) {
        _clickButton = [[UIButton alloc] init];
        [_clickButton addTarget:self action:@selector(didCLickWeb) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clickButton;
}

- (NSMutableArray *)array
{
    if (_array == nil) {
        
    }
    return _array;
}

@end
