//  UpdatePwdVC.m
//  aboluo
//  Created by zhufeng on 2018/12/8.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "UpdatePwdVC.h"
@interface UpdatePwdVC ()
@property (weak, nonatomic) IBOutlet UITextField *pwd_tf;
@end
@implementation UpdatePwdVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
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
