//
//  CKMoment.m
//  xmppChat
//
//  Created by user on 15/12/21.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKMoment.h"
#import "NSString+Helper.h"

#define TOPDISTANCE 15
#define AVATARWIDTH 60
#define AVATARDISTANCE 15

@implementation CKMoment

- (CGFloat)cellHeight
{
    CGFloat cellH = 45.0f; //用户名、到顶部的距离
    
    CGFloat leftD = 0.03125 * WIDTH_SCREEN;
    
    cellH += [self.moment_text sizeWithFont:[UIFont systemFontOfSize:14] maxW:WIDTH_SCREEN - 20 - leftD + AVATARWIDTH + 10].height + 10;
    
    CGFloat imagew;
    CGFloat imageh;
    
    switch (self.momentType) {
        case CKMomentTypeImage:
            
            if (self.imageArray.count / 3 == 0) {
                imagew = (WIDTH_SCREEN - 100) / 3 * self.imageArray.count;
                imageh = (WIDTH_SCREEN - 100) / 3 + 10;
            }
            else if(self.imageArray.count / 3 == 1)
            {
                
                imagew = (WIDTH_SCREEN - 100);
                imageh = (WIDTH_SCREEN - 100) / 3 * 2;
                
            }else
            {
                imageh = (WIDTH_SCREEN - 100);
                imagew = (WIDTH_SCREEN - 100);
            }
            cellH += imageh;
            break;
        case CKMomentTypeMusic:
            
            cellH += 50;
            
            break;
        case CKMomentTypeVideo:
            cellH += 0;
            break;
        case CKMomentTypeWeb:
            
            cellH += 50;
            
            break;
        case CKMomentTypeNone:
            
            cellH += 0;
            
            break;
        default:
            break;
    }
    
    if (self.location && self.location.location_String.length > 0) {
        
        cellH += [self.location.location_String sizeWithFont:[UIFont systemFontOfSize:14] maxW:MAXFLOAT].height + 5;
    }
    
    cellH += [self.time sizeWithFont:[UIFont systemFontOfSize:12] maxW:MAXFLOAT].height + 30;
    
    return cellH;
}

@end
