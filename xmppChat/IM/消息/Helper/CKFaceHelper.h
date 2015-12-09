//
//  CKFaceHelper.h
//  xmppChat
//
//  Created by user on 15/12/9.
//  Copyright © 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CKFaceHelper : NSObject

@property (nonatomic,strong) NSMutableArray *faceGroupArray;

+ (CKFaceHelper *)shareFaceHelper;

- (NSArray *)getFaceArrayByGroupID:(NSString *)groupID;

@end
