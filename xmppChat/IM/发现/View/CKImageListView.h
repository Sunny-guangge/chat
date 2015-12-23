//
//  CKImageListView.h
//  xmppChat
//
//  Created by user on 15/12/23.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CKImageListViewDelegate <NSObject>

- (void)clickImageWitImageArray:(NSMutableArray *)imageArray tag:(NSInteger)tag;

@end

@interface CKImageListView : UIView

@property (nonatomic,weak) id<CKImageListViewDelegate>delegate;

@property (nonatomic,strong) NSMutableArray *imageArray;

@end
