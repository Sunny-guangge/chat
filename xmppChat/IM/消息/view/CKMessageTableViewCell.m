//
//  CKMessageTableViewCell.m
//  xmppChat
//
//  Created by user on 15/11/25.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKMessageTableViewCell.h"
#import "UIView+TL.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"

@interface CKMessageTableViewCell ()

@property (nonatomic,strong) UIImageView *avatarImageView;

@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UILabel *timeLabel;

@property (nonatomic,strong) UILabel *contentLabel;

@end

@implementation CKMessageTableViewCell

+ (instancetype)messageTableViewCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"CKMessageTableViewCell";
    
    CKMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[CKMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.avatarImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.contentLabel];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    self.leftfreespace = self.frameHeight * 0.14;
    
    [super layoutSubviews];
    
    CGFloat avatarW = self.frameHeight * 0.72;
    float space = self.leftfreespace;
    [_avatarImageView setFrame:CGRectMake(space, space, avatarW, avatarW)];
    
    float labelX = space * 2 + avatarW;
    float labelY = self.frameHeight * 0.135;
    float labelH = self.frameHeight * 0.4;
    float labelW = self.frameWidth - labelX - space * 1.5;
    
    float dateWidth = 70;
    float dateH = labelH * 0.75;
    float dateX = self.frameWidth - space * 1.5 - dateWidth;
    [_timeLabel setFrame:CGRectMake(dateX, labelY * 0.7, dateWidth, dateH)];
    
    
    float nameLabelW = self.frameWidth - labelX - dateWidth - space * 2;
    [_nameLabel setFrame:CGRectMake(labelX, labelY, nameLabelW, labelH)];
    
    labelY = self.frameHeight * 0.91 - labelH;
    [_contentLabel setFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    
}


- (void)setMessage:(CKMessage *)message
{
//    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:message.message_AvatarURL]];
//    self.avatarImageView.image = [UIImage imageNamed:@"JustChat_User_avatar"];
    self.avatarImageView.image = [UIImage imageNamed:message.message_AvatarURL];
    self.nameLabel.text = message.message_Name;
    self.timeLabel.text = message.message_Time;
    self.contentLabel.text = message.message_Content;
}

- (UIImageView *)avatarImageView
{
    if (_avatarImageView == nil) {
        
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.cornerRadius = 5;
        _avatarImageView.layer.masksToBounds = YES;
        
    }
    
    return _avatarImageView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return _nameLabel;
}

- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = [UIColor grayColor];
        
    }
    
    return _contentLabel;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.alpha = 0.8;
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        
    }
    return _timeLabel;
}



@end
