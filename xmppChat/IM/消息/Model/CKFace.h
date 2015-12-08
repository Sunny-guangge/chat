//
//  CKFace.h
//  xmppChat
//
//  Created by user on 15/12/8.
//  Copyright © 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CKFaceType) {
    CKFaceTypeEmoji,
    CKFaceTypeGIF,
};

@interface CKFace : NSObject

@property (nonatomic,strong) NSString *faceID;
@property (nonatomic,strong) NSString *faceName;

@end

@interface CKFaceGroup : NSObject

@property (nonatomic,assign) CKFaceType faceType;
@property (nonatomic,strong) NSString *groupID;
@property (nonatomic,strong) NSString *groupImageName;
@property (nonatomic,strong) NSArray *facesArray;

@end
