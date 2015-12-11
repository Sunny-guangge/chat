//
//  CKImageMessageTableViewCell.m
//  xmppChat
//
//  Created by user on 15/12/11.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKImageMessageTableViewCell.h"
#import "UIView+TL.h"

@implementation CKImageMessageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self insertSubview:self.messageImageView belowSubview:self.messageBackgroundImageView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float y = self.avatarImageView.originY - 3;
    if (self.message.ownerTyper == CKMessageOwnerTypeSelf) {
        float x = self.avatarImageView.originX - self.messageImageView.frameWidth - 5;
        [self.messageImageView setOrigin:CGPointMake(x , y)];
        [self.messageBackgroundImageView setFrame:CGRectMake(x, y, self.message.messageSize.width+ 10, self.message.messageSize.height + 10)];
    }
    else if (self.message.ownerTyper == CKMessageOwnerTypeOther) {
        float x = self.avatarImageView.originX + self.avatarImageView.frameWidth + 5;
        [self.messageImageView setOrigin:CGPointMake(x, y)];
        [self.messageBackgroundImageView setFrame:CGRectMake(x, y, self.message.messageSize.width+ 10, self.message.messageSize.height + 10)];
    }
}


#pragma mark - Getter and Setter
- (void)setMessage:(CKMessage *)message
{
    [super setMessage:message];
    if(message.imagePath != nil) {
        if (message.imagePath.length > 0) {
            [self.messageImageView setImage:message.image];
        }
        else {
            // network Image
        }
        
        [self.messageImageView setSize:CGSizeMake(message.messageSize.width + 10, message.messageSize.height + 10)];
    }
    switch (self.message.ownerTyper) {
        case CKMessageOwnerTypeSelf:
            self.messageBackgroundImageView.image = [[UIImage imageNamed:@"message_sender_background_reversed"] resizableImageWithCapInsets:UIEdgeInsetsMake(28, 20, 15, 20) resizingMode:UIImageResizingModeStretch];
            break;
        case CKMessageOwnerTypeOther:
            [self.messageBackgroundImageView setImage:[[UIImage imageNamed:@"message_receiver_background_reversed"] resizableImageWithCapInsets:UIEdgeInsetsMake(28, 20, 15, 20) resizingMode:UIImageResizingModeStretch]];
            break;
        default:
            break;
    }
}

- (UIImageView *)messageImageView
{
    if (_messageImageView == nil) {
        _messageImageView = [[UIImageView alloc] init];
        [_messageImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_messageImageView setClipsToBounds:YES];
    }
    return _messageImageView;
}


@end
