//
//  CKMomentHeaderView.h
//  xmppChat
//
//  Created by user on 15/12/18.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKUser.h"

@protocol CKMomentHeaderViewDelegate <NSObject>

- (void)clickMomentHeaderBackImage;

- (void)clickMomentHeaderAvatar;

@end

@interface CKMomentHeaderView : UIView

@property (nonatomic,strong) CKUser *user;

@property (nonatomic,strong) UIImage *image;

@property (nonatomic,weak) id<CKMomentHeaderViewDelegate>delegate;

@end
