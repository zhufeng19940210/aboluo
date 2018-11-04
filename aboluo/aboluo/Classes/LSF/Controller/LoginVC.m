//  LoginVC.m
//  aboluo
//  Created by zhufeng on 2018/11/3.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "LoginVC.h"
#import "ResigterVC.h"
#import "ForgetPwdVC.h"
#import "TabBarController.h"
#import "AppDelegate.h"
@interface LoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *phone_tf;
@property (weak, nonatomic) IBOutlet UITextField *pwd_tf;
@end
@implementation LoginVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
/**
 注册方法
 @param sender 注册方法
 */
- (IBAction)actionRegisterBtn:(UIButton *)sender
{
    ResigterVC *registervc = [[ResigterVC alloc]init];
    [self.navigationController pushViewController:registervc animated:YES];
}
/**
 登录方法
 @param sender 登录方法
 */
- (IBAction)actionLoginBtn:(UIButton *)sender {
    NSString *url = [NSString stringWithFormat:@"%@",@"http://106.12.192.149:8080/Single/user/login?phone=15914098345&password=111"];
    [[NetWorkTool shareInstacne]getWithURLString:url parameters:nil success:^(id  _Nonnull responseObject) {
        NSLog(@"id:%@",responseObject);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
}
/**
 用户忘记密码
 @param sender 用户忘记密码
 */
- (IBAction)actionForgetPwdBtn:(UIButton *)sender
{
    ForgetPwdVC *forgetpwdvc = [[ForgetPwdVC alloc]init];
    [self.navigationController pushViewController:forgetpwdvc animated:YES];
}
@end
