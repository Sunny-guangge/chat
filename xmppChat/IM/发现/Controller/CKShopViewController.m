//
//  CKShopViewController.m
//  xmppChat
//
//  Created by user on 15/12/17.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKShopViewController.h"
#import "MBProgressHUD.h"

@interface CKShopViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;

@end

@implementation CKShopViewController

- (void)viewDidLoad
{
    [self.view addSubview:self.webView];
    
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://sunny-guangge.github.io"]];
    
    [MBProgressHUD showHUDAddedTo:self.webView animated:YES];
    
    [self.webView loadRequest:urlRequest];
}

#pragma mark - Getter
- (UIWebView *)webView
{
    if (_webView == nil) {
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN)];
        _webView.delegate = self;
        
    }
    return _webView;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.webView animated:YES];
    
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self.navigationItem setTitle:title];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    [MBProgressHUD hideHUDForView:self.webView animated:YES];
}

@end
