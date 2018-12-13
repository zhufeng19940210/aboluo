//  StoreProductDetailVC.m
//  aboluo
//  Created by zhufeng on 2018/12/8.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "StoreProductDetailVC.h"
@interface StoreProductDetailVC ()
@property (nonatomic,strong)UITableView *tableview;
@end
@implementation StoreProductDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品详情";
    [self actionNewData];
    [self setupRerfresh];
}
-(void)setupRerfresh
{
    [self setViewRefreshTableView:self.tableview
                  withHeaderAction:@selector(actionNewData)
                  andFooterAction:nil target:self];
}
-(void)actionNewData
{
    [SVProgressHUD showWithStatus:ShowTitleTip];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"itemId"] = self.orderId;
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Store_Detail parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:ShowSuccessTip];
        }else{
            [SVProgressHUD showErrorWithStatus:res.msg];
            return;
        }
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_header endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        return;
    }];
}
@end
