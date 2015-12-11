//
//  CKChatViewController.m
//  xmppChat
//
//  Created by user on 15/10/16.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "CKChatViewController.h"
#import "CKChatBoxViewController.h"
#import "CKChatMessageTableViewController.h"
#import "CKLoginUser.h"
#import "UIView+TL.h"

@interface CKChatViewController ()<CKChatBoxViewControllerDelegate,CKChatMessageTableViewControllerDelegate>
{
    CGFloat viewHeight;
}

@property (nonatomic,strong) CKChatBoxViewController *chatBoxVC;
@property (nonatomic,strong) CKChatMessageTableViewController *chatMessageVC;

@end

@implementation CKChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    viewHeight = HEIGHT_SCREEN - HEIGHT_NAVBAR - HEIGHT_STATUSBAR;
    
    [self.view addSubview:self.chatMessageVC.view];
    [self addChildViewController:self.chatMessageVC];
    [self.view addSubview:self.chatBoxVC.view];
    [self addChildViewController:self.chatBoxVC];
    
}


#pragma mark - CKChatBoxViewControllerDelegate
- (void)chatBoxViewController:(CKChatBoxViewController *)chatBoxViewController
                  sendMessage:(CKMessage *)message
{
    message.fromUser = [CKLoginUser shareLoginUser].user;
    [self.chatMessageVC addChatMessage:message];
    
    CKMessage *recMessage = [[CKMessage alloc] init];
    recMessage.messageType = message.messageType;
    recMessage.ownerTyper = CKMessageOwnerTypeOther;
    recMessage.date = [NSDate date];
    recMessage.text = message.text;
    recMessage.imagePath = message.imagePath;
    recMessage.fromUser = message.fromUser;
    [self.chatMessageVC addChatMessage:recMessage];
    
    [self.chatMessageVC scrollToBottom];
}
- (void)chatBoxViewCOntroller:(CKChatBoxViewController *)chatBoxViewController
       didChangeChatBoxHeight:(CGFloat)height
{
    self.chatMessageVC.view.frameHeight = viewHeight - height;
    self.chatBoxVC.view.originY = self.chatMessageVC.view.originY + self.chatMessageVC.view.frameHeight;
    [self.chatMessageVC scrollToBottom];
}

#pragma mark - CKChatMessageTableViewControllerDelegate
- (void)didTapMessageView:(CKChatMessageTableViewController *)chatMessageController
{
    [self.chatBoxVC resignFirstResponder];
}


#pragma mark - Getter and Setter
- (void) setUser:(CKUser *)user
{
    _user = user;
    [self.navigationItem setTitle:user.username];
}

- (CKChatMessageTableViewController *) chatMessageVC
{
    if (_chatMessageVC == nil) {
        _chatMessageVC = [[CKChatMessageTableViewController alloc] init];
        [_chatMessageVC.view setFrame:CGRectMake(0, HEIGHT_STATUSBAR + HEIGHT_NAVBAR, WIDTH_SCREEN, viewHeight - HEIGHT_TABBAR)];
        [_chatMessageVC setDelegate:self];
    }
    return _chatMessageVC;
}

- (CKChatBoxViewController *) chatBoxVC
{
    if (_chatBoxVC == nil) {
        _chatBoxVC = [[CKChatBoxViewController alloc] init];
        [_chatBoxVC.view setFrame:CGRectMake(0, HEIGHT_SCREEN - HEIGHT_TABBAR, WIDTH_SCREEN, HEIGHT_SCREEN)];
        [_chatBoxVC setDelegate:self];
    }
    return _chatBoxVC;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
