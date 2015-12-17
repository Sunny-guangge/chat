//
//  CKShakeMenuButton.h
//  xmppChat
//
//  Created by user on 15/12/17.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKShakeMenuButton : UIButton

@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) UIImage *selImage;

- (id)initWithFrame:(CGRect)frame
              image:(NSString *)image
           SelImage:(NSString *)selImage
              title:(NSString *)title
             target:(id)target
             action:(SEL)action;
- (void) setChoosed:(BOOL)choose;
@end
