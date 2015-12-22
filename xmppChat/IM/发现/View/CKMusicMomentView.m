//
//  CKMusicMomentView.m
//  xmppChat
//
//  Created by user on 15/12/21.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKMusicMomentView.h"

#define WSGColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@interface CKMusicMomentView ()

@property (nonatomic,strong) UIButton *clickButton;

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UILabel *singerLabel;

@end

@implementation CKMusicMomentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = WSGColor(240.0f, 240.0f, 242.0f, 1.0f);
        [self addSubview:self.imageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.singerLabel];
        [self addSubview:self.clickButton];
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _imageView.frame = CGRectMake(5, 5, 40, 40);
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_imageView.frame) + 5, 5, frame.size.width - 55, 20);
    _singerLabel.frame = CGRectMake(CGRectGetMaxX(_imageView.frame) + 5, CGRectGetMaxY(_nameLabel.frame) + 2, frame.size.width - 55, 20);
    _clickButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

- (void)setMusic:(CKMusic *)music
{
    _imageView.image = [UIImage imageNamed:music.music_ImageURL];
    _nameLabel.text = music.music_Name;
    _singerLabel.text = music.music_Singer;
}

- (void)didClickMusic
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickMusicWithMusic:)]) {
        [_delegate clickMusicWithMusic:self.music];
    }
}

- (UIButton *)clickButton
{
    if (_clickButton == nil) {
        _clickButton = [[UIButton alloc] init];
        [_clickButton addTarget:self action:@selector(didClickMusic) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clickButton;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        [_nameLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [_nameLabel setNumberOfLines:1];
        [_nameLabel setBackgroundColor:[UIColor clearColor]];
    }
    return _nameLabel;
}

- (UILabel *)singerLabel
{
    if (_singerLabel == nil) {
        _singerLabel = [[UILabel alloc] init];
        [_singerLabel setFont:[UIFont systemFontOfSize:14]];
        [_singerLabel setBackgroundColor:[UIColor clearColor]];
        [_singerLabel setTextColor:[UIColor grayColor]];
    }
    return _singerLabel;
}

@end
