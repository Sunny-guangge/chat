//
//  CKCommonTableViewCell.h
//  xmppChat
//
//  Created by user on 15/11/25.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CellLineStyle){
    CellLineStyleDefault,
    CellLineStyleFill,
    CellLineStyleNone,
};



@interface CKCommonTableViewCell : UITableViewCell

/**
 *顶部的线
 */
@property (nonatomic,strong) UIView *topLineView;

/**
 *底部的线
 */
@property (nonatomic,strong) UIView *bottomLineView;

/**
 *线距离左边的距离
 */
@property (nonatomic,assign) CGFloat leftfreespace;

/**
 *顶部线的格式
 */
@property (nonatomic,assign) CellLineStyle topLineStyle;

/**
 *底部线的格式
 */
@property (nonatomic,assign) CellLineStyle bottomLineStyle;

@end
