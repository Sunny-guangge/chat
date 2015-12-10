//
//  CKChatBoxMoreItem.h
//  xmppChat
//
//  Created by user on 15/12/10.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKChatBoxMoreItem : UIView

@property (nonatomic, strong) NSString *title;
@property (nonatomic,strong) NSString *imageName;

+ (CKChatBoxMoreItem *)createChatBoxMoreItemWithTitle:(NSString *)title
                                            imageName:(NSString *)imageName;

- (void)addTarget:(id)target action:(nonnull SEL)action  forControlEvents:(UIControlEvents)controlEvents;

@end
