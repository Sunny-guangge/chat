//
//  CKImageListView.m
//  xmppChat
//
//  Created by user on 15/12/23.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKImageListView.h"
#import "CKImage.h"

@implementation CKImageListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)clickImageWithButton:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickImageWitImageArray:tag:)]) {
        [_delegate clickImageWitImageArray:self.imageArray tag:button.tag];
    }
}

- (void)setImageArray:(NSMutableArray *)imageArray
{
    _imageArray = imageArray;
    
    if (imageArray.count == 1) {
        
        CKImage *image = [imageArray objectAtIndex:0];
        
        UIImage *imagea = [UIImage imageNamed:image.image_URL];
        
        
        CGSize imageSize;
        if (imagea.size.width > 0.5 * WIDTH_SCREEN) {
            
            imageSize = CGSizeMake(WIDTH_SCREEN * 0.5, WIDTH_SCREEN * 0.5 / imagea.size.width * imagea.size.height);
            
        }else
        {
            imageSize = imagea.size;
        }
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
        imageView.image = [UIImage imageNamed:image.image_URL];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imageView];
        
        UIButton *button = [[UIButton alloc] init];
        [button addTarget:self action:@selector(clickImageWithButton:) forControlEvents:UIControlEventTouchDown];
        button.tag = 0;
        button.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
        [self addSubview:button];
        
    }else if(imageArray.count == 4)
    {
        
        int x=0;
        int y=0;
        
        CGFloat buttonW = (WIDTH_SCREEN - 100) / 3;
        
        for (NSInteger i=0; i<imageArray.count; i++) {
            
            if (x > 1) {
                x = 0;
                y ++;
            }
            
            if (y == 2) {
                return;
            }
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(x * (buttonW + 5), y * (buttonW + 5), buttonW, buttonW);
            imageView.contentMode = UIViewContentModeScaleToFill;
            imageView.backgroundColor = [UIColor redColor];
            CKImage *image = [imageArray objectAtIndex:i];
            imageView.image = [UIImage imageNamed:image.image_URL];
            [self addSubview:imageView];
            
            UIButton *button = [[UIButton alloc] init];
            button.frame = CGRectMake(x * (buttonW + 5), y * (buttonW + 5), buttonW, buttonW);
            button.tag = i;
            [button addTarget:self action:@selector(clickImageWithButton:) forControlEvents:UIControlEventTouchDown];
            [self addSubview:button];
            
            x ++;
            
        }
        
    }else
    {
        int x=0;
        int y=0;
        
        CGFloat buttonW = (WIDTH_SCREEN - 100) / 3;
        
        for (NSInteger i=0; i<imageArray.count; i++) {
            
            if (x > 2) {
                x = 0;
                y ++;
            }
            
            if (y == 3) {
                return;
            }
            
            CKImage *image = [imageArray objectAtIndex:i];
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = [UIImage imageNamed:image.image_URL];
            imageView.frame = CGRectMake(x * (buttonW + 5), y * (buttonW + 5), buttonW, buttonW);
            imageView.contentMode = UIViewContentModeScaleToFill;
            [self addSubview:imageView];
            
            
            UIButton *button = [[UIButton alloc] init];
            button.frame = CGRectMake(x * (buttonW + 5), y * (buttonW + 5), buttonW, buttonW);
            button.tag = i;
            [button addTarget:self action:@selector(clickImageWithButton:) forControlEvents:UIControlEventTouchDown];
            [self addSubview:button];
            
            x ++;
        }
    }
}

@end
