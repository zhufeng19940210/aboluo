//  StoreDetailVC.m
//  aboluo
//  Created by zhufeng on 2018/11/16.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "StoreDetailVC.h"
#import "StoreCell.h"
@interface StoreDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *storeArray;
@end
@implementation StoreDetailVC
-(NSMutableArray *)storeArray
{
    if (!_storeArray) {
        _storeArray = [NSMutableArray array];
    }
    return _storeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupTableView];
}
/**
 请求数据
 */
-(void)setupData
{
    [SVProgressHUD showWithStatus:ShowTitleTip];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@""] = @"";
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Store_Home parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        return;
    }];
}
/**
  设置tableview
 */
-(void)setupTableView
{
    self.tableview.delegate = self;
    self.tableview.dataSource  = self;
    self.tableview.backgroundColor = [UIColor clearColor];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreCell *cell = [StoreCell stroeCellWithTableView:tableView];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    cell.test_lab.text = self.typeStr;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
