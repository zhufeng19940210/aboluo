//  LoginVC.m
//  aboluo
//  Created by zhufeng on 2018/11/3.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "LoginVC.h"
#import "ResigterVC.h"
#import "ForgetPwdVC.h"
#import "TabBarController.h"
#import "AppDelegate.h"
#import "RoleSelectVC.h"
@interface LoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *phone_tf;
@property (weak, nonatomic) IBOutlet UITextField *pwd_tf;
@property (weak, nonatomic) IBOutlet UIButton *eye_btn;
@end
@implementation LoginVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
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
    RoleSelectVC *roleSelectvc = [[RoleSelectVC alloc]init];
    [self.navigationController pushViewController:roleSelectvc animated:YES];
}
/**
 登录方法
 @param sender 登录方法
 */
- (IBAction)actionLoginBtn:(UIButton *)sender
{
    NSString *phone = self.phone_tf.text;
    NSString *pwd   = self.pwd_tf.text;
    if (phone.length == 0 || [phone isEqualToString:@""]) {
        [self showHint:@"手机号码不能为空" yOffset:-200];
        return;
    }
    if (pwd.length == 0 || [pwd isEqualToString:@""]) {
        [self showHint:@"密码不能为空" yOffset:-200];
        return;
    }
    //开始去登录
    [self loginWithPhone:phone withPwd:pwd];
}
/**
 登录方法
 @param phone 电话号码
 @param pwd 密码
 */
-(void)loginWithPhone:(NSString *)phone withPwd:(NSString *)pwd
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = phone;
    param[@"password"] = pwd;
    [SVProgressHUD showWithStatus:@"正在登录"];
    [[NetWorkTool shareInstacne]postWithURLString:User_Login_URL parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"resoponseObject:%@",responseObject);
        [SVProgressHUD dismiss];
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code ==1) {
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
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
 用户忘记密码
 @param sender 用户忘记密码
 */
- (IBAction)actionForgetPwdBtn:(UIButton *)sender
{
    ForgetPwdVC *forgetpwdvc = [[ForgetPwdVC alloc]init];
    [self.navigationController pushViewController:forgetpwdvc animated:YES];
}
/**
 眼睛的隐藏
 @param sender 眼睛的隐藏
 */
- (IBAction)actionEyeBtn:(UIButton *)sender
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
/**
 三方登录
 @param sender 三方登录
 */
- (IBAction)actionThirdLoginBtn:(UIButton *)sender
{
    int tag = (int)sender.tag;
    int platform;
    NSString *platformType = nil;
    if (tag == 0) {
        //微信登录
        platform = SSDKPlatformTypeWechat;
        platformType = @"wx";
    }else{
        //qq登录
        platform = SSDKPlatformTypeQQ;
        platformType = @"qq";
    }
    [self ThirdAuthorMethodWithPlatform:platform WithType:platformType];
}
/**
 三方登录的方法
 */
-(void)ThirdAuthorMethodWithPlatform:(int)platform WithType:(NSString *)platformType
{
    [SVProgressHUD showWithStatus:@"正在授权"];
    [ShareSDK authorize:platform settings:nil onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        [SVProgressHUD dismiss];
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                NSLog(@"授权成功");
                NSLog(@"userid:%@",user.uid);
                NSLog(@"usericon:%@",user.icon);
                NSLog(@"username:%@",user.nickname);
                //这里有一个接口是否有绑定过数据,这里需要自己去判断下
                RoleSelectVC *selectRoloevc = [[RoleSelectVC alloc]init];
                
                [self.navigationController pushViewController:selectRoloevc animated:YES];
            }
                break;
            case SSDKResponseStateFail:
            {
                NSLog(@"授权失败");
            }
                break;
            case SSDKResponseStateCancel:
            {
                NSLog(@"授权取消了");
            }
                break;
            default:
                break;
        }
    }];
}

/**
 关闭button
 @param sender 关闭的button
 */
- (IBAction)actionCloseBtn:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
