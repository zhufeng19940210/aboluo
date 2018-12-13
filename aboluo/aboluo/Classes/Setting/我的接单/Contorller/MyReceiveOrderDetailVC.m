//  MyReceiveOrderDetailVC.m
//  aboluo
//  Created by zhufeng on 2018/12/13.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "MyReceiveOrderDetailVC.h"
#import "MyOrderCell.h"
#import "MyOrderModel.h"
@interface MyReceiveOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *orderArray;
@property (nonatomic,strong)UserModel *usermodel;
@property (nonatomic,assign)int page;
@end
@implementation MyReceiveOrderDetailVC

-(NSMutableArray *)orderArray
{
    if (!_orderArray) {
        _orderArray = [NSMutableArray array];
    }
    return _orderArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(240, 240, 240);
    self.page = 1;
    self.usermodel = [UserModel getInfo];
    [self acitonSendNewData];
    [self setuupRefresh];
    [self setupTableView];
}
-(void)setuupRefresh
{
    [self setViewRefreshTableView:self.tableview
                 withHeaderAction:@selector(acitonSendNewData) andFooterAction:@selector(acitonSendMoreData)
                           target:self];
}

-(void)acitonSendNewData
{
    self.page = 1;
    [SVProgressHUD showWithStatus:ShowTitleTip];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = self.usermodel.aid;
    param[@"currPage"] = [NSString stringWithFormat:@"%d",self.page];
    param[@"pageSize"] = @10;
    param[@"state"]   = self.typeStr;
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Mine_Send_List_Url parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:ShowSuccessTip];
            [weakSelf.orderArray removeAllObjects];
            weakSelf.orderArray = [MyOrderModel mj_objectArrayWithKeyValuesArray:res.data[@"projects"]];
        }else{
            [SVProgressHUD showErrorWithStatus:res.msg];
            return;
        }
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_header endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        [weakSelf.tableview.mj_header endRefreshing];
        return;
    }];
}
-(void)acitonSendMoreData
{
    self.page ++ ;
    [SVProgressHUD showWithStatus:ShowTitleTip];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = self.usermodel.aid;
    param[@"currPage"] = [NSString stringWithFormat:@"%d",self.page];
    param[@"pageSize"] = @10;
    param[@"state"]   = self.typeStr;
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:@"" parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:ShowSuccessTip];
            NSMutableArray *array = [NSMutableArray array];
            array = [MyOrderModel mj_objectArrayWithKeyValuesArray:res.data[@"projects"]];
            [weakSelf.orderArray addObjectsFromArray:array];
        }else{
            [SVProgressHUD showErrorWithStatus:res.msg];
            return;
        }
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_header endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        [weakSelf.tableview.mj_header endRefreshing];
        return;
    }];
}
-(void)setupTableView
{
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor clearColor];
}

#pragma mark -- uitableviewdelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyOrderCell *cell = [MyOrderCell BaseCellWithTableView:tableView];
    MyOrderModel *ordermodel = self.orderArray[indexPath.section];
    cell.ordermodel = ordermodel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
