//  AddressListVC.m
//  aboluo
//  Created by zhufeng on 2018/11/17.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "AddressListVC.h"
#import "AddressListCell.h"
#import "AddressModel.h"
#import "AddOrEditAddreddVC.h"
@interface AddressListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *addressArray;
@property (nonatomic,assign)int page;
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
    self.page = 1;
    self.navigationItem.title = @"管理收货地址";
    self.view.backgroundColor = RGB(240, 240, 240);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(actionUpdateList) name:UPDATESUCCESS object:nil];
    [self setupTableView];
    [self setupRrefresh];
}
/**
 刷新数据
 */
-(void)setupRrefresh
{
    [self setViewRefreshTableView:self.tableview
                 withHeaderAction:@selector(actionListNewData)
                  andFooterAction:@selector(actionListMoreData)
                           target:self];
}
/**
 更新界面文档
 */
-(void)actionUpdateList
{
    [self actionListNewData];
    [self.tableview reloadData];
}
/**
 加载最新数据
 */
-(void)actionListNewData
{
    [SVProgressHUD showWithStatus:ShowTitleTip];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@""] = @"";
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:@"" parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"responseobject:%@",responseObject);
        [SVProgressHUD dismiss];
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code ==1) {
            [weakSelf.addressArray removeAllObjects];
            weakSelf.addressArray = [AddressModel mj_objectArrayWithKeyValuesArray:res.data[@"list"]];
            [weakSelf.tableview reloadData];
            [weakSelf.tableview.mj_header endRefreshing];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        [weakSelf.tableview.mj_header endRefreshing];
        return ;
    }];
}
/**
 加载更多数据
 */
-(void)actionListMoreData
{
    [SVProgressHUD showWithStatus:ShowTitleTip];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@""] = @"";
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:@"" parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"responseobject:%@",responseObject);
        [SVProgressHUD dismiss];
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code ==1) {
            NSMutableArray *array = [NSMutableArray array];
            array = [AddressModel mj_objectArrayWithKeyValuesArray:res.data[@"list"]];
            [weakSelf.addressArray addObjectsFromArray:array];
            [weakSelf.tableview reloadData];
            [weakSelf.tableview.mj_footer endRefreshing];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        [weakSelf.tableview.mj_footer endRefreshing];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addressArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressListCell *cell = [AddressListCell AddressCellWithTableView:tableView];
    AddressModel *model = self.addressArray[indexPath.row];
    cell.addressmodel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/**
 添加地址
 @param sender 添加收货地址
 */
- (IBAction)actionAddreeBtn:(UIButton *)sender
{
    AddOrEditAddreddVC *addressvc = [[AddOrEditAddreddVC alloc]init];
    addressvc.isAdd = YES;
    [self.navigationController pushViewController:addressvc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
