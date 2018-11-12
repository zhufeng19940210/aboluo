//  RoleSelectVC.m
//  aboluo
//  Created by zhufeng on 2018/11/10.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "RoleSelectVC.h"
#import "ResigterVC.h"
@interface RoleSelectVC ()
@property (weak, nonatomic) IBOutlet UIImageView *geren_img;
@property (weak, nonatomic) IBOutlet UIImageView *qiye_img;
@property (weak, nonatomic) IBOutlet UILabel *geren_lab;
@property (weak, nonatomic) IBOutlet UILabel *qiye_lab;
@property (nonatomic,assign)BOOL isSelect;
@property (nonatomic,copy)NSString *selectRoleStr;
@property (weak, nonatomic) IBOutlet UIImageView *geren_agree_sel;
@property (weak, nonatomic) IBOutlet UIImageView *qiye_agree_sel;
@end
@implementation RoleSelectVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择角色";
    self.view.backgroundColor = RGB(240, 240, 240);
}
/**
 个人
 @param sender 个人
 */
- (IBAction)actionPersonBtn:(UIButton *)sender
{
    self.geren_img.image = [UIImage imageNamed:@"geren_sel"];
    self.qiye_img.image  = [UIImage imageNamed:@"qiye_nor"];
    self.geren_lab.textColor =  MainThemeColor;
    self.qiye_lab.textColor = [UIColor blackColor];
    self.isSelect = YES;
    self.selectRoleStr = @"0";
    self.geren_agree_sel.hidden = NO;
    self.qiye_agree_sel.hidden = YES;
}
/**
 企业
 @param sender 企业
 */
- (IBAction)actionQiyeBtn:(UIButton *)sender
{
    self.geren_img.image = [UIImage imageNamed:@"geren_nor"];
    self.qiye_img.image  = [UIImage imageNamed:@"qiye_sel"];
    self.geren_lab.textColor =  [UIColor blackColor];
    self.qiye_lab.textColor = MainThemeColor;
    self.isSelect = YES;
    self.selectRoleStr = @"1";
    self.geren_agree_sel.hidden = YES;
    self.qiye_agree_sel.hidden = NO;
}
/**
 下一步
 @param sender 下一步
 */
- (IBAction)actionNextBtn:(UIButton *)sender
{
    if (!self.isSelect) {
        [self showHint:@"请先选择角色" yOffset:-200];
        return;
    }
    ResigterVC *resigtervc = [[ResigterVC alloc]init];
    resigtervc.selectRoleType = self.selectRoleStr;
    [self.navigationController pushViewController:resigtervc animated:YES];
}
@end
