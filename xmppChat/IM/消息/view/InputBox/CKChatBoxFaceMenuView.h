//
//  CKChatBoxFaceMenuView.h
//  xmppChat
//
//  Created by user on 15/12/10.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKFace.h"

@class CKChatBoxFaceMenuView;
@protocol CKChatBoxFaceMenuViewDelegate <NSObject>

- (void) chatBoxFaceMenuViewAddButtonDown;
- (void) chatBoxFaceMenuViewSendButtonDown;
- (void) chatBoxFaceMenuView: (CKChatBoxFaceMenuView *)chatBoxFaceMenuView didSelectedFaceMenuIndex:(NSInteger)index;

@end


@interface CKChatBoxFaceMenuView : UIView

@property (nonatomic,weak) id<CKChatBoxFaceMenuViewDelegate>delegate;
@property (nonatomic,strong) NSMutableArray *faceGroupArray;

@end
