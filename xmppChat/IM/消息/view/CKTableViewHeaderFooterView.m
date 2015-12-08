//
//  CKTableViewHeaderFooterView.m
//  xmppChat
//
//  Created by user on 15/11/30.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKTableViewHeaderFooterView.h"
#import "UIView+TL.h"

static UITextView *sTextView = nil;

@implementation CKTableViewHeaderFooterView

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setUserInteractionEnabled:NO];
        _textView = [[UITextView alloc] init];
        [_textView setBackgroundColor:[UIColor clearColor]];
        [_textView setFont:[UIFont systemFontOfSize:14.0f]];
        [_textView setTextColor:[UIColor grayColor]];
        [self addSubview:_textView];
        
    }
    
    return self;
}

- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    float x = frame.size.width * 0.04;
    float w = frame.size.width - x * 2;
    [self.textView setFrame:CGRectMake(x, 0, w, self.frameHeight)];
}

- (void) setText:(NSString *)text
{
    _text = text;
    [self.textView setText:text];
}

+ (CGFloat) heightForTextToFitView:(NSString *)text
{
    if (sTextView == nil) {
        sTextView = [[UITextView alloc] init];
        [sTextView setFont:[UIFont systemFontOfSize:14.0f]];
    }
    [sTextView setText:text];
    float w = [UIScreen mainScreen].bounds.size.width * 0.92;
    return [sTextView sizeThatFits:CGSizeMake(w, MAXFLOAT)].height;
}


@end
