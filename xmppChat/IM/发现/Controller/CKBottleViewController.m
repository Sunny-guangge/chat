//
//  CKBottleViewController.m
//  xmppChat
//
//  Created by user on 15/12/17.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKBottleViewController.h"
#import "UIView+TL.h"
#import "CKShakeMenuButton.h"

@interface CKBottleViewController ()
{
    NSTimer *timer;
    UITapGestureRecognizer *tapGesture;
}

@property (nonatomic,strong) UIBarButtonItem *rightBarButtonItem;

@property (nonatomic,strong) UIView *backView;

@end


@implementation CKBottleViewController


- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.backView];
    
    self.navigationItem.title = @"漂流瓶";
    
    self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(tryHiddenNavBar) userInfo:nil repeats:NO];
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self hideNavBar:NO];
}

#pragma mark - Common Method
- (void) tryHiddenNavBar
{
    [timer invalidate];
    [self hideNavBar:YES];
}

- (void) didTapView
{
    [timer invalidate];
    [self hideNavBar:![self.navigationController.navigationBar isHidden]];
}



- (void)didClickRightBarButtonItem
{
    
}

- (void)hideNavBar:(BOOL)hide
{
    if (hide) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        [UIView animateWithDuration:0.5 animations:^{
            [self.navigationController.navigationBar setOriginY: -HEIGHT_NAVBAR - HEIGHT_STATUSBAR];
        } completion:^(BOOL finished) {
            [self.navigationController.navigationBar setHidden:YES];
        }];
        
    }else
    {
        [self.navigationController.navigationBar setHidden:NO];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        [UIView animateWithDuration:0.2 animations:^{
            [self.navigationController.navigationBar setOriginY:HEIGHT_STATUSBAR];
        }];
    }
}

#pragma mark - Getter
- (UIView *)backView
{
    if (_backView == nil) {
        
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN)];
        _backView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *backImageView = [[UIImageView alloc] initWithFrame:_backView.frame];
        NSDate *date = [NSDate date];
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"HH"];
        NSInteger hour = [[dateformatter stringFromDate:date] integerValue];
        if (hour >= 6 && hour <= 18 ) {
            backImageView.image = [UIImage imageNamed:@"bottleBkg.jpg"];
        }else
        {
            backImageView.image = [UIImage imageNamed:@"bottleNightBkg.jpg"];
        }
        [_backView addSubview:backImageView];
        
        float h = WIDTH_SCREEN / 640 * 92;
        UIImageView *bottomImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottleBoard"]];
        [bottomImageView setFrame:CGRectMake(0, HEIGHT_SCREEN - h, WIDTH_SCREEN, h)];
        [_backView addSubview:bottomImageView];
        
    }
    return _backView;
}

- (UIBarButtonItem *)rightBarButtonItem
{
    if (_rightBarButtonItem == nil) {
        _rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_set"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickRightBarButtonItem)];
    }
    return _rightBarButtonItem;
}

@end
