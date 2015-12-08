//
//  CKMessage.h
//  xmppChat
//
//  Created by user on 15/11/25.
//  Copyright © 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKUser.h"
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

/**
 *消息拥有者
 */
typedef NS_ENUM(NSUInteger,CKMessageOwnerType){
    CKMessageOwnerTypeUnknow,//未知的消息拥有者
    CKMessageOwnerTypeSystem,//系统消息
    CKMessageOwnerTypeSelf,//自己发送的消息
    CKMessageOwnerTypeOther,//接收到的他人消息
};

/**
 *消息类型
 */
typedef NS_ENUM(NSInteger,CKMessageType) {
    CKMessageTypeUnknow,   //未知
    CKMessageTypeSystem,   //系统
    CKMessageTypeText,     //文字
    CKMessageTypeImage,    //图片
    CKMessageTypeVoice,    //语音
    CKMessageTypeVideo,    //视频
    CKMessageTypeFile,     //文件
    CKMessageTypeLocation, //位置
    CKMessageTypeShake,    //抖动
};

/**
 *  消息发送状态
 */
typedef NS_ENUM(NSUInteger, CKMessageSendState) {
    CKMessageSendStateSendSuccess,   //消息发送成功
    CKMessageSendStateFail,          //消息发送失败
};

/**
 *  消息读取状态
 */
typedef NS_ENUM(NSUInteger, CKMessageReadState) {
    CKMessageUnRead,     //消息未读
    CKMessageReaded,     //消息已读
};

@interface CKMessage : NSObject

@property (nonatomic,strong) CKUser *fromUser;          //发送者信息
@property (nonatomic,strong) NSDate *date;              //发送时间
@property (nonatomic,strong) NSString *dateString;      //格式化的发送时间
@property (nonatomic,assign) CKMessageType messageType; //消息类型
@property (nonatomic,assign) CKMessageOwnerType ownerTyper; //发送消息者类型
@property (nonatomic,assign) CKMessageReadState readState;  //读取状态
@property (nonatomic,assign) CKMessageSendState sendState;  //发送状态

@property (nonatomic,assign) CGSize messageSize;            //消息大小
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,strong) NSString *cellIndentify;

#pragma mark - 文字消息
@property (nonatomic,strong) NSString *text;                //文字信息
@property (nonatomic,strong) NSAttributedString *attrText;  //格式化的文字信息

#pragma mark - 图片消息
@property (nonatomic,strong) NSString *imagePath;           //本地图片路径
@property (nonatomic,strong) UIImage *image;                //图片缓存
@property (nonatomic,strong) NSString *imageURL;            //网络图片URL

#pragma mark - 位置消息
@property (nonatomic,assign) CLLocationCoordinate2D coordinate; //经纬度
@property (nonatomic,strong) NSString *address;                 //地址

#pragma mark - 语音消息
@property (nonatomic,assign) NSUInteger voiceSeconds;           //语音时间
@property (nonatomic,strong) NSString *voiceUrl;                //网络语音URL
@property (nonatomic,strong) NSString *voicePath;               //本地语音Path



/**
 *消息的照片
 */
@property (nonatomic,copy) NSString *message_AvatarURL;

/**
 *消息的时间
 */
@property (nonatomic,copy) NSString *message_Time;

/**
 *消息的内容
 */
@property (nonatomic,copy) NSString *message_Content;

/**
 *消息的用户名字
 */
@property (nonatomic,copy) NSString *message_Name;

@end
