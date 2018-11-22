//  BindVC.m
//  aboluo
//  Created by zhufeng on 2018/11/4.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "BindVC.h"
#import "ImageCodeView.h"
#import "UIButton+countDown.h"
#import "AppDelegate.h"
#import "TabBarController.h"
@interface BindVC ()
@property (weak, nonatomic) IBOutlet UITextField *phone_tf;
@property (weak, nonatomic) IBOutlet UITextField *code_tf;
@property (weak, nonatomic) IBOutlet UITextField *pwd_tf;
@property (weak, nonatomic) IBOutlet UIButton *eye_btn;
@property (weak, nonatomic) IBOutlet UITextField *number_tf;
@property (weak, nonatomic) IBOutlet ImageCodeView *code_view;
@property (nonatomic,copy)  NSString *codeStr; ///验证码的东西
@end
@implementation BindVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"绑定手机";
}
/**
获取验证码
 @param sender 获取验证码
 */
- (IBAction)actionGetCodeBtn:(UIButton *)sender
{
    NSString *phone     = self.phone_tf.text;
    NSString *nubmer    = self.number_tf.text;
    if (phone.length == 0 || [phone isEqualToString:@""]) {
        [self showHint:@"手机号码不能为空" yOffset:-200];
        return;
    }
    if (![LCUtil isMobileNumber:phone]) {
        [self showHint:@"手机号码有误" yOffset:-200];
        return;
    }
    if (nubmer.length == 0 || [nubmer isEqualToString:@""]) {
        [self showHint:@"图形数字不能为空" yOffset:-200];
        return;
    }
    if (![nubmer isEqualToString: self.code_view.CodeStr]) {
        [self showHint:@"图片数字有误" yOffset:-200];
        return;
    }
    //获取验证码
    [SVProgressHUD showWithStatus:@"获取验证中"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = phone;
    [[NetWorkTool shareInstacne]postWithURLString:User_Get_Code parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responseobject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:@"获取成功"];
            self.codeStr = res.data[@"msg"];
            [sender startWithTime:59 title:@"获取验证码" countDownTitle:@"秒" mainColor:MainThemeColor countColor:[UIColor clearColor]];
        }else{
            [SVProgressHUD showErrorWithStatus:res.data[@"error"]];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        return;
    }];
    
    
}
/**
 下一步
 @param sender 下一步
 */
- (IBAction)actionNextBtn:(UIButton *)sender
{
    NSString *phone     = self.phone_tf.text;
    NSString *number    = self.number_tf.text;
    NSString *code      = self.code_tf.text;
    NSString *pwd       = self.pwd_tf.text;
    if (phone.length == 0 || [phone isEqualToString:@""]) {
        [self showHint:@"手机号不能为空" yOffset:-200];
        return;
    }
    if (![LCUtil isMobileNumber:phone]) {
        [self showHint:@"手机号码有误" yOffset:-200];
        return;
    }
    if (number.length == 0 || [number isEqualToString:@""]) {
        [self showHint:@"图形数字不能为空" yOffset:-200];
        return;
    }
    if (![number isEqualToString:self.code_view.CodeStr]) {
        [self showHint:@"图形数字有误" yOffset:-200];
        return;
    }
    if (code.length == 0 || [code isEqualToString:@""]) {
        [self showHint:@"验证码不能为空" yOffset:-200];
        return;
    }
    if (pwd.length == 0 || [pwd isEqualToString:@""]) {
        [self showHint:@"密码不能为空" yOffset:-200];
        return;
    }
    //todo这个是去做注册的操作
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *longitude = [[NSUserDefaults standardUserDefaults]valueForKey:ZF_Longitude];
    NSString *latitude = [[NSUserDefaults standardUserDefaults]valueForKey:ZF_Latitude];
    param[@"phone"]    = phone;
    param[@"password"] = pwd;
    param[@"roleId"]     = self.selectRole;
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
            [weakSelf pushBindTabbarWithUserUsername:phone withPwd:pwd];
        }else{
            [SVProgressHUD showWithStatus:res.msg];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        return;
    }];
}

-(void)pushBindTabbarWithUserUsername:(NSString *)username withPwd:(NSString *)userpwd
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = username;
    param[@"password"] = userpwd;
    [SVProgressHUD show];
    [[NetWorkTool shareInstacne]postWithURLString:User_Login_URL parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"resoponseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            NSString *token = res.data[@"token"];
            [[NSUserDefaults standardUserDefaults]setValue:token forKey:ZF_Token];
            [[NSUserDefaults standardUserDefaults]synchronize];
            UserModel *usermodel = [UserModel mj_objectWithKeyValues:res.data[@"user"]];
            [UserModel save:usermodel];
            //跳转到首页
            AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
            app.window.backgroundColor = [UIColor whiteColor];
            TabBarController *tabbar = [[TabBarController alloc]init];
            app.window.backgroundColor = [UIColor whiteColor];
            app.window.rootViewController = tabbar;
            [app.window makeKeyAndVisible];
        }else{
            [SVProgressHUD showErrorWithStatus:@"登录失败"];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        return;
    }];
}
/**
 显示密码功能
 @param sender 显示密码功能
 */
- (IBAction)actinoEyeBtn:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.pwd_tf.secureTextEntry = NO;
        [self.eye_btn setImage:[UIImage imageNamed:@"eye_sel"] forState:UIControlStateNormal];
    }else{
        self.pwd_tf.secureTextEntry = YES;
        [self.eye_btn setImage:[UIImage imageNamed:@"eye_nor"] forState:UIControlStateNormal];
    }
}
@end
