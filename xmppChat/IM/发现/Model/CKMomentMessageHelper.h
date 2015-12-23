//
//  CKMomentMessageHelper.h
//  xmppChat
//
//  Created by user on 15/12/23.
//  Copyright © 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CKMomentMessageHelper : NSObject

+ (CKMomentMessageHelper *)shareMomentMessageHelper;

- (NSMutableArray *)getUserMomentMessage;

@end
