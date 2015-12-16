//
//  CKChatBoxViewController.m
//  xmppChat
//
//  Created by user on 15/12/11.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKChatBoxViewController.h"
#import "CKChatBoxFaceView.h"
#import "CKChatBoxMoreView.h"
#import "CKChatBox.h"
#import "UIView+TL.h"

@interface CKChatBoxViewController ()<CKChatBoxDelegate,CKChatBoxFaceViewDelegate,CKChatBoxMoreViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,assign) CGRect keyboardFrame;

@property (nonatomic,strong) CKChatBox *chatBox;
@property (nonatomic,strong) CKChatBoxFaceView *chatBoxFaceView;
@property (nonatomic,strong) CKChatBoxMoreView *chatBoxMoreView;

@end

@implementation CKChatBoxViewController
{
    NSInteger i;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    i = 1;
    
    [self.view addSubview:self.chatBox];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self resignFirstResponder];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Public Methods
- (BOOL) resignFirstResponder
{
    if (self.chatBox.status != CKChatBoxStatusNothing && self.chatBox.status != CKChatBoxStatusShowVoice) {
        [self.chatBox resignFirstResponder];
        self.chatBox.status = (self.chatBox.status == CKChatBoxStatusShowVoice ? self.chatBox.status : CKChatBoxStatusNothing);
        if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewCOntroller:didChangeChatBoxHeight:)]) {
            [UIView animateWithDuration:0.3 animations:^{
                [_delegate chatBoxViewCOntroller:self didChangeChatBoxHeight:self.chatBox.curHeight];
                
            } completion:^(BOOL finished) {
                [self.chatBoxFaceView removeFromSuperview];
                [self.chatBoxMoreView removeFromSuperview];
            }];
        }
    }
    return [super resignFirstResponder];
}



#pragma mark - CKChatBoxDelegate
//输入框状态的改变
- (void)chatBox:(CKChatBox *)chatBox changeStatusForm:(CKChatBoxStatus)fromStatus to:(CKChatBoxStatus)toStatus
{
    if (toStatus == CKChatBoxStatusShowKeyboard) {      // 显示键盘
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.chatBoxFaceView removeFromSuperview];
            [self.chatBoxMoreView removeFromSuperview];
        });
        return;
    }
    else if (toStatus == CKChatBoxStatusShowVoice) {    // 显示语音输入按钮
        // 从显示更多或表情状态 到 显示语音状态需要动画
        if (fromStatus == CKChatBoxStatusShowMore || fromStatus == CKChatBoxStatusShowFace) {
            [UIView animateWithDuration:0.3 animations:^{
                if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewCOntroller:didChangeChatBoxHeight:)]) {
                    [_delegate chatBoxViewCOntroller:self didChangeChatBoxHeight:HEIGHT_TABBAR];
                }
            } completion:^(BOOL finished) {
                [self.chatBoxFaceView removeFromSuperview];
                [self.chatBoxMoreView removeFromSuperview];
            }];
        }
        else {
            [UIView animateWithDuration:0.1 animations:^{
                if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewCOntroller:didChangeChatBoxHeight:)]) {
                    [_delegate chatBoxViewCOntroller:self didChangeChatBoxHeight:HEIGHT_TABBAR];
                }
            }];
        }
    }
    else if (toStatus == CKChatBoxStatusShowFace) {     // 显示表情面板
        if (fromStatus == CKChatBoxStatusShowVoice || fromStatus == CKChatBoxStatusNothing) {
            [self.chatBoxFaceView setOriginY:self.chatBox.curHeight];
            [self.view addSubview:self.chatBoxFaceView];
            [UIView animateWithDuration:0.3 animations:^{
                if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewCOntroller:didChangeChatBoxHeight:)]) {
                    [_delegate chatBoxViewCOntroller:self didChangeChatBoxHeight:self.chatBox.curHeight + HEIGHT_CHATBOXVIEW];
                }
            }];
        }
        else {
            // 表情高度变化
            self.chatBoxFaceView.originY = self.chatBox.curHeight + HEIGHT_CHATBOXVIEW;
            [self.view addSubview:self.chatBoxFaceView];
            [UIView animateWithDuration:0.3 animations:^{
                self.chatBoxFaceView.originY = self.chatBox.curHeight;
            } completion:^(BOOL finished) {
                [self.chatBoxMoreView removeFromSuperview];
            }];
            // 整个界面高度变化
            if (fromStatus != CKChatBoxStatusShowMore) {
                [UIView animateWithDuration:0.2 animations:^{
                    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewCOntroller:didChangeChatBoxHeight:)]) {
                        [_delegate chatBoxViewCOntroller:self didChangeChatBoxHeight:self.chatBox.curHeight + HEIGHT_CHATBOXVIEW];
                    }
                }];
            }
        }
    }
    else if (toStatus == CKChatBoxStatusShowMore) {     // 显示更多面板
        if (fromStatus == CKChatBoxStatusShowVoice || fromStatus == CKChatBoxStatusNothing) {
            [self.chatBoxMoreView setOriginY:self.chatBox.curHeight];
            [self.view addSubview:self.chatBoxMoreView];
            [UIView animateWithDuration:0.3 animations:^{
                if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewCOntroller:didChangeChatBoxHeight:)]) {
                    [_delegate chatBoxViewCOntroller:self didChangeChatBoxHeight:self.chatBox.curHeight + HEIGHT_CHATBOXVIEW];
                }
            }];
        }
        else {
            self.chatBoxMoreView.originY = self.chatBox.curHeight + HEIGHT_CHATBOXVIEW;
            [self.view addSubview:self.chatBoxMoreView];
            [UIView animateWithDuration:0.3 animations:^{
                self.chatBoxMoreView.originY = self.chatBox.curHeight;
            } completion:^(BOOL finished) {
                [self.chatBoxFaceView removeFromSuperview];
            }];
            
            if (fromStatus != CKChatBoxStatusShowFace) {
                [UIView animateWithDuration:0.2 animations:^{
                    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewCOntroller:didChangeChatBoxHeight:)]) {
                        [_delegate chatBoxViewCOntroller:self didChangeChatBoxHeight:self.chatBox.curHeight + HEIGHT_CHATBOXVIEW];
                    }
                }];
            }
        }
    }
}

//输入框发送的内容
- (void)chatBox:(CKChatBox *)chatBox sendTextMessage:(NSString *)textMessage
{
    CKMessage *message = [[CKMessage alloc] init];
    message.messageType = CKMessageTypeText;
    message.ownerTyper = CKMessageOwnerTypeSelf;
    message.text = textMessage;
    message.date = [NSDate date];
    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController: sendMessage:)]) {
        [_delegate chatBoxViewController:self sendMessage:message];
    }
}

//输入框改变高度
- (void)chatBox:(CKChatBox *)chatBox changeChatBoxHeight:(CGFloat)height
{
    self.chatBoxFaceView.originY = height;
    self.chatBoxMoreView.originY = height;
    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewCOntroller:didChangeChatBoxHeight:)]) {
        float h = (self.chatBox.status == CKChatBoxStatusShowFace ? HEIGHT_CHATBOXVIEW : self.keyboardFrame.size.height ) + height;
        [_delegate chatBoxViewCOntroller:self didChangeChatBoxHeight:h];
    }
}

#pragma mark - CKChatBoxFaceViewDelegate
- (void)chatBoxFaceViewDidSelectedFace:(CKFace *)face type:(CKFaceType)faceType
{
    if (faceType == CKFaceTypeEmoji) {
        [self.chatBox addEmojiFace:face];
    }
}
- (void)chatBoxFaceViewDeleteButtonDown
{
    [self.chatBox deleteButtonDown];
}
- (void)chatBoxFaceViewSendButtonDown
{
    [self.chatBox sendCurrentMessage];
}
- (void)chatBoxFaceViewAddButtonDown
{
    
}


#pragma mark - CKChatBoxMoreViewDelegate
- (void)chatBoxMoreView:(CKChatBoxMoreView *)chatBoxMoreView didSelectItem:(CKChatBoxItem )itemType
{
    if (itemType == CKChatBoxItemAlbum) {            // 相册
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePicker setDelegate:self];
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];
    }
    else if (itemType == CKChatBoxItemCamera) {       // 拍摄
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];//初始化
            [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
            imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
            [imagePicker setDelegate:self];
            [self presentViewController:imagePicker animated:YES completion:^{
                
            }];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前设备不支持拍照。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"Did Selected Index Of ChatBoxMoreView: %d", (int)itemType] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
}



#pragma mark - UIImagePickerControllerDelegate
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
//    NSString *imageName = [NSString stringWithFormat:@"%lf.png", [[NSDate date]timeIntervalSince1970]];
    NSString *imageName = [NSString stringWithFormat:@"chat%lu.png",i];
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@", PATH_DOCUMENT, imageName];
//    NSData *imageData = (UIImagePNGRepresentation(image) == nil ? UIImageJPEGRepresentation(image, 1) : UIImagePNGRepresentation(image));
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:imagePath atomically:YES];
    
    CKMessage *message = [[CKMessage alloc] init];
    message.messageType = CKMessageTypeImage;
    message.ownerTyper = CKMessageOwnerTypeSelf;
    message.date = [NSDate date];
    message.message_Name = imageName;
    message.imagePath = imagePath;
    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:sendMessage:)]) {
        [_delegate chatBoxViewController:self sendMessage:message];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - Private Methods
- (void)keyboardWillHide:(NSNotification *)notification{
    self.keyboardFrame = CGRectZero;
    if (_chatBox.status == CKChatBoxStatusShowFace || _chatBox.status == CKChatBoxStatusShowMore) {
        return;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewCOntroller:didChangeChatBoxHeight:)]) {
        [_delegate chatBoxViewCOntroller:self didChangeChatBoxHeight:self.chatBox.curHeight];
    }
}

- (void)keyboardFrameWillChange:(NSNotification *)notification{
    self.keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (_chatBox.status == CKChatBoxStatusShowKeyboard && self.keyboardFrame.size.height <= HEIGHT_CHATBOXVIEW) {
        return;
    }
    else if ((_chatBox.status == CKChatBoxStatusShowFace || _chatBox.status == CKChatBoxStatusShowMore) && self.keyboardFrame.size.height <= HEIGHT_CHATBOXVIEW) {
        return;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewCOntroller:didChangeChatBoxHeight:)]) {
        [_delegate chatBoxViewCOntroller:self didChangeChatBoxHeight:self.keyboardFrame.size.height + self.chatBox.curHeight];
    }
}


#pragma mark - Getter
- (CKChatBox *) chatBox
{
    if (_chatBox == nil) {
        _chatBox = [[CKChatBox alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_TABBAR)];
        [_chatBox setDelegate:self];
    }
    return _chatBox;
}

- (CKChatBoxMoreView *) chatBoxMoreView
{
    if (_chatBoxMoreView == nil) {
        _chatBoxMoreView = [[CKChatBoxMoreView alloc] initWithFrame:CGRectMake(0, HEIGHT_TABBAR, WIDTH_SCREEN, HEIGHT_CHATBOXVIEW)];
        [_chatBoxMoreView setDelegate:self];
        CKChatBoxMoreItem *photosItem = [CKChatBoxMoreItem createChatBoxMoreItemWithTitle:@"照片"
                                                                                imageName:@"sharemore_pic"];
        CKChatBoxMoreItem *takePictureItem = [CKChatBoxMoreItem createChatBoxMoreItemWithTitle:@"拍摄"
                                                                                     imageName:@"sharemore_video"];
        CKChatBoxMoreItem *videoItem = [CKChatBoxMoreItem createChatBoxMoreItemWithTitle:@"小视频"
                                                                               imageName:@"sharemore_sight"];
        CKChatBoxMoreItem *videoCallItem = [CKChatBoxMoreItem createChatBoxMoreItemWithTitle:@"视频聊天"
                                                                                   imageName:@"sharemore_videovoip"];
        CKChatBoxMoreItem *giftItem = [CKChatBoxMoreItem createChatBoxMoreItemWithTitle:@"红包"
                                                                              imageName:@"sharemore_wallet"];
        CKChatBoxMoreItem *transferItem = [CKChatBoxMoreItem createChatBoxMoreItemWithTitle:@"转账"
                                                                                  imageName:@"sharemorePay"];
        CKChatBoxMoreItem *positionItem = [CKChatBoxMoreItem createChatBoxMoreItemWithTitle:@"位置"
                                                                                  imageName:@"sharemore_location"];
        CKChatBoxMoreItem *favoriteItem = [CKChatBoxMoreItem createChatBoxMoreItemWithTitle:@"收藏"
                                                                                  imageName:@"sharemore_myfav"];
        CKChatBoxMoreItem *businessCardItem = [CKChatBoxMoreItem createChatBoxMoreItemWithTitle:@"名片"
                                                                                      imageName:@"sharemore_friendcard" ];
        CKChatBoxMoreItem *interphoneItem = [CKChatBoxMoreItem createChatBoxMoreItemWithTitle:@"实时对讲机"
                                                                                    imageName:@"sharemore_wxtalk" ];
        CKChatBoxMoreItem *voiceItem = [CKChatBoxMoreItem createChatBoxMoreItemWithTitle:@"语音输入"
                                                                               imageName:@"sharemore_voiceinput"];
        CKChatBoxMoreItem *cardsItem = [CKChatBoxMoreItem createChatBoxMoreItemWithTitle:@"卡券"
                                                                               imageName:@"sharemore_wallet"];
        [_chatBoxMoreView setItems:[[NSMutableArray alloc] initWithObjects:photosItem, takePictureItem, videoItem, videoCallItem, giftItem, transferItem, positionItem, favoriteItem, businessCardItem, interphoneItem, voiceItem, cardsItem, nil]];
    }
    return _chatBoxMoreView;
}

- (CKChatBoxFaceView *) chatBoxFaceView
{
    if (_chatBoxFaceView == nil) {
        _chatBoxFaceView = [[CKChatBoxFaceView alloc] initWithFrame:CGRectMake(0, HEIGHT_TABBAR, WIDTH_SCREEN, HEIGHT_CHATBOXVIEW)];
        [_chatBoxFaceView setDelegate:self];
    }
    return _chatBoxFaceView;
}

@end
