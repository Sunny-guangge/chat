//
//  CKShakeMenuButton.m
//  xmppChat
//
//  Created by user on 15/12/17.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKShakeMenuButton.h"

@interface CKShakeMenuButton ()
{
    UIImageView *imageView;
    UILabel *titleLabel;
}
@end

@implementation CKShakeMenuButton

- (id)initWithFrame:(CGRect)frame
              image:(NSString *)image
           SelImage:(NSString *)selImage
              title:(NSString *)title
             target:(id)target
             action:(SEL)action
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addTarget:target action:action forControlEvents:UIControlEventTouchDown];
        
        _image = [UIImage imageNamed:image];
        _selImage = [UIImage imageNamed:selImage];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 32)];
        [imageView setImage:_image];
        [self addSubview:imageView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 20, frame.size.width, 10)];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setText:title];
        [titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:titleLabel];
        
    }
    return self;
}
- (void) setChoosed:(BOOL)choose
{
    if (choose) {
        [imageView setImage:_selImage];
        [titleLabel setTextColor:DEFAULT_GREEN_COLOR];
    }
    else {
        [imageView setImage:_image];
        [titleLabel setTextColor:[UIColor whiteColor]];
    }
}

@end
