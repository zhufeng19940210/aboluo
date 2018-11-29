//  StroeProductDetailVC.m
//  aboluo
//  Created by zhufeng on 2018/11/25.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "StroeProductDetailVC.h"
@interface StroeProductDetailVC ()
@end
@implementation StroeProductDetailVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品详情";
    [self setupData];
}

/**
 请求数据
 */
-(void)setupData
{
    [SVProgressHUD showWithStatus:ShowTitleTip];
    NSMutableDictionary  *param = [NSMutableDictionary dictionary];
    param[@""] = @"";
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Store_Detail parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        [SVProgressHUD dismiss];
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:ShowSuccessTip];
        }else{
            [SVProgressHUD showErrorWithStatus:ShowErrorTip];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        return;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
