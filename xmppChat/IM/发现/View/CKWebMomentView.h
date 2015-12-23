//
//  CKWebMomentView.h
//  xmppChat
//
//  Created by user on 15/12/21.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKWeb.h"

@protocol CKWebMomentViewDelegate <NSObject>

- (void)clickWebMomentWithWeb:(CKWeb *)web;

@end

@interface CKWebMomentView : UIView

@property (nonatomic,strong) CKWeb *web;

@property (nonatomic,weak) id<CKWebMomentViewDelegate>delegate;

@property (nonatomic,strong) NSMutableArray *array;

@end
