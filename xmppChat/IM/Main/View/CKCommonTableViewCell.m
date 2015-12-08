//
//  CKCommonTableViewCell.m
//  xmppChat
//
//  Created by user on 15/11/25.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKCommonTableViewCell.h"
#import "UIView+TL.h"

@implementation CKCommonTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.topLineStyle = CellLineStyleDefault;
        self.bottomLineStyle = CellLineStyleDefault;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.topLineView setOriginY:0];
    [self.bottomLineView setOriginY:self.frameHeight - _bottomLineView.frameHeight];
    self.topLineStyle = _topLineStyle;
    self.bottomLineStyle = _bottomLineStyle;
}

- (void)setTopLineStyle:(CellLineStyle)topLineStyle
{
    _topLineStyle = topLineStyle;
    
    if (topLineStyle == CellLineStyleDefault) {
        
        [self.topLineView setOriginX:self.leftfreespace];
        [self.topLineView setFrameWidth:self.frameWidth - self.leftfreespace];
        self.topLineView.hidden = NO;
    }
    if (topLineStyle == CellLineStyleFill) {
     
        [self.topLineView setOriginX:0];
        [self.topLineView setFrameWidth:self.frameWidth];
        self.topLineView.hidden = NO;
        
    }
    else if (topLineStyle == CellLineStyleNone) {
        self.topLineView.hidden = YES;
    }
}

- (void)setBottomLineStyle:(CellLineStyle)bottomLineStyle
{
    _bottomLineStyle = bottomLineStyle;
    
    if (bottomLineStyle == CellLineStyleDefault) {
        
        [self.bottomLineView setOriginX:self.leftfreespace];
        [self.bottomLineView setFrameWidth:self.frameWidth - self.leftfreespace];
        self.bottomLineView.hidden = NO;
        
    }
    if (bottomLineStyle == CellLineStyleFill) {
        
        [self.bottomLineView setOriginX:0];
        [self.bottomLineView setFrameWidth:self.frameWidth];
        self.bottomLineView.hidden = NO;
        
    }
    else if (bottomLineStyle == CellLineStyleNone)
    {
        self.bottomLineView.hidden = YES;
    }
    
    
}

- (UIView *)topLineView
{
    if (_topLineView == nil) {
        
        _topLineView = [[UIView alloc] init];
        [_topLineView setFrameHeight:0.5];
        _topLineView.alpha = 0.5;
        _topLineView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_topLineView];
        
    }
    return _topLineView;
}

- (UIView *)bottomLineView
{
    if (_bottomLineView == nil) {
        
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.alpha = 0.5;
        _bottomLineView.backgroundColor = [UIColor grayColor];
        [_bottomLineView setFrameHeight:0.5];
        [self.contentView addSubview:_bottomLineView];
        
    }
    return _bottomLineView;
}


@end
