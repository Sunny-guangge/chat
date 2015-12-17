//
//  CKShakeViewController.m
//  xmppChat
//
//  Created by user on 15/12/17.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKShakeViewController.h"
#import "UIView+TL.h"
#import "CKShakeMenuButton.h"

#define SHAKE_HEIGHT 90

@interface CKShakeViewController ()
{
    UIImageView *lineUpImageView;
    UIImageView *lineDownImageView;
}


@property (nonatomic,strong) UIBarButtonItem *barButtonItem;

@property (nonatomic,strong) UIView *upView;
@property (nonatomic,strong) UIView *downView;
@property (nonatomic,strong) UIImageView *centerImageView;

@property (nonatomic,strong) NSMutableArray *menuButtons;

@end

@implementation CKShakeViewController

- (void)viewDidLoad
{
    [self.navigationItem setTitle:@"摇一摇"];
    
//    [self.view setBackgroundColor:[UIColor colorWithRed:42/255 green:45/255 blue:46/255 alpha:1.0f]];
    self.view.backgroundColor = [UIColor redColor];
    
    self.navigationItem.rightBarButtonItem = self.barButtonItem;
    
    [self initSubView];
}

- (void)didClickSetBarButtonItem
{
    
}

// 摇动手机
- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ([lineUpImageView isHidden]) {
        [lineUpImageView setHidden:NO];
        [lineDownImageView setHidden:NO];
        [UIView animateWithDuration:0.5 animations:^{
            _upView.originY -= SHAKE_HEIGHT;
            _downView.originY += SHAKE_HEIGHT;
        } completion:^(BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.5 animations:^{
                    _upView.originY += SHAKE_HEIGHT;
                    _downView.originY -= SHAKE_HEIGHT;
                } completion:^(BOOL finished) {
                    [lineUpImageView setHidden:YES];
                    [lineDownImageView setHidden:YES];
                }];
            });
        }];
    }
}


- (void)menuButtonDown:(CKShakeMenuButton *)button
{
    for (CKShakeMenuButton *shakeButton in self.menuButtons) {

        shakeButton == button ? [shakeButton setChoosed:YES] : [shakeButton setChoosed:NO];

    }
}

- (void)initSubView
{
    float w = self.view.frameWidth;
    float h = self.view.frameHeight * 0.45;
    
    _centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, h - w / 2.2, w, w)];
    [_centerImageView setImage:[UIImage imageNamed:@"ShakeHideImg_women"]];
    [self.view addSubview:_centerImageView];
    
    float logoW = self.view.frameWidth * 0.47;
    float logoH = logoW / 300 * 164;
    float lineH = 10;
    float x = (w - logoW) / 2.0;
    _upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    [self.view addSubview:_upView];
    UIImageView *logoUp = [[UIImageView alloc] initWithFrame:CGRectMake(x, h - logoH, logoW, logoH)];
    [logoUp setImage:[UIImage imageNamed:@"Shake_Logo_Up"]];
    [_upView addSubview:logoUp];
    lineUpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, h - 3, w, lineH)];
    [lineUpImageView setImage:[UIImage imageNamed:@"Shake_Line_Up"]];
    [lineUpImageView setHidden:YES];
    [_upView addSubview:lineUpImageView];
    
    _downView = [[UIView alloc] initWithFrame:CGRectMake(0, h, w, self.view.frameHeight - h)];
    [self.view addSubview:_downView];
    UIImageView *logoDown = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, logoW, logoH)];
    [logoDown setImage:[UIImage imageNamed:@"Shake_Logo_Down"]];
    [_downView addSubview:logoDown];
    lineDownImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 3 - lineH, w, lineH)];
    [lineDownImageView setImage:[UIImage imageNamed:@"Shake_Line_Down"]];
    [lineDownImageView setHidden:YES];
    [_downView addSubview:lineDownImageView];
    
    w = WIDTH_SCREEN / 8.5;
    float space = (WIDTH_SCREEN - w * 3) / 3;
    h = w / 76 * 68 + 32;
    float y = HEIGHT_SCREEN - h - 5;
    x = space * 0.5;
    _menuButtons = [[NSMutableArray alloc] init];

    CKShakeMenuButton *peopleButton = [[CKShakeMenuButton alloc] initWithFrame:CGRectMake(x, y, w, h)
                                                                         image:@"Shake_icon_people"
                                                                      SelImage:@"Shake_icon_peopleHL"
                                                                         title:@"人"
                                                                        target:self
                                                                        action:@selector(menuButtonDown:)];
    peopleButton.tag = 0;
    [peopleButton setChoosed:YES];
    [_menuButtons addObject:peopleButton];
    [self.view addSubview:peopleButton];
    x += w + space;
    CKShakeMenuButton *songButton = [[CKShakeMenuButton alloc] initWithFrame:CGRectMake(x, y, w, h)
                                                                       image:@"Shake_icon_music"
                                                                    SelImage:@"Shake_icon_musicHL"
                                                                       title:@"歌曲"
                                                                      target:self
                                                                      action:@selector(menuButtonDown:)];
    songButton.tag = 1;
    [_menuButtons addObject:songButton];
    [self.view addSubview:songButton];
    x += w + space;
    
    CKShakeMenuButton *tvButton = [[CKShakeMenuButton alloc] initWithFrame:CGRectMake(x, y, w, h)
                                                                     image:@"Shake_icon_tv"
                                                                  SelImage:@"Shake_icon_tvHL"
                                                                     title:@"电视"
                                                                    target:self
                                                                    action:@selector(menuButtonDown:)];

    tvButton.tag = 2;
    [_menuButtons addObject:tvButton];
    [self.view addSubview:tvButton];
}

#pragma mark - Getter
- (UIBarButtonItem *)barButtonItem
{
    if (_barButtonItem == nil) {
        _barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(didClickSetBarButtonItem)];
    }
    return _barButtonItem;
}

@end
