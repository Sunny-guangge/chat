//
//  CKChatBoxFacePageView.h
//  xmppChat
//
//  Created by user on 15/12/10.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKFace.h"

@interface CKChatBoxFacePageView : UIView

@property (nonatomic,weak) id target;
@property (nonatomic,assign) SEL action;
@property (nonatomic,assign) UIControlEvents controEvents;

- (void)showFaceGroup:(CKFaceGroup *)group fromIndex:(int)fromIndex count:(int)count;
- (void)addTarget:(id)target action:(nonnull SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
