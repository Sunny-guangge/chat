//
//  CKFounctionCell.h
//  xmppChat
//
//  Created by user on 15/11/30.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKCommonTableViewCell.h"
#import "CKSetting.h"

@interface CKFounctionCell : CKCommonTableViewCell

//一般type
@property (nonatomic,strong) CKSettingItem *item;
@property (nonatomic,assign) CGFloat titleFontSize;
@property (nonatomic,assign) CGFloat subTitleFontSize;
@property (nonatomic,assign) UIColor *subTitleFontColor;

//buttonType
@property (nonatomic,assign) UIColor *buttonTitleColor;
@property (nonatomic,assign) UIColor *buttonBackgroundGColor;

- (void)addTarget:(id)target action:(nonnull SEL)action;
@end
