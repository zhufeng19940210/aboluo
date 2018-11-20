//  AddressListVC.m
//  aboluo
//  Created by zhufeng on 2018/11/17.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "AddressListVC.h"
#import "AddressListCell.h"
@interface AddressListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *addressArray;
@end
@implementation AddressListVC
-(NSMutableArray *)addressArray
{
    if (!_addressArray) {
        _addressArray = [NSMutableArray array];
    }
    return _addressArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"管理收货地址";
    self.view.backgroundColor = RGB(240, 240, 240);
    [self setupData];
    [self setupTableView];
}
/**
 请求数据
 */
-(void)setupData{
    
    [SVProgressHUD show];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@""] = @"";
    [[NetWorkTool shareInstacne]postWithURLString:@"" parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code ==1) {
            
        }else{
            
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        return ;
    }];
}
/**
 设置tableview
 */
-(void)setupTableView
{
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor clearColor];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
