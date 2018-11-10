//  AgreeProtolVC.m
//  aboluo
//  Created by zhufeng on 2018/11/10.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "AgreeProtolVC.h"
@interface AgreeProtolVC ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
@implementation AgreeProtolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"协议";
    [SVProgressHUD show];
    NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"协议.html" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:filePath];
    self.webView.delegate = self;
    [self.webView loadRequest:request];
}
#pragma mark - uiwebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"加载成功");
    [SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithStatus:@"加载成功"];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"失败了");
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:@"加载失败"];
}
@end
