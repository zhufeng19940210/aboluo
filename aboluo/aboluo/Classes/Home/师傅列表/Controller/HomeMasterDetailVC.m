//  HomeMasterDetailVC.m
//  aboluo
//  Created by zhufeng on 2018/11/25.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "HomeMasterDetailVC.h"
@interface HomeMasterDetailVC ()
@property (nonatomic,strong)NSDictionary *resParam;
@end

@implementation HomeMasterDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"师傅详情";
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
    [SVProgressHUD showWithStatus:ShowSuccessTip];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = @"";
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Master_Deatil parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"师傅详情:%@",responseObject);
        [SVProgressHUD dismiss];
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:ShowSuccessTip];
            weakSelf.resParam = res.data[@""];
            [weakSelf refresh];
        }else{
            [SVProgressHUD showErrorWithStatus:ShowErrorTip];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        return ;
    }];
}

@end
