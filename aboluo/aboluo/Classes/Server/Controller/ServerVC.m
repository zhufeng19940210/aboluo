//  ServerVC.m
//  aboluo
//  Created by zhufeng on 2018/11/10.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "ServerVC.h"
#import "MLMenuView.h"
#import "ServerBillinghallVC.h" //发单
#import "ServerOrdehallVC.h"    //接单
#import "ServerBillingruleVC.h" //发单规范
#import "ServerOrderruleVC.h"   //接单规范
@interface ServerVC ()
@end
@implementation ServerVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"服务大厅";
    [self setRightButton:[UIImage imageNamed:@"sever_add"]];
}
/**
 RightButton
 @param button RightButton
 */
- (void)onRightBtnAction:(UIButton *)button
{
    NSArray *titles = @[@"我的发单",@"我的接单",@"发单规范",@"接单规范"];
    NSArray *images = @[@"home_scan",@"home_pay",@"home_reexceipt",@"home_exchange"];
    MLMenuView *menuView = [[MLMenuView alloc] initWithFrame:CGRectMake(IPHONE_WIDTH - 120 - 10, 0, 120, 44 * 4) WithTitles:titles WithImageNames:images WithMenuViewOffsetTop:Height_NavBar WithTriangleOffsetLeft:100];
    menuView.didSelectBlock = ^(NSInteger index) {
        NSLog(@"%zd",index);
        if (index == 0) {
            //我的发单
            ServerBillinghallVC *billinghallvc = [[ServerBillinghallVC alloc]init];
            [self.navigationController pushViewController:billinghallvc animated:YES];
        }if (index == 1) {
            //我的接单
            ServerOrdehallVC *orderhallvc = [[ServerOrdehallVC alloc]init];
            [self.navigationController pushViewController:orderhallvc animated:YES];
        }if (index == 2) {
            //发单规范
            ServerBillingruleVC *billingrulevc = [[ServerBillingruleVC alloc]init];
            [self.navigationController pushViewController:billingrulevc animated:YES];
        }if (index == 3){
            //接单规范
            ServerOrderruleVC *ordervc = [[ServerOrderruleVC alloc]init];
            [self.navigationController pushViewController:ordervc animated:YES];
        }
    };
    [menuView showMenuEnterAnimation:MLEnterAnimationStyleRight];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
