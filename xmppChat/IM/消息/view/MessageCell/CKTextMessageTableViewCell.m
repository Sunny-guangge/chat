//
//  CKTextMessageTableViewCell.m
//  xmppChat
//
//  Created by user on 15/12/11.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKTextMessageTableViewCell.h"
#import "UIView+TL.h"

@implementation CKTextMessageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self addSubview:self.messageLabel];
        
    }
    
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float y = self.avatarImageView.originY + 11;
    float x = self.avatarImageView.originX + (self.message.ownerTyper == CKMessageOwnerTypeSelf ? - self.messageLabel.frameWidth - 27 : self.avatarImageView.frameWidth + 23);
    [self.messageLabel setOrigin:CGPointMake(x, y)];
    
    x -= 18;                                    // 左边距离头像 5
    y = self.avatarImageView.originY - 5;       // 上边与头像对齐 (北京图像有5个像素偏差)
    float h = MAX(self.messageLabel.frameHeight + 30, self.avatarImageView.frameHeight + 10);
    [self.messageBackgroundImageView setFrame:CGRectMake(x, y, self.messageLabel.frameWidth + 40, h)];
}

- (void)setMessage:(CKMessage *)message
{
    [super setMessage:message];
    
    [_messageLabel setAttributedText:message.attrText];
    _messageLabel.size = message.messageSize;
}

- (UILabel *)messageLabel
{
    if (_messageLabel == nil) {
        
        _messageLabel = [[UILabel alloc] init];
        [_messageLabel setNumberOfLines:0];
        [_messageLabel setFont:[UIFont systemFontOfSize:16.0f]];
        
    }
    return _messageLabel;
}

@end
