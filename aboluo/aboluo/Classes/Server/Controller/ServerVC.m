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
    [SVProgressHUD showWithStatus:ShowTitleTip];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:@"" parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responobjet:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:ShowSuccessTip];
            weakSelf.textview.text = @"jjfjdskfdsklfksdfdksfkjdskfkjdskfdsjkfdkslfjkdsfjldsjfkdsakfjdslkfdsk";
        }else{
            [SVProgressHUD showErrorWithStatus:ShowErrorTip];
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
    NSArray *titles = @[@"我的发单",@"我的接单",@"发单规范",@"接单规范"];
    NSArray *images = @[@"server_fadan",@"server_jiedan",@"server_fadanguifan",@"server_jiedanguifan"];
    MLMenuView *menuView = [[MLMenuView alloc] initWithFrame:CGRectMake(IPHONE_WIDTH - 120 - 10, 0, 120, 44 * 4) WithTitles:titles WithImageNames:images WithMenuViewOffsetTop:Height_NavBar WithTriangleOffsetLeft:100];
    menuView.didSelectBlock = ^(NSInteger index) {
        NSLog(@"%ld",(long)index);
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
