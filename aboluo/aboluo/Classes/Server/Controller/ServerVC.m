//  ServerVC.m
//  aboluo
//  Created by zhufeng on 2018/11/10.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "ServerVC.h"
#import "MLMenuView.h"
#define TITLES @[@"我的发单", @"我的接单",@"发单规范",@"接单规范"]
#define ICONS  @[@"sever_add",@"sever_add",@"sever_add",@"sever_add"]
#define  k_StatusBarHeight    [UIApplication sharedApplication].statusBarFrame.size.height
#define  k_NavigationBarHeight  44.f
#define  k_StatusBarAndNavigationBarHeight   (k_StatusBarHeight + k_NavigationBarHeight)
@interface ServerVC ()
@end
@implementation ServerVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"服务";
    [self setRightButton:[UIImage imageNamed:@"sever_add"]];
}
/**
 RightButton
 @param button RightButton
 */
- (void)onRightBtnAction:(UIButton *)button
{
    NSArray *titles = @[@"发起群聊",@"添加朋友",@"扫一扫",@"收付款"];
    NSArray *images = @[@"sever_add",@"sever_add",@"sever_add",@"sever_add"];
    MLMenuView *menuView = [[MLMenuView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100 - 10, 0, 100, 44 * 4) WithTitles:titles WithImageNames:images WithMenuViewOffsetTop:k_StatusBarAndNavigationBarHeight WithTriangleOffsetLeft:80];
    menuView.didSelectBlock = ^(NSInteger index) {
        NSLog(@"%zd",index);
    };
    [menuView showMenuEnterAnimation:MLEnterAnimationStyleRight];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
