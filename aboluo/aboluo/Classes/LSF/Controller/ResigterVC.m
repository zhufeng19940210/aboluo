//  ResigterVC.m
//  aboluo
//  Created by zhufeng on 2018/11/3.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "ResigterVC.h"
@interface ResigterVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoe_tf;
@property (weak, nonatomic) IBOutlet UITextField *code_tf;
@property (weak, nonatomic) IBOutlet UITextField *pwd_tf;
@end
@implementation ResigterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
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
    if ([phone isEqualToString:@""] || phone.length == 0) {
        [self showHint:@"手机号码不能为空" yOffset:-200];
        return;
    }
    if (![LCUtil isMobileNumber:phone]) {
        [self showHint:@"手机号码有误" yOffset:-200];
        return;
    }
    if ([code isEqualToString:@""] || code.length == 0) {
        [self showHint:@"验证码有误" yOffset:-200];
        return;
    }
    if ([pwd isEqualToString:@""] || pwd.length == 0) {
        [self showHint:@"密码不能为空" yOffset:-200];
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
    param[@"phone"] = phone;
    param[@"password"] = pwd;
    [SVProgressHUD showWithStatus:@"正在注册"];
    [[NetWorkTool shareInstacne]postWithURLString:User_Register_URL parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if ([res.code isEqualToString:@"1"]) {
            [ZFCustomView showWithSuccess:res.msg];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [ZFCustomView showWithText:res.msg WithDurations:0.5];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
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
    if (phone.length == 0 || [phone isEqualToString:@""]) {
        [self showHint:@"手机号码不能为空" yOffset:-200];
        return;
    }
    if (![LCUtil isMobileNumber:phone]) {
        [self showHint:@"手机号码有误" yOffset:-200];
        return;
    }
    //获取验证码
    [self getCodeWithPhone:phone];
}
/**
 获取验证码
 @param phone 获取验证码
 */
-(void)getCodeWithPhone:(NSString *)phone
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [[NetWorkTool shareInstacne]postWithURLString:User_Get_Code parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"responseobject:%@",responseObject);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
}
@end
