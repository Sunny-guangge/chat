//
//  CKFaceHelper.m
//  xmppChat
//
//  Created by user on 15/12/9.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKFaceHelper.h"
#import "CKFace.h"

static CKFaceHelper *faceHelper = nil;

@implementation CKFaceHelper


+ (CKFaceHelper *)shareFaceHelper
{
    if (faceHelper == nil) {
        faceHelper = [[CKFaceHelper alloc] init];
    }
    return faceHelper;
}

//返回的数组里 存储的是一个类型的表情的id和name
- (NSArray *)getFaceArrayByGroupID:(NSString *)groupID
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:groupID ofType:@"plist"]];
    
    NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:array.count];
    
    for (NSDictionary *dic in array) {
        CKFace *face = [[CKFace alloc] init];
        face.faceID = [dic objectForKey:@"face_id"];
        face.faceName = [dic objectForKey:@"face_name"];
        [data addObject:face];
    }
    return data;
}

//返回的是所有的表情类型的数组
- (NSMutableArray *)faceGroupArray
{
    if (_faceGroupArray == nil) {
        _faceGroupArray = [[NSMutableArray alloc] init];
        
        CKFaceGroup *group = [[CKFaceGroup alloc] init];
        group.faceType = CKFaceTypeEmoji;
        group.groupID = @"normal_face";
        group.groupImageName = @"EmotionsEmojiHL";
        group.facesArray = nil;
        [_faceGroupArray addObject:group];
    }
    return _faceGroupArray;
}

@end