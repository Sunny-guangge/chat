//
//  CKMessageCommonTableViewCell.m
//  xmppChat
//
//  Created by user on 15/12/11.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKMessageCommonTableViewCell.h"
#import "UIView+TL.h"

@interface CKMessageCommonTableViewCell ()

@end

@implementation CKMessageCommonTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.avatarImageView];
        [self addSubview:self.messageBackgroundImageView];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_message.ownerTyper == CKMessageOwnerTypeSelf) {
        [self.avatarImageView setOrigin:CGPointMake(self.frameWidth - 10 - self.avatarImageView.frameWidth, 10)];
    }else if (_message.ownerTyper == CKMessageOwnerTypeOther)
    {
        [self.avatarImageView setOrigin:CGPointMake(10, 10)];
    }
}

#pragma mark - Getter and Setter
- (void)setMessage:(CKMessage *)message
{
    _message = message;
    
    switch (message.ownerTyper) {
        case CKMessageOwnerTypeSelf:
            self.avatarImageView.hidden = NO;
            [self.avatarImageView setImage:[UIImage imageNamed:message.fromUser.avatarURL]];
            [self.messageBackgroundImageView setHidden:NO];
            self.messageBackgroundImageView.image = [[UIImage imageNamed:@"message_sender_background_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(28, 20, 15, 20) resizingMode:UIImageResizingModeStretch];
            self.messageBackgroundImageView.highlightedImage = [[UIImage imageNamed:@"message_sender_background_highlight"] resizableImageWithCapInsets:UIEdgeInsetsMake(28, 20, 15, 20) resizingMode:UIImageResizingModeStretch];
            break;
        case CKMessageOwnerTypeOther:
            self.avatarImageView.hidden = NO;
            [self.avatarImageView setImage:[UIImage imageNamed:message.fromUser.avatarURL]];
            [self.messageBackgroundImageView setHidden:NO];
            [self.messageBackgroundImageView setImage:[[UIImage imageNamed:@"message_receiver_background_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(28, 20, 15, 20) resizingMode:UIImageResizingModeStretch]];
            [self.messageBackgroundImageView setHighlightedImage:[[UIImage imageNamed:@"message_receiver_background_highlight"] resizableImageWithCapInsets:UIEdgeInsetsMake(28, 20, 15, 20) resizingMode:UIImageResizingModeStretch]];
            break;
        case CKMessageOwnerTypeSystem:
            [self.avatarImageView setHidden:YES];
            [self.messageBackgroundImageView setHidden:YES];
            break;
        default:
            break;
    }
}

- (UIImageView *)avatarImageView
{
    
    if (_avatarImageView == nil) {
        float imageWidth = 40;
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageWidth, imageWidth)];
        [_avatarImageView setHidden:YES];
    }
    
    return _avatarImageView;
}

- (UIImageView *)messageBackgroundImageView
{
    
    if (_messageBackgroundImageView == nil) {
        
        _messageBackgroundImageView = [[UIImageView alloc] init];
        [_messageBackgroundImageView setHidden:YES];
    }
    
    return _messageBackgroundImageView;
}

@end
