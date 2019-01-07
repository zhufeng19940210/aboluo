//  ServerVC.m
//  aboluo
//  Created by zhufeng on 2018/11/10.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "ServerVC.h"
#import "MLMenuView.h"
#import "ServerBillinghallVC.h" //发单
#import "ServerOrdehallVC.h"    //接单
#import "SeverBillingRuleListVC.h" //发单规范
#import "ServerOrderruleListVC.h"   //接单规范
#import "SeverJoinplatformVC.h" //加入平台
#import "SeverAcceptanceListVC.h"   ///验收须知

@interface ServerVC ()
@property (weak, nonatomic) IBOutlet UITextView *textview;
@end
@implementation ServerVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"服务大厅";
    [self setRightButton:[UIImage imageNamed:@"sever_add"]];
    [self setupTextView];
    //[self setupData];
}

-(void)setupTextView
{
    self.textview.layer.cornerRadius = 8.0f;
    self.textview.layer.masksToBounds = YES;
    self.textview.layer.borderWidth = 1.0;
    self.textview.layer.borderColor = MainThemeColor.CGColor;
}
/*
 请求数据
 */
-(void)setupData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:@"" parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responobjet:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            weakSelf.textview.text = @"jjfjdskfdsklfksdfdksfkjdskfkjdskfdsjkfdkslfjkdsfjldsjfkdsakfjdslkfdsk";
        }else{
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
/**
 RightButton
 @param button RightButton
 */
- (void)onRightBtnAction:(UIButton *)button
{
    NSArray *titles = @[@"我的发单",@"发单规范",@"接单规范",@"验收须知"];
    NSArray *images = @[@"server_fadan",@"server_fadanguifan",@"server_jiedanguifan",@"server_yanshou"];
    MLMenuView *menuView = [[MLMenuView alloc] initWithFrame:CGRectMake(IPHONE_WIDTH - 120 - 10, 0, 120, 44 * 4) WithTitles:titles WithImageNames:images WithMenuViewOffsetTop:Height_NavBar WithTriangleOffsetLeft:100];
    menuView.didSelectBlock = ^(NSInteger index) {
        NSLog(@"%ld",(long)index);
        if (index == 0) {
            //我的发单
            ServerBillinghallVC *billinghallvc = [[ServerBillinghallVC alloc]init];
            [self.navigationController pushViewController:billinghallvc animated:YES];
        }if (index == 1) {
            //发单规范
            SeverBillingRuleListVC *billingrulevc = [[SeverBillingRuleListVC alloc]init];
            [self.navigationController pushViewController:billingrulevc animated:YES];
        }if (index == 2){
            //接单规范
            ServerOrderruleListVC *ordervc = [[ServerOrderruleListVC alloc]init];
            [self.navigationController pushViewController:ordervc animated:YES];
        }if (index == 3) {
            //平台验收
            SeverAcceptanceListVC *acceptancevc = [[SeverAcceptanceListVC alloc]init];
            [self.navigationController pushViewController:acceptancevc animated:YES];
        }
    };
    [menuView showMenuEnterAnimation:MLEnterAnimationStyleRight];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
