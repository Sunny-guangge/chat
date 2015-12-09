//
//  CKChatHelper.m
//  xmppChat
//
//  Created by user on 15/12/9.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKChatHelper.h"
#import "CKFace.h"
#import "CKFaceHelper.h"
#import <UIKit/UIKit.h>

@implementation CKChatHelper

+ (NSAttributedString *)formatMessageStrign:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    //通过正则表达式来匹配字符串
    NSString *regex_emoji = @"\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]";
    
    NSError *error = nil;
    
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regex_emoji options:NSRegularExpressionCaseInsensitive error:&error];
    
    if (!re) {
        NSLog(@"%@",[error localizedDescription]);
        return attributedString;
    }
    
    NSArray *resultArray = [re matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    
    //获取所有表情及位置
    //用来存放字典，字典中存储的是图片和图片对应的位置
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    //根据匹配范围来用图片进行相应的替换
    for (NSTextCheckingResult *match in resultArray)
    {
        //获取数组元素中得到range
        NSRange range = [match range];
        //获取原字符串中对应的值
        NSString *subStr = [text substringWithRange:range];
        
        CKFaceGroup *group = [[[CKFaceHelper shareFaceHelper] faceGroupArray] objectAtIndex:0];
        
        for (CKFace *face in group.facesArray)
        {
            if ([face.faceName isEqualToString:subStr])
            {
                //face[i][@"png"]就是我们要加载的图片
                //新建文字附件来存放我们的图片，iOS7才新加的对象
                NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
                //给附件添加图片
                textAttachment.image = [UIImage imageNamed:face.faceName];
                //调整一下图片的位置，如果你的图片偏上或者偏下，调整一下bounds的y值即可
                textAttachment.bounds = CGRectMake(0, -4, 20, 20);
                //把附件转换成可变字符串，用于替换掉源字符串中得表情文字
                NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
                //把图片和图片对应的位置存入字典中
                NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
                [imageDic setObject:imageStr forKey:@"image"];
                [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
                //把字典存入数组中
                [imageArray addObject:imageDic];
            }
        }
    }
    
    //从后往前替换，否则会引起位置问题
    for (int i = (int)imageArray.count - 1; i>=0; i--) {
        NSRange range;
        [imageArray[i][@"range"] getValue:&range];
        
        //进行替换
        [attributedString replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];
    }
    
    return attributedString;
}

@end
