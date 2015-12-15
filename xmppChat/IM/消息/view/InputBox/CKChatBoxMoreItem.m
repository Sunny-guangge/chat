//
//  CKChatBoxMoreItem.m
//  xmppChat
//
//  Created by user on 15/12/10.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKChatBoxMoreItem.h"
#import "UIView+TL.h"

@interface CKChatBoxMoreItem ()

@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UILabel *titleLabel;

@end


@implementation CKChatBoxMoreItem

+ (CKChatBoxMoreItem *)createChatBoxMoreItemWithTitle:(NSString *)title
                                            imageName:(NSString *)imageName
{
    CKChatBoxMoreItem *item = [[CKChatBoxMoreItem alloc] init];
    
    item.title = title;
    item.imageName = imageName;
    
    return item;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
                
        [self addSubview:self.button];
        [self addSubview:self.titleLabel];
        
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    float w = 59;
    [self.button setFrame:CGRectMake((self.frameWidth - w) / 2, 0, w, w)];
    [self.titleLabel setFrame:CGRectMake(-5, self.button.frameHeight + 5, self.frameWidth + 10, 15)];
}


- (void)addTarget:(id)target action:(nonnull SEL)action  forControlEvents:(UIControlEvents)controlEvents
{
    [self.button addTarget:target action:action forControlEvents:controlEvents];
}

- (void)setTag:(NSInteger)tag
{
    [super setTag:tag];
    
    [self.button setTag:tag];
}

#pragma mark - setter
- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    
    [self.button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    [self.titleLabel setText:title];
}


#pragma mark - getter
- (UIButton *)button
{
    if (_button == nil) {
        
        _button = [[UIButton alloc] init];
        [_button.layer setMasksToBounds:YES];
        [_button.layer setCornerRadius:4.0f];
        [_button.layer setBorderWidth:0.5f];
        [_button.layer setBorderColor:[UIColor grayColor].CGColor];
        
    }
    return _button;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_titleLabel setTextColor:[UIColor grayColor]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}


@end
