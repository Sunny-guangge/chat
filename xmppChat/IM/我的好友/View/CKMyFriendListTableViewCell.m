//
//  CKMyFriendListTableViewCell.m
//  xmppChat
//
//  Created by user on 15/11/26.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKMyFriendListTableViewCell.h"
#import "UIView+TL.h"

@interface CKMyFriendListTableViewCell ()

@property (nonatomic,strong) UIImageView *avatarImageView;

@property (nonatomic,strong) UILabel *nameLabel;

@end


@implementation CKMyFriendListTableViewCell

+ (instancetype)friendListTableViewCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"CKFriendListTableViewCell";
    
    CKMyFriendListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[CKMyFriendListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self addSubview:self.avatarImageView];
        [self addSubview:self.nameLabel];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    
    self.leftfreespace = self.frameHeight * 0.18;
    [super layoutSubviews];
    
    float spaceX = self.frameHeight * 0.18;
    float spaceY = self.frameHeight * 0.17;
    float imageWidth = self.frameHeight - spaceY * 2;
    [_avatarImageView setFrame:CGRectMake(spaceX, spaceY, imageWidth, imageWidth)];
    
    float labelX = imageWidth + spaceX * 2;
    float labelWidth = self.frameWidth - labelX - spaceX * 1.5;
    [_nameLabel setFrame:CGRectMake(labelX, spaceY, labelWidth, imageWidth)];
    
    
}

- (void)setUser:(CKUser *)user
{
    _avatarImageView.image = [UIImage imageNamed:user.avatarURL];
    _nameLabel.text = user.username;
}

- (UIImageView *)avatarImageView
{
    if (_avatarImageView == nil) {
        
        _avatarImageView = [[UIImageView alloc] init];
        
    }
    return _avatarImageView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        
        _nameLabel = [[UILabel alloc] init];
        
    }
    return _nameLabel;
}


@end
