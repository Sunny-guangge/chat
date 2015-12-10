//
//  CKChatBoxFaceView.h
//  xmppChat
//
//  Created by user on 15/12/10.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKFace.h"

@protocol CKChatBoxFaceViewDelegate <NSObject>

- (void)chatBoxFaceViewDidSelectedFace:(CKFace *)face type:(CKFaceType)faceType;
- (void)chatBoxFaceViewDeleteButtonDown;
- (void)chatBoxFaceViewSendButtonDown;
- (void)chatBoxFaceViewAddButtonDown;

@end

@interface CKChatBoxFaceView : UIView

@property (nonatomic,weak) id<CKChatBoxFaceViewDelegate>delegate;

@end
