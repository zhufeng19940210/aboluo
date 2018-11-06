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
    [SVProgressHUD showWithStatus:@"正在登录中。。。"];
    [[NetWorkTool shareInstacne]postWithURLString:User_Login_URL parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"resoponseObject:%@",responseObject);
        [SVProgressHUD dismiss];
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if ([res.code isEqualToString:@"1"]) {
            [ZFCustomView showWithSuccess:@"登录成功"];
            //请求成功
            [[NSUserDefaults standardUserDefaults]setValue:res.data[@"token"] forKey:Token];
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
            [ZFCustomView showWithText:res.msg WithDurations:0.5];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [ZFCustomView showWithText:FailRequestTip WithDurations:0.5];
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
@end
