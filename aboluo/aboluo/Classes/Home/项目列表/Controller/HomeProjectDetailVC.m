//  HomeProjectDetailVC.m
//  aboluo
//  Created by zhufeng on 2018/11/25.
//  Copyright © 2018 zhufeng. All rights reserved
#import "HomeProjectDetailVC.h"
@interface HomeProjectDetailVC ()
@property (nonatomic,strong)NSMutableDictionary *resParam;
@end
@implementation HomeProjectDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"项目详情";
    self.view.backgroundColor = RGB(240, 240, 240);
    [self setupData];
}
/**
 刷新界面
 */
-(void)refresh
{
    NSLog(@"刷新界面");
}
/**
 请求数据
 */
-(void)setupData
{
    [SVProgressHUD showWithStatus:ShowTitleTip];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"projectId"] = @"";
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Project_Detail parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"项目详情responseobject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:ShowSuccessTip];
            weakSelf.resParam = res.data[@"data"];
            [weakSelf refresh];
        }else{
            [SVProgressHUD showErrorWithStatus:ShowErrorTip];
            return ;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        return;
    }];
}
@end
