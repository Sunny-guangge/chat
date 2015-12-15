//
//  CKChatBox.m
//  xmppChat
//
//  Created by user on 15/12/9.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKChatBox.h"
#import "UIView+TL.h"
#import "UIImage+CK.h"

#define     CHATBOX_BUTTON_WIDTH        37
#define     HEIGHT_TEXTVIEW             HEIGHT_TABBAR * 0.74
#define     MAX_TEXTVIEW_HEIGHT         104


@interface CKChatBox () <UITextViewDelegate>

@property (nonatomic,strong) UIView *topline;
@property (nonatomic,strong) UIButton *voiceButton;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIButton *faceButton;
@property (nonatomic,strong) UIButton *moreButton;
@property (nonatomic,strong) UIButton *talkButton;

@end


@implementation CKChatBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _curHeight = frame.size.height;
        
        [self setBackgroundColor:DEFAULT_CHATBOX_COLOR];
        [self addSubview:self.voiceButton];
        [self addSubview:self.textView];
        [self addSubview:self.faceButton];
        [self addSubview:self.moreButton];
        [self addSubview:self.talkButton];
        [self addSubview:self.topline];
        self.status = CKChatBoxStatusNothing;
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self.topline setFrameWidth:self.frameWidth];
    
    float y = self.frameHeight - self.voiceButton.frameHeight - (HEIGHT_TABBAR - CHATBOX_BUTTON_WIDTH) / 2;
    
    if (self.voiceButton.originY != y) {
     
        [UIView animateWithDuration:0.1 animations:^{
            
            [self.voiceButton setOriginY:y];
            [self.faceButton setOriginY:self.voiceButton.originY];
            [self.moreButton setOriginY:self.voiceButton.originY];
            
        }];
        
    }
}


#pragma Public Methods
- (BOOL)resignFirstResponder
{
    [self.textView resignFirstResponder];
    
    [_moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtn_Black"] forState:UIControlStateNormal];
    [_moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtnHL_Black"] forState:UIControlStateHighlighted];
    [_faceButton setImage:[UIImage imageNamed:@"ToolViewEmotion"] forState:UIControlStateNormal];
    [_faceButton setImage:[UIImage imageNamed:@"ToolViewEmotionHL"] forState:UIControlStateHighlighted];
    return [super resignFirstResponder];
}

- (void) addEmojiFace:(CKFace *)face
{
    [self.textView setText:[self.textView.text stringByAppendingString:face.faceName]];
    
    if (MAX_TEXTVIEW_HEIGHT < self.textView.contentSize.height) {
        
        float y = self.textView.contentSize.height - self.textView.frameHeight;
        y = y < 0 ? 0 : y;
        [self.textView scrollRectToVisible:CGRectMake(0, y, self.textView.frameHeight, self.textView.frameHeight) animated:YES];
    }
    [self textViewDidChange:self.textView];
}

- (void)sendCurrentMessage
{
    if (self.textView.text.length > 0) {
        if (_delegate && [_delegate respondsToSelector:@selector(chatBox:sendTextMessage:)]) {
            [_delegate chatBox:self sendTextMessage:self.textView.text];
        }
    }
    [self.textView setText:@""];
    [self textViewDidChange:self.textView];
}

- (void) deleteButtonDown
{
    [self textView:self.textView shouldChangeTextInRange:NSMakeRange(self.textView.text.length - 1, 1)  replacementText:@""];
    
    [self textViewDidChange:self.textView];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    CKChatBoxStatus lastStatus = self.status;
    
    self.status = CKChatBoxStatusShowKeyboard;
    
    if (lastStatus == CKChatBoxStatusShowFace) {
        [_faceButton setImage:[UIImage imageNamed:@"ToolViewEmotion"] forState:UIControlStateNormal];
        [_faceButton setImage:[UIImage imageNamed:@"ToolViewEmotionHL"] forState:UIControlStateHighlighted];
    }
    else if (lastStatus == CKChatBoxStatusShowMore)
    {
        [_moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtn_Black"] forState:UIControlStateNormal];
        [_moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtnHL_Black"] forState:UIControlStateHighlighted];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(chatBox:changeStatusForm:to:)]) {
        [_delegate chatBox:self changeStatusForm:lastStatus to:self.status];
    }
}

- (void) textViewDidChange:(UITextView *)textView
{
    CGFloat height = [textView sizeThatFits:CGSizeMake(self.textView.frameWidth, MAXFLOAT)].height;
    height = height > HEIGHT_TEXTVIEW ? height : HEIGHT_TEXTVIEW;
    height = height < MAX_TEXTVIEW_HEIGHT ? height : textView.frameHeight;
    _curHeight = height + HEIGHT_TABBAR - HEIGHT_TEXTVIEW;
    if (_curHeight != self.frameHeight) {
        [UIView animateWithDuration:0.05 animations:^{
            [self setFrameHeight:_curHeight];
            if (_delegate && [_delegate respondsToSelector:@selector(chatBox:changeChatBoxHeight:)]) {
                [_delegate chatBox:self changeChatBoxHeight:_curHeight];
            }
        }];
    }
    if (height != textView.frameHeight) {
        [UIView animateWithDuration:0.05 animations:^{
            [textView setFrameHeight:height];
        }];
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        [self sendCurrentMessage];
        return NO;
    }
    else if (textView.text.length > 0 && [text isEqualToString:@""]) {       // delete
        if ([textView.text characterAtIndex:range.location] == ']') {
            NSUInteger location = range.location;
            NSUInteger length = range.length;
            while (location != 0) {
                location --;
                length ++ ;
                char c = [textView.text characterAtIndex:location];
                if (c == '[') {
                    textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:@""];
                    return NO;
                }
                else if (c == ']') {
                    return YES;
                }
            }
        }
    }
    
    return YES;
}


#pragma mark - Event Response
- (void) voiceButtonDown:(UIButton *)sender
{
    CKChatBoxStatus lastStatus = self.status;
    if (lastStatus == CKChatBoxStatusShowVoice) {      // 正在显示talkButton，改为现实键盘状态
        self.status = CKChatBoxStatusShowKeyboard;
        [self.talkButton setHidden:YES];
        [self.textView setHidden:NO];
        [self.textView becomeFirstResponder];
        [_voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoice"] forState:UIControlStateNormal];
        [_voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoiceHL"] forState:UIControlStateHighlighted];
        
        [self textViewDidChange:self.textView];
        if (_delegate && [_delegate respondsToSelector:@selector(chatBox:changeStatusForm:to:)]) {
            [_delegate chatBox:self changeStatusForm:lastStatus to:self.status];
        }
    }
    else {          // 显示talkButton
        self.curHeight = HEIGHT_TABBAR;
        [self setFrameHeight:self.curHeight];
        self.status = CKChatBoxStatusShowVoice;
        [self.textView resignFirstResponder];
        [self.textView setHidden:YES];
        [self.talkButton setHidden:NO];
        [_voiceButton setImage:[UIImage imageNamed:@"ToolViewKeyboard"] forState:UIControlStateNormal];
        [_voiceButton setImage:[UIImage imageNamed:@"ToolViewKeyboardHL"] forState:UIControlStateHighlighted];
        if (lastStatus == CKChatBoxStatusShowFace) {
            [_faceButton setImage:[UIImage imageNamed:@"ToolViewEmotion"] forState:UIControlStateNormal];
            [_faceButton setImage:[UIImage imageNamed:@"ToolViewEmotionHL"] forState:UIControlStateHighlighted];
        }
        else if (lastStatus == CKChatBoxStatusShowMore) {
            [_moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtn_Black"] forState:UIControlStateNormal];
            [_moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtnHL_Black"] forState:UIControlStateHighlighted];
        }
        if (_delegate && [_delegate respondsToSelector:@selector(chatBox:changeStatusForm:to:)]) {
            [_delegate chatBox:self changeStatusForm:lastStatus to:self.status];
        }
    }
}

- (void) faceButtonDown:(UIButton *)sender
{
    CKChatBoxStatus lastStatus = self.status;
    if (lastStatus == CKChatBoxStatusShowFace) {       // 正在显示表情，改为现实键盘状态
        self.status = CKChatBoxStatusShowKeyboard;
        [_faceButton setImage:[UIImage imageNamed:@"ToolViewEmotion"] forState:UIControlStateNormal];
        [_faceButton setImage:[UIImage imageNamed:@"ToolViewEmotionHL"] forState:UIControlStateHighlighted];
        [self.textView becomeFirstResponder];
        if (_delegate && [_delegate respondsToSelector:@selector(chatBox:changeStatusForm:to:)]) {
            [_delegate chatBox:self changeStatusForm:lastStatus to:self.status];
        }
    }
    else {
        self.status = CKChatBoxStatusShowFace;
        [_faceButton setImage:[UIImage imageNamed:@"ToolViewKeyboard"] forState:UIControlStateNormal];
        [_faceButton setImage:[UIImage imageNamed:@"ToolViewKeyboardHL"] forState:UIControlStateHighlighted];
        if (lastStatus == CKChatBoxStatusShowMore) {
            [_moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtn_Black"] forState:UIControlStateNormal];
            [_moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtnHL_Black"] forState:UIControlStateHighlighted];
        }
        else if (lastStatus == CKChatBoxStatusShowVoice) {
            [_voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoice"] forState:UIControlStateNormal];
            [_voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoiceHL"] forState:UIControlStateHighlighted];
            [_talkButton setHidden:YES];
            [_textView setHidden:NO];
            [self textViewDidChange:self.textView];
        }
        else if (lastStatus == CKChatBoxStatusShowKeyboard) {
            [self.textView resignFirstResponder];
        }
        if (_delegate && [_delegate respondsToSelector:@selector(chatBox:changeStatusForm:to:)]) {
            [_delegate chatBox:self changeStatusForm:lastStatus to:self.status];
        }
    }
}

- (void) moreButtonDown:(UIButton *)sender
{
    CKChatBoxStatus lastStatus = self.status;
    if (lastStatus == CKChatBoxStatusShowMore) {
        self.status = CKChatBoxStatusShowKeyboard;
        [_moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtn_Black"] forState:UIControlStateNormal];
        [_moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtnHL_Black"] forState:UIControlStateHighlighted];
        [self.textView becomeFirstResponder];
        if (_delegate && [_delegate respondsToSelector:@selector(chatBox:changeStatusForm:to:)]) {
            [_delegate chatBox:self changeStatusForm:lastStatus to:self.status];
        }
    }
    else {
        self.status = CKChatBoxStatusShowMore;
        [_moreButton setImage:[UIImage imageNamed:@"ToolViewKeyboard"] forState:UIControlStateNormal];
        [_moreButton setImage:[UIImage imageNamed:@"ToolViewKeyboardHL"] forState:UIControlStateHighlighted];
        if (lastStatus == CKChatBoxStatusShowFace) {
            [_faceButton setImage:[UIImage imageNamed:@"ToolViewEmotion"] forState:UIControlStateNormal];
            [_faceButton setImage:[UIImage imageNamed:@"ToolViewEmotionHL"] forState:UIControlStateHighlighted];
        }
        else if (lastStatus == CKChatBoxStatusShowVoice) {
            [_voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoice"] forState:UIControlStateNormal];
            [_voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoiceHL"] forState:UIControlStateHighlighted];
            [_talkButton setHidden:YES];
            [_textView setHidden:NO];
            [self textViewDidChange:self.textView];
        }
        else if (lastStatus == CKChatBoxStatusShowKeyboard) {
            [self.textView resignFirstResponder];
        }
        if (_delegate && [_delegate respondsToSelector:@selector(chatBox:changeStatusForm:to:)]) {
            [_delegate chatBox:self changeStatusForm:lastStatus to:self.status];
        }
    }
}

- (void) talkButtonDown:(UIButton *)sender
{
    [_talkButton setTitle:@"松开 结束" forState:UIControlStateNormal];
    [_talkButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.5]] forState:UIControlStateNormal];
}

- (void) talkButtonUpInside:(UIButton *)sender
{
    [_talkButton setTitle:@"按住 说话" forState:UIControlStateNormal];
    [_talkButton setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
}

- (void) talkButtonUpOutside:(UIButton *)sender
{
    [_talkButton setTitle:@"按住 说话" forState:UIControlStateNormal];
    [_talkButton setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
}

#pragma mark - Getter
- (UIView *) topLine
{
    if (_topline == nil) {
        _topline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frameWidth, 0.5)];
        [_topline setBackgroundColor:[UIColor colorWithRed:164.0f/255 green:165.0f/255 blue:165.0f/255 alpha:1.0f]];
    }
    return _topline;
}

- (UIButton *) voiceButton
{
    if (_voiceButton == nil) {
        _voiceButton = [[UIButton alloc] initWithFrame:CGRectMake(0, (HEIGHT_TABBAR - CHATBOX_BUTTON_WIDTH) / 2, CHATBOX_BUTTON_WIDTH, CHATBOX_BUTTON_WIDTH)];
        [_voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoice"] forState:UIControlStateNormal];
        [_voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoiceHL"] forState:UIControlStateHighlighted];
        [_voiceButton addTarget:self action:@selector(voiceButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voiceButton;
}

- (UITextView *) textView
{
    if (_textView == nil) {
        _textView = [[UITextView alloc] initWithFrame:self.talkButton.frame];
        [_textView setFont:[UIFont systemFontOfSize:16.0f]];
        [_textView.layer setMasksToBounds:YES];
        [_textView.layer setCornerRadius:4.0f];
        [_textView.layer setBorderWidth:0.5f];
        [_textView.layer setBorderColor:self.topLine.backgroundColor.CGColor];
        [_textView setScrollsToTop:NO];
        [_textView setReturnKeyType:UIReturnKeySend];
        [_textView setDelegate:self];
    }
    return _textView;
}

- (UIButton *) faceButton
{
    if (_faceButton == nil) {
        _faceButton = [[UIButton alloc] initWithFrame:CGRectMake(self.moreButton.originX - CHATBOX_BUTTON_WIDTH, (HEIGHT_TABBAR - CHATBOX_BUTTON_WIDTH) / 2, CHATBOX_BUTTON_WIDTH, CHATBOX_BUTTON_WIDTH)];
        [_faceButton setImage:[UIImage imageNamed:@"ToolViewEmotion"] forState:UIControlStateNormal];
        [_faceButton setImage:[UIImage imageNamed:@"ToolViewEmotionHL"] forState:UIControlStateHighlighted];
        [_faceButton addTarget:self action:@selector(faceButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _faceButton;
}

- (UIButton *) moreButton
{
    if (_moreButton == nil) {
        _moreButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_SCREEN - CHATBOX_BUTTON_WIDTH, (HEIGHT_TABBAR - CHATBOX_BUTTON_WIDTH) / 2, CHATBOX_BUTTON_WIDTH, CHATBOX_BUTTON_WIDTH)];
        [_moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtn_Black"] forState:UIControlStateNormal];
        [_moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtnHL_Black"] forState:UIControlStateHighlighted];
        [_moreButton addTarget:self action:@selector(moreButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

- (UIButton *) talkButton
{
    if (_talkButton == nil) {
        _talkButton = [[UIButton alloc] initWithFrame:CGRectMake(self.voiceButton.originX + self.voiceButton.frameWidth + 4, self.frameHeight * 0.13, self.faceButton.originX - self.voiceButton.originX - self.voiceButton.frameWidth - 8, HEIGHT_TEXTVIEW)];
        [_talkButton setTitle:@"按住 说话" forState:UIControlStateNormal];
        [_talkButton setTitle:@"松开 结束" forState:UIControlStateHighlighted];
        [_talkButton setTitleColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0] forState:UIControlStateNormal];
        [_talkButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.5]] forState:UIControlStateHighlighted];
        [_talkButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
        [_talkButton.layer setMasksToBounds:YES];
        [_talkButton.layer setCornerRadius:4.0f];
        [_talkButton.layer setBorderWidth:0.5f];
        [_talkButton.layer setBorderColor:self.topLine.backgroundColor.CGColor];
        [_talkButton setHidden:YES];
        [_talkButton addTarget:self action:@selector(talkButtonDown:) forControlEvents:UIControlEventTouchDown];
        [_talkButton addTarget:self action:@selector(talkButtonUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_talkButton addTarget:self action:@selector(talkButtonUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
        [_talkButton addTarget:self action:@selector(talkButtonUpOutside:) forControlEvents:UIControlEventTouchCancel];
    }
    return _talkButton;
}

@end
