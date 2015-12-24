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

static CGRect oldframe;

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

    UIImageView *imageView = (UIImageView *)[self viewWithTag:button.tag + 10];
    
    [self showImageWithUIImageView:imageView];
    
}


- (void)showImageWithUIImageView:(UIImageView *)avatarImageView
{
    UIImage *image=avatarImageView.image;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
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
        imageView.tag = 0 + 10;
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
            imageView.tag = i + 10;
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
            imageView.tag = i + 10;
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
