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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

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
- (IBAction)actionLoginBtn:(UIButton *)sender
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    app.window.backgroundColor = [UIColor whiteColor];
    TabBarController *tabbar = [[TabBarController alloc]init];
    app.window.backgroundColor = [UIColor whiteColor];
    app.window.rootViewController = tabbar;
    [app.window makeKeyAndVisible];
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
