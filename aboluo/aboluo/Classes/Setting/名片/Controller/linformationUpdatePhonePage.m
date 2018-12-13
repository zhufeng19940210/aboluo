//  linformationUpdatePhonePage.m
//  aboluo
//  Created by zhufeng on 2018/12/9.
//  Copyright © 2018 zhufeng. All rights reserved.

#import "linformationUpdatePhonePage.h"

@interface linformationUpdatePhonePage ()
@property (weak, nonatomic) IBOutlet UITextField *phone_tf;
@end

@implementation linformationUpdatePhonePage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改手机号码";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
/**
 修改手机号码
 @param sender 修改手机号码
 */
- (IBAction)actionUpdateBtn:(UIButton *)sender
{
    UserModel *usermodel = [UserModel getInfo];
    NSString *phone = self.phone_tf.text;
    if(phone.length == 0 || [phone isEqualToString:@""]){
        [self showHint:@"手机号码不为空" yOffset:-200];
        return;
    }
    if (phone.length != 11) {
        [self showHint:@"手机号码有误" yOffset:-200];
        return;
    }
    [SVProgressHUD showWithStatus:ShowTitleTip];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] =  usermodel.aid;
    param[@"phone"]  = phone;
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:User_Update_Phone parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
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
