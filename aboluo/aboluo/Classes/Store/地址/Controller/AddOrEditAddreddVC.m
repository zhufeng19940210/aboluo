//  AddOrEditAddreddVC.m
//  aboluo
//  Created by zhufeng on 2018/11/19.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "AddOrEditAddreddVC.h"
#import "IQTextView.h"
#import "AddressModel2.h"
@interface AddOrEditAddreddVC ()
@property (weak, nonatomic) IBOutlet UITextField *name_tf;
@property (weak, nonatomic) IBOutlet UITextField *phone_tf;
@property (weak, nonatomic) IBOutlet IQTextView *detail_txt;
@property (weak, nonatomic) IBOutlet UIButton *default_btn;
@property (nonatomic,assign)NSInteger default_type; //默认地址
@property (nonatomic,strong)UserModel *usermodel;
@end
@implementation AddOrEditAddreddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.usermodel = [UserModel getInfo];
    if (self.isAdd == YES) {
        //添加状态
        self.navigationItem.title = @"添加收货地址";
        self.name_tf.text     =  self.addressmodel.receName;
        self.phone_tf.text   =  self.addressmodel.phone;
        self.detail_txt.text =  self.addressmodel.detailAddr;
        if (self.addressmodel.isDefault  == 1) {
            //是默认地址
            [self.default_btn setImage:[UIImage imageNamed:@"zf_circle_select"] forState:UIControlStateNormal];
        }else{
            //不是默认地址
            [self.default_btn setImage:[UIImage imageNamed:@"zf_circle_nor"] forState:UIControlStateNormal];
        }
    }else{
        ///编辑收货地址
        self.navigationItem.title = @"编辑收货地址";
        ///默认值
        self.default_type = 0;
        self.detail_txt.placeholder = @"请输入详细地址信息,如道路、门牌号、小区、楼栋号、单元等";
        self.detail_txt.font = [UIFont systemFontOfSize:15];
    }
}
/**
 设置默认的地址
 @param sender 设置默认地址
 */
- (IBAction)actionDefaultBtn:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.default_type = 1;
        [self.default_btn setImage:[UIImage imageNamed:@"zf_circle_select"] forState:UIControlStateNormal];
    }else{
        self.default_type = 0;
        [self.default_btn setImage:[UIImage imageNamed:@"zf_circle_nor"] forState:UIControlStateNormal];
    }
}
/**
 保存用户地址
 @param sender 保存用户地址
 */
- (IBAction)actionSaveBtn:(UIButton *)sender
{
    NSString *name   = self.name_tf.text;
    NSString *phone  = self.phone_tf.text;
    NSString *addres = self.detail_txt.text;
    if (name.length == 0 || [name isEqualToString:@""]) {
        [self showHint:@"姓名不能为空" yOffset:-200];
        return;
    }
    if (phone.length == 0 || [phone isEqualToString:@""]) {
        [self showHint:@"手机号码不能为空" yOffset:-200];
        return;
    }
    if (phone.length != 11) {
        [self showHint:@"手机号码有误" yOffset:-200];
        return;
    }
    if (addres.length == 0 || [addres isEqualToString:@""]) {
        [self showHint:@"详细地址不能为空" yOffset:-200];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = self.usermodel.aid;
    param[@"name"] = name;
    param[@"phone"] = phone;
    param[@"location"] = addres;
    param[@"turn"] = [NSString stringWithFormat:@"%ld",(long)self.default_type];
    [[NetWorkTool shareInstacne]postWithURLString:Address_Add_Url parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code==1) {
            if (!self.isAdd) {
                ///编辑成功
                [[NSNotificationCenter defaultCenter]postNotificationName:UPDATESUCCESS object:nil];
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                ///添加成功
                [[NSNotificationCenter defaultCenter]postNotificationName:UPDATESUCCESS object:nil];
                [SVProgressHUD showSuccessWithStatus:@"添加成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }else{
            if (!self.isAdd) {
                [SVProgressHUD showErrorWithStatus:@"修改失败"];
                return;
            }else{
                [SVProgressHUD showErrorWithStatus:@"添加失败"];
                return;
            }
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        return;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
