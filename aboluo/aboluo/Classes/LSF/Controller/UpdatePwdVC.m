//  UpdatePwdVC.m
//  aboluo
//  Created by zhufeng on 2018/12/8.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "UpdatePwdVC.h"
#import "UIButton+countDown.h"
@interface UpdatePwdVC ()
@property (weak, nonatomic) IBOutlet UITextField *phone_tf;
@property (weak, nonatomic) IBOutlet UITextField *code_tf;
@property (weak, nonatomic) IBOutlet UITextField *pwd_tf;
@property (weak, nonatomic) IBOutlet UITextField *pwd_again_tf;
@property (weak, nonatomic) IBOutlet UIButton *eye_btn1;
@property (weak, nonatomic) IBOutlet UIButton *eye_btn2;
@property (nonatomic,copy)NSString *code_str; // 验证码Str
@property (nonatomic,copy)NSString *phoneStr; //保存下手机号码
@property (nonatomic,strong)UserModel *usermodel;
@end
@implementation UpdatePwdVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.phoneStr = nil;
    self.navigationItem.title = @"修改密码";
    self.usermodel = [UserModel getInfo];
}
/**
 显示眼睛
 @param sender 显示眼睛
 */
- (IBAction)actionEye1Btn:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.pwd_tf.secureTextEntry = NO;
        [self.eye_btn1 setImage:[UIImage imageNamed:@"eye_sel"] forState:UIControlStateNormal];
    }else{
        self.pwd_tf.secureTextEntry = YES;
        [self.eye_btn1 setImage:[UIImage imageNamed:@"eye_nor"] forState:UIControlStateNormal];
    }
}
/**
 显示眼睛2
 @param sender 显示眼睛
 */
- (IBAction)actionEye2Btn:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.pwd_again_tf.secureTextEntry = NO;
        [self.eye_btn2 setImage:[UIImage imageNamed:@"eye_sel"] forState:UIControlStateNormal];
    }else{
        self.pwd_again_tf.secureTextEntry = YES;
        [self.eye_btn2 setImage:[UIImage imageNamed:@"eye_nor"] forState:UIControlStateNormal];
    }
}
/**
 获取验证码
 @param sender 获取验证码
 */
- (IBAction)actionGetCodeBtn:(id)sender
{
    NSString *phone = self.phone_tf.text;
    if (phone.length == 0 || [phone isEqualToString:@""]) {
        [self showHint:@"手机号码不能为空" yOffset:-200];
        return;
    }
    if (![LCUtil isMobileNumber:phone]) {
        [self showHint:@"手机号码有误" yOffset:-200];
        return;
    }
    //获取验证码
    [SVProgressHUD showWithStatus:@"获取验证"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = phone;
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:User_Update_Code parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responseobject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:@"获取成功"];
            weakSelf.phoneStr = phone;
            self.code_str = res.data[@"msg"];
            [sender startWithTime:59 title:@"获取验证码" countDownTitle:@"秒" mainColor:MainThemeColor countColor:[UIColor clearColor]];
        }else{
            [ZFCustomView showWithSuccess:res.data[@"error"]];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        return;
    }];
}

/**
  提交
 @param sender 提交
 */
- (IBAction)actionCompleBtn:(UIButton *)sender
{
    //取消第一响应者
    [self.phone_tf resignFirstResponder];
    [self.code_tf resignFirstResponder];
    [self.pwd_tf resignFirstResponder];
    [self.pwd_again_tf resignFirstResponder];
    NSString *phone     = self.phone_tf.text;
    NSString *code      = self.code_tf.text;
    NSString *pwd       = self.pwd_tf.text;
    NSString *pwd_again = self.pwd_again_tf.text;
    if (phone.length == 0 || [phone isEqualToString:@""]) {
        [self showHint:@"手机号不能为空" yOffset:-200];
        return;
    }
    if (![LCUtil isMobileNumber:phone]) {
        [self showHint:@"手机号码有误" yOffset:-200];
        return;
    }
    if (![phone isEqualToString:self.phoneStr]) {
        [self showHint:@"手机号码有误" yOffset:-200];
        return;
    }
    if (code.length == 0 || [code isEqualToString:@""]) {
        [self showHint:@"验证码不能为空" yOffset:-200];
        return;
    }
    if (![code isEqualToString:self.code_str]) {
        [self showHint:@"验证码有误" yOffset:-200];
        return;
    }
    if (pwd.length == 0 || [pwd isEqualToString:@""]) {
        [self showHint:@"密码不能为空" yOffset:-200];
        return;
    }
    if (pwd_again.length == 0 || [pwd_again isEqualToString:@""]) {
        [self showHint:@"请再次输入密码" yOffset:-200];
        return;
    }
    if (![pwd isEqualToString:pwd_again]) {
        [self showHint:@"两次密码不一致" yOffset:-200];
        return;
    }
    //开始去做修改密码
    [SVProgressHUD showWithStatus:ShowTitleTip];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = self.usermodel.aid;
    param[@"password"] = pwd;
    [[NetWorkTool shareInstacne]postWithURLString:User_Update_Pwd parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        }else{
            [SVProgressHUD showErrorWithStatus:res.msg];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        return;
    }];
}

/**
 提交订单
 @param sender 提交订单
 */
- (IBAction)actionConfirmBtn:(UIButton *)sender
{
    NSString *pwd = self.pwd_tf.text;
    if (pwd.length == 0 || [pwd isEqualToString:@""]) {
        [self showHint:@"请输入新密码" yOffset:-200];
        return;
    }
    [SVProgressHUD showWithStatus:ShowTitleTip];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"password"] = pwd;
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:User_Update_Pwd parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        [SVProgressHUD dismiss];
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:ShowSuccessTip];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:res.msg];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        return;
    }];
}
@end
