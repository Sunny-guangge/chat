//
//  CKChatBoxMoreView.h
//  xmppChat
//
//  Created by user on 15/12/10.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKChatBoxMoreItem.h"

typedef NS_ENUM(NSInteger, CKChatBoxItem) {
    CKChatBoxItemAlbum,
    CKChatBoxItemCamera,
};

@class CKChatBoxMoreView;
@protocol CKChatBoxMoreViewDelegate <NSObject>

- (void)chatBoxMoreView:(CKChatBoxMoreView *)chatBoxMoreView didSelectItem:(CKChatBoxItem )itemType;

@end

@interface CKChatBoxMoreView : UIView

@property (nonatomic,weak) id<CKChatBoxMoreViewDelegate>delegate;

@property (nonatomic,strong) NSMutableArray *items;

@end
