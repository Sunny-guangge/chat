//
//  CKWebViewController.m
//  xmppChat
//
//  Created by user on 15/12/25.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKWebViewController.h"
#import "MBProgressHUD.h"

@interface CKWebViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;

@end

@implementation CKWebViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"Web";
    
    [self.view addSubview:self.webView];
}

- (void)setWeb_url:(NSString *)web_url
{
    _web_url = web_url;
    
    [MBProgressHUD showHUDAddedTo:self.webView animated:YES];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:web_url]];
    
    [self.webView loadRequest:request];
}

- (UIWebView *)webView
{
    if (_webView == nil) {
        
        _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        _webView.delegate = self;
        
    }
    return _webView;
}

#pragma mark - UIWebViewDelegate
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
