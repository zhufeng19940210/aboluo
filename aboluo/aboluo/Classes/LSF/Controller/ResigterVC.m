//  ResigterVC.m
//  aboluo
//  Created by zhufeng on 2018/11/3.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "ResigterVC.h"
#import "AgreeProtolVC.h"
#import "ImageCodeView.h"
#import "UIButton+countDown.h"
@interface ResigterVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoe_tf;
@property (weak, nonatomic) IBOutlet UITextField *code_tf;
@property (weak, nonatomic) IBOutlet UITextField *pwd_tf;
@property (weak, nonatomic) IBOutlet UIButton *eye_btn;
@property (weak, nonatomic) IBOutlet UIButton *agree_btn;
@property (weak, nonatomic) IBOutlet ImageCodeView *code_view;
@property (weak, nonatomic) IBOutlet UITextField *ship_tf;
@property (weak, nonatomic) IBOutlet UIButton *code_btn;
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
    NSString *ship  = self.ship_tf.text;
    if ([phone isEqualToString:@""] || phone.length == 0) {
        [self showHint:@"手机号码不能为空" yOffset:-200];
        return;
    }
    if (![LCUtil isMobileNumber:phone]) {
        [self showHint:@"手机号码有误" yOffset:-200];
        return;
    }
    /*
    if (ship.length == 0 || [ship isEqualToString:@""]) {
        [self showHint:@"图形文字不能为空" yOffset:-200];
        return;
    }
    if (![ship isEqualToString:self.code_view.CodeStr]) {
        [self showHint:@"图形文字不正确" yOffset:-200];
        return;
    }
     */
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
    NSString *longitude = [[NSUserDefaults standardUserDefaults]valueForKey:ZF_Longitude];
    NSString *latitude = [[NSUserDefaults standardUserDefaults]valueForKey:ZF_Latitude];
    param[@"phone"]    = phone;
    param[@"password"] = pwd;
    param[@"role"]     = self.selectRoleType;
    param[@"recommendId"] = @1;
    param[@"longitude"]   = longitude;
    param[@"latitude"]   = latitude;
    [SVProgressHUD showWithStatus:@"正在注册"];
    [[NetWorkTool shareInstacne]postWithURLString:User_Register_URL parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if ([res.code isEqualToString:@"1"]) {
            [ZFCustomView showWithSuccess:res.msg];
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
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = phone;
    [[NetWorkTool shareInstacne]postWithURLString:User_Get_Code parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"responseobject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if ([res.code isEqualToString:@"1"]) {
            [sender startWithTime:59 title:@"获取验证码" countDownTitle:@"S" mainColor:MainThemeColor countColor:[UIColor clearColor]];
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
}
/**
 获取验证码
 @param phone 获取验证码
 */
-(void)getCodeWithPhone:(NSString *)phone
{
   
}
/**
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
    }else{
        [self.agree_btn setImage:[UIImage imageNamed:@"agree_nor"] forState:UIControlStateNormal];
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
