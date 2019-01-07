//  ResigterVC.m
//  aboluo
//  Created by zhufeng on 2018/11/3.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "ResigterVC.h"
#import "AgreeProtolVC.h"
#import "ImageCodeView.h"
#import "UIButton+countDown.h"
#import "LoginVC.h"
#import "AppDelegate.h"
#import "TabBarController.h"
@interface ResigterVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoe_tf;
@property (weak, nonatomic) IBOutlet UITextField *code_tf;
@property (weak, nonatomic) IBOutlet UITextField *pwd_tf;
@property (weak, nonatomic) IBOutlet UIButton *eye_btn;
@property (weak, nonatomic) IBOutlet UIButton *agree_btn;
@property (weak, nonatomic) IBOutlet ImageCodeView *code_view;
@property (weak, nonatomic) IBOutlet UITextField *ship_tf;
@property (weak, nonatomic) IBOutlet UIButton *code_btn;
@property (nonatomic,copy)  NSString *code_str; // 获取验证码
@property (nonatomic,assign)BOOL isAgree;       //是否使用协议
@end
@implementation ResigterVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.isAgree = NO;
}
/**
 注册的方法
 @param sender 注册的方法
 */
- (IBAction)actionResigsterBtn:(UIButton *)sender
{
    NSString *phone = self.phoe_tf.text;
    NSString *code  = self.code_tf.text;
    NSString *pwd   = self.pwd_tf.text;
    NSString *ship  = self.ship_tf.text;
    if ([phone isEqualToString:@""] || phone.length == 0) {
        [self showHint:@"手机号码不能为空" yOffset:-200];
        return;
    }
    if (![LCUtil isMobileNumber:phone]) {
        [self showHint:@"手机号码有误" yOffset:-200];
        return;
    }
    if (ship.length == 0 || [ship isEqualToString:@""]) {
        [self showHint:@"图形文字不能为空" yOffset:-200];
        return;
    }
    if (![ship isEqualToString:self.code_view.CodeStr]) {
        [self showHint:@"图形文字不正确" yOffset:-200];
        return;
    }
    if ([code isEqualToString:@""] || code.length == 0) {
        [self showHint:@"验证码不能为空" yOffset:-200];
        return;
    }
    if (![code isEqualToString:self.code_str]) {
        [self showHint:@"验证码有误" yOffset:-200];
        return;
    }
    if ([pwd isEqualToString:@""] || pwd.length == 0) {
        [self showHint:@"密码不能为空" yOffset:-200];
        return;
    }
    if (!self.isAgree) {
        [self showHint:@"请先同意协议" yOffset:-200];
        return;
    }
    
    //todo执行登录的操作
    [self RegisterWithPhone:phone WithCode:code WithPwd:pwd];
}
/**
 注册的方法
 @param phone 电话号码
 @param code 验证码
 @param pwd 密码
 */
-(void)RegisterWithPhone:(NSString *)phone WithCode:(NSString *)code WithPwd:(NSString *)pwd
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *longitude = [[NSUserDefaults standardUserDefaults]valueForKey:ZF_Longitude];
    NSString *latitude = [[NSUserDefaults standardUserDefaults]valueForKey:ZF_Latitude];
    param[@"phone"]    = phone;
    param[@"password"] = pwd;
    param[@"roleId"]     = self.selectRoleType;
    param[@"longitude"]   = longitude;
    param[@"latitude"]   = latitude;
    [SVProgressHUD showWithStatus:@"正在注册"];
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:User_Register_URL parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            //这里去做一个登录操作
            [weakSelf pushToTabbarMethodWithUserPhone:phone WithUserPwd:pwd];
        }else{
            [SVProgressHUD showWithStatus:res.msg];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        return;
    }];
}

-(void)pushToTabbarMethodWithUserPhone:(NSString *)phone WithUserPwd:(NSString *)pwd
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = phone;
    param[@"password"] = pwd;
    [SVProgressHUD showWithStatus:@"正在登录"];
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:User_Login_URL parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"resoponseObject:%@",responseObject);
        [SVProgressHUD dismiss];
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code ==1) {
            [SVProgressHUD showInfoWithStatus:@"登录成功"];
            //请求成功
            [[NSUserDefaults standardUserDefaults]setValue:res.data[@"token"] forKey:ZF_Token];
            [[NSUserDefaults standardUserDefaults]synchronize];
            UserModel *user = [UserModel mj_objectWithKeyValues:res.data[@"user"]];
            [UserModel save:user];
            //跳转到首页
            AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
            app.window.backgroundColor = [UIColor whiteColor];
            TabBarController *tabbar = [[TabBarController alloc]init];
            app.window.backgroundColor = [UIColor whiteColor];
            app.window.rootViewController = tabbar;
            [app.window makeKeyAndVisible];
        }else{
            //请求失败
            [SVProgressHUD showErrorWithStatus:res.data[@"msg"]];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        return;
    }];
}
/**
 获取验证码
 @param sender 获取验证码
 */
- (IBAction)actionCodeBtn:(UIButton *)sender
{
    NSString *phone = self.phoe_tf.text;
    NSString *ship  = self.ship_tf.text;
    if (phone.length == 0 || [phone isEqualToString:@""]) {
        [self showHint:@"手机号码不能为空" yOffset:-200];
        return;
    }
    if (![LCUtil isMobileNumber:phone]) {
        [self showHint:@"手机号码有误" yOffset:-200];
        return;
    }
    if (ship.length == 0 || [ship isEqualToString:@""]) {
        [self showHint:@"图形文字不能为空" yOffset:-200];
        return;
    }
    if (![ship isEqualToString:self.code_view.CodeStr]) {
        [self showHint:@"图形文字不正确" yOffset:-200];
        return;
    }
    //获取验证码
    [SVProgressHUD showWithStatus:@"获取验证中"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = phone;
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:User_Get_Code parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responseobject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:@"获取成功"];
            weakSelf.code_str = res.data[@"msg"];
            [sender startWithTime:59 title:@"获取验证码" countDownTitle:@"秒" mainColor:MainThemeColor countColor:[UIColor clearColor]];
        }else{
            [SVProgressHUD showErrorWithStatus:res.data[@"error"]];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        return;
    }];
}
/*
 眼睛的隐藏
 @param sender 眼睛的隐藏
 */
- (IBAction)acitonEyeBtn:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.pwd_tf.secureTextEntry = NO;
        [self.eye_btn setImage:[UIImage imageNamed:@"eye_sel.png"] forState:UIControlStateNormal];
    }else{
        self.pwd_tf.secureTextEntry = YES;
        [self.eye_btn setImage:[UIImage imageNamed:@"eye_nor.png"] forState:UIControlStateNormal];
    }
}
/**
 @param sender 同意的按钮
 */
- (IBAction)actionAgreeBtn:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.agree_btn setImage:[UIImage imageNamed:@"agree_sel"] forState:UIControlStateNormal];
        self.isAgree = YES;
    }else{
        [self.agree_btn setImage:[UIImage imageNamed:@"agree_nor"] forState:UIControlStateNormal];
        self.isAgree = NO;
    }
}
/**
 跳转到协议
 @param sender 跳转到协议
 */
- (IBAction)actionPushProtoclBtn:(UIButton *)sender
{
    AgreeProtolVC *agreevc = [[AgreeProtolVC alloc]init];
    [self.navigationController pushViewController:agreevc animated:YES];
}
@end
