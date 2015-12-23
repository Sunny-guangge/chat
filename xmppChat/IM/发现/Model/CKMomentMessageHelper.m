//
//  CKMomentMessageHelper.m
//  xmppChat
//
//  Created by user on 15/12/23.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKMomentMessageHelper.h"
#import "CKMoment.h"
#import "CKImage.h"
#import "CKLocation.h"

static CKMomentMessageHelper *momentMessageHelper;

@implementation CKMomentMessageHelper


+ (CKMomentMessageHelper *)shareMomentMessageHelper
{
    if (momentMessageHelper == nil) {
        momentMessageHelper = [[CKMomentMessageHelper alloc] init];
    }
    return momentMessageHelper;
}

- (NSMutableArray *)getUserMomentMessage
{
    NSMutableArray *array = [NSMutableArray array];
    
    
//11111
    CKMoment *moment = [[CKMoment alloc] init];
    
    moment.moment_text = @"这两点就阿里的骄傲是来得急阿斯利康多久啦萨的科技阿里的空间，机读卡聚少离多就阿里的加拉开始的加拉开始的减肥拉斯克奖的。";
    CKUser *user = [[CKUser alloc] init];
    user.username = @"Sunny";
    user.avatarURL = @"1.jpg";
    moment.user = user;
    
    moment.time = @"昨天";
    
    moment.momentType = CKMomentTypeImage;
    
    CKLocation *location = [[CKLocation alloc] init];
    location.location_String = @"北京-望京soho";
    moment.location = location;
    
    CKImage *image1 = [[CKImage alloc] init];
    image1.image_URL = @"1.jpg";
    
    CKImage *image2 = [[CKImage alloc] init];
    image2.image_URL = @"2.jpg";
    
    
    CKImage *image3 = [[CKImage alloc] init];
    image3.image_URL = @"3.jpg";
    
    CKImage *image4 = [[CKImage alloc] init];
    image4.image_URL = @"4.jpg";
    
    CKImage *image5 = [[CKImage alloc] init];
    image5.image_URL = @"5.jpg";
    
    CKImage *image6 = [[CKImage alloc] init];
    image6.image_URL = @"6.jpg";
    
    CKImage *image7 = [[CKImage alloc] init];
    image7.image_URL = @"7.jpg";
    
    CKImage *image8 = [[CKImage alloc] init];
    image8.image_URL = @"8.jpg";
    
    CKImage *image9 = [[CKImage alloc] init];
    image9.image_URL = @"9.jpg";
    
    NSMutableArray *imageArray = [NSMutableArray array];
    
    [imageArray addObject:image1];
    [imageArray addObject:image2];
    [imageArray addObject:image3];
    [imageArray addObject:image4];
    [imageArray addObject:image5];
    [imageArray addObject:image6];
    [imageArray addObject:image7];
    [imageArray addObject:image8];
    [imageArray addObject:image9];
    
    moment.imageArray = imageArray;
    
    
    
    CKMoment *moment1 = [[CKMoment alloc] init];
    
//    moment1.moment_text = @"这两点就阿里的骄傲是来得急阿斯利康多久啦萨的科技阿里的空间，机读卡聚少离多就阿里的加拉开始的加拉开始的减肥拉斯克奖的。";
    CKUser *user1 = [[CKUser alloc] init];
    user1.username = @"Sunny";
    user1.avatarURL = @"1.jpg";
    moment1.user = user1;
    
    moment1.time = @"昨天";
    
    moment1.momentType = CKMomentTypeImage;
    
    CKLocation *location1 = [[CKLocation alloc] init];
    location1.location_String = @"北京-望京soho";
    moment1.location = location1;
    
    CKImage *image11 = [[CKImage alloc] init];
    image11.image_URL = @"5.jpg";
    
    CKImage *image21 = [[CKImage alloc] init];
    image21.image_URL = @"6.jpg";
    
    
    CKImage *image31 = [[CKImage alloc] init];
    image31.image_URL = @"7.jpg";
    
    CKImage *image41 = [[CKImage alloc] init];
    image41.image_URL = @"8.jpg";
    
    NSMutableArray *imageArray1 = [NSMutableArray array];
    
    [imageArray1 addObject:image11];
    [imageArray1 addObject:image21];
    [imageArray1 addObject:image31];
    [imageArray1 addObject:image41];
    
    moment1.imageArray = imageArray1;
    
    
    
    CKMoment *moment2 = [[CKMoment alloc] init];
    
    moment2.moment_text = @"这两点就阿里的骄傲是来得急阿斯利康多久啦萨的科技阿里的空间，机读卡聚少离多就阿里的加拉开始的加拉开始的减肥拉斯克奖的。";
    CKUser *user2 = [[CKUser alloc] init];
    user2.username = @"Sunny";
    user2.avatarURL = @"1.jpg";
    moment2.user = user2;
    
    moment2.time = @"昨天";
    
    moment2.momentType = CKMomentTypeWeb;
    
    CKLocation *location2 = [[CKLocation alloc] init];
    location2.location_String = @"北京-望京soho";
    moment2.location = location2;
    
    CKWeb *web2 = [[CKWeb alloc] init];
    web2.web_ImageURL = @"8.jpg";
    web2.web_Title = @"大当家拉斯加达拉斯角度来看减肥洒落的空间的时刻";
    web2.web_URL = @"http://www.baidu.com";
    moment2.web = web2;
    
    moment2.from = @"优儿学堂";
    
    
    CKMoment *moment3 = [[CKMoment alloc] init];
    
    moment3.moment_text = @"这两点就阿里的骄傲是来得急阿斯利康多久啦萨的科技阿里的空间，机读卡聚少离多就阿里的加拉开始的加拉开始的减肥拉斯克奖的。";
    CKUser *user3 = [[CKUser alloc] init];
    user3.username = @"Sunny";
    user3.avatarURL = @"1.jpg";
    moment3.user = user3;
    
    moment3.time = @"昨天";
    
    moment3.momentType = CKMomentTypeNone;
    
//    CKLocation *location3 = [[CKLocation alloc] init];
//    location3.location_String = @"北京-望京soho";
//    moment3.location = location3;
    
    
    moment3.from = @"优儿学堂";
    
    
    
    
    CKMoment *moment4 = [[CKMoment alloc] init];
    
    moment4.moment_text = @"这两点就阿里的骄傲是来得急阿斯利康多久啦萨的科技阿里的空间，机读卡聚少离多就阿里的加拉开始的加拉开始的减肥拉斯克奖的。";
    CKUser *user4 = [[CKUser alloc] init];
    user4.username = @"Sunny";
    user4.avatarURL = @"1.jpg";
    moment4.user = user4;
    
    moment4.time = @"昨天";
    
    moment4.momentType = CKMomentTypeImage;
    
    CKLocation *location4 = [[CKLocation alloc] init];
    location4.location_String = @"北京-望京soho";
    moment4.location = location4;
    
    CKImage *image14 = [[CKImage alloc] init];
    image14.image_URL = @"1.jpg";
    
    CKImage *image24 = [[CKImage alloc] init];
    image24.image_URL = @"1.jpg";
    
    CKImage *image34 = [[CKImage alloc] init];
    image34.image_URL = @"1.jpg";
    
    
    NSMutableArray *imageArray44 = [NSMutableArray array];
    
    [imageArray44 addObject:image14];
    [imageArray44 addObject:image24];
    [imageArray44 addObject:image34];
    [imageArray44 addObject:image9];
    [imageArray44 addObject:image9];
    [imageArray44 addObject:image9];
    [imageArray44 addObject:image9];
    [imageArray44 addObject:image9];
    [imageArray44 addObject:image9];
    
    moment4.imageArray = imageArray44;
    
    
    
    
    
    CKMoment *moment5 = [[CKMoment alloc] init];
    
    moment5.moment_text = @"这两点就阿里的骄傲是来得急阿斯利康多久啦萨的科技阿里的空间，机读卡聚少离多就阿里的加拉开始的加拉开始的减肥拉斯克奖的。";
    CKUser *user5 = [[CKUser alloc] init];
    user5.username = @"Sunny";
    user5.avatarURL = @"1.jpg";
    moment5.user = user5;
    
    moment5.time = @"昨天";
    
    moment5.momentType = CKMomentTypeMusic;
    
    CKLocation *location5 = [[CKLocation alloc] init];
    location5.location_String = @"北京-望京soho";
    moment5.location = location5;
    
    CKMusic *music = [[CKMusic alloc] init];
    music.music_ImageURL = @"8.jpg";
    music.music_Name = @"唯一";
    music.music_Singer = @"王力宏";
    moment5.music = music;
    
    [array addObject:moment];
    [array addObject:moment1];
    [array addObject:moment2];
    [array addObject:moment3];
    [array addObject:moment4];
    [array addObject:moment5];
    
    return array;
}

@end
