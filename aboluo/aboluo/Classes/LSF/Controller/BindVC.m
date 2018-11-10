//  BindVC.m
//  aboluo
//  Created by zhufeng on 2018/11/4.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "BindVC.h"
@interface BindVC ()
@property (weak, nonatomic) IBOutlet UITextField *phone_tf;
@property (weak, nonatomic) IBOutlet UITextField *code_tf;
@property (weak, nonatomic) IBOutlet UITextField *pwd_tf;
@property (weak, nonatomic) IBOutlet UIButton *eye_btn;
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
    NSString *phone = self.phone_tf.text;
    if (phone.length == 0 || [phone isEqualToString:@""]) {
        [self showHint:@"手机号码不能为空" yOffset:-200];
        return;
    }
    if (![LCUtil isMobileNumber:phone]) {
        [self showHint:@"手机号码有误" yOffset:-200];
        return;
    }
    //todo去执接下来的操作
}
/**
 下一步
 @param sender 下一步
 */
- (IBAction)actionNextBtn:(UIButton *)sender
{
    NSString *phone     = self.phone_tf.text;
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
    if (code.length == 0 || [code isEqualToString:@""]) {
        [self showHint:@"验证码不能为空" yOffset:-200];
        return;
    }
    if (pwd.length == 0 || [pwd isEqualToString:@""]) {
        [self showHint:@"密码不能为空" yOffset:-200];
        return;
    }
    //todo执行接下来的操作
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
