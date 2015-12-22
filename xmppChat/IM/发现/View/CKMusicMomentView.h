//
//  CKMusicMomentView.h
//  xmppChat
//
//  Created by user on 15/12/21.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKMusic.h"

@protocol CKMusciMomentViewDelegate <NSObject>

- (void)clickMusicWithMusic:(CKMusic *)music;

@end

@interface CKMusicMomentView : UIView

@property (nonatomic,strong) CKMusic *music;

@property (nonatomic,weak) id<CKMusciMomentViewDelegate>delegate;

@end
