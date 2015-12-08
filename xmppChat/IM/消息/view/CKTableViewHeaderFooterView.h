//
//  CKTableViewHeaderFooterView.h
//  xmppChat
//
//  Created by user on 15/11/30.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKTableViewHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic,strong) NSString *text;

@property (nonatomic,strong) UITextView *textView;

+ (CGFloat)heightForTextToFitView:(NSString *)text;

@end
