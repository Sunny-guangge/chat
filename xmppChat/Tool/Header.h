//
//  Header.h
//  xmppChat
//
//  Created by user on 15/11/20.
//  Copyright © 2015年 user. All rights reserved.
//

#ifndef Header_h
#define Header_h



#pragma mark - Color
#define     DEFAULT_NAVBAR_COLOR            [UIColor colorWithRed:20.0/255.0 green:20.0/255.0 blue:20.0/255.0 alpha:0.9]
#define     DEFAULT_BACKGROUND_COLOR        [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:246.0/255.0 alpha:1.0]
#define     DEFAULT_SEARCHBAR_COLOR         [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0]
#define     DEFAULT_GREEN_COLOR             [UIColor colorWithRed:2.0/255 green:187.0/255  blue:0.0/255 alpha:1.0f]
#define     DEFAULT_TEXT_GRAY_COLOR         [UIColor grayColor]
#define     DEFAULT_LINE_GRAY_COLOR         [UIColor colorWithRed:188.0/255 green:188.0/255  blue:188.0/255 alpha:0.6f]
#define     DEFAULT_CHATBOX_COLOR           [UIColor colorWithRed:244.0/255 green:244.0/255 blue:246.0/255 alpha:1.0f]



#define WIDTH_SCREEN        [UIScreen mainScreen].bounds.size.width
#define HEIGHT_SCREEN       [UIScreen mainScreen].bounds.size.height
#define HEIGHT_STATUSBAR	20
#define HEIGHT_TABBAR       49
#define HEIGHT_NAVBAR       44
#define HEIGHT_CHATBOXVIEW  215

#pragma mark - Path
#define     PATH_DOCUMENT                   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define     PATH_CHATREC_IMAGE              [PATH_DOCUMENT stringByAppendingPathComponent:@"ChatRec/Images"]

#endif /* Header_h */