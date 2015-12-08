//
//  CKMessage.m
//  xmppChat
//
//  Created by user on 15/11/25.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKMessage.h"
#import "Header.h"

static UILabel *label = nil;

@implementation CKMessage

- (id)init
{
    self = [super init];
    
    if (self) {
        
        if (label == nil) {
            label = [[UILabel alloc] init];
            [label setNumberOfLines:0];
            [label setFont:[UIFont systemFontOfSize:16.0f]];
        }
    }
    return self;
}

#pragma mark - Setter
- (void)setText:(NSString *)text
{
    _text = text;
    
    if (text.length > 0) {
//        _attrText = [];
    }
    
}

#pragma mark - Getter
- (void)setMessageType:(CKMessageType)messageType
{
    _messageType = messageType;
    
    switch (messageType) {
        case CKMessageTypeText:
             self.cellIndentify = @"CKTextMessageCell";
            break;
        case CKMessageTypeImage:
            self.cellIndentify = @"CKImageMessageCell";
            break;
        case CKMessageTypeVoice:
            self.cellIndentify = @"CKVoiceMessageCell";
            break;
        case CKMessageTypeSystem:
            self.cellIndentify = @"CKSystemMessageCell";
            break;
        default:
            break;
    }
}

- (CGSize)messageSize
{
    switch (self.messageType) {
        case CKMessageTypeText:
            [label setAttributedText:self.attrText];
            _messageSize = [label sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width * 0.58, MAXFLOAT)];
            break;
        case CKMessageTypeImage:
        {
            NSString *path = [NSString stringWithFormat:@"%@%@",PATH_CHATREC_IMAGE,self.imagePath];
            _image = [UIImage imageNamed:path];
            if (_image != nil) {
                _messageSize = (_image.size.width > WIDTH_SCREEN * 0.5 ? CGSizeMake(WIDTH_SCREEN * 0.5, WIDTH_SCREEN * 0.5 / _image.size.width * _image.size.height) : _image.size);
                _messageSize = (_messageSize.height > 60 ? (_messageSize.height < 200 ? _messageSize : CGSizeMake(_messageSize.width, 200)) : CGSizeMake(60 / _messageSize.height * _messageSize.width, 60));
            }
            else
            {
                _messageSize = CGSizeMake(0, 0);
            }
            break;
        }
        case CKMessageTypeVoice:
            break;
        case CKMessageTypeSystem:
            break;
        default:
            break;
    }
    return _messageSize;
}


- (CGFloat)cellHeight
{
    switch (self.messageType) {
        case CKMessageTypeText:
            return self.messageSize.height + 40 > 60 ? self.messageSize.height + 40 : 60;
            break;
        case CKMessageTypeImage:
            return self.messageSize.height + 20;
            break;
        default:
            break;
    }
    return 0;
}

@end