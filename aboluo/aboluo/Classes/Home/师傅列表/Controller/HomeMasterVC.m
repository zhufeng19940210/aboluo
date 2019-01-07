//  HomeMasterVC.m
//  aboluo
//  Created by zhufeng on 2018/11/15.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "HomeMasterVC.h"
#import "MasterCell.h"
#import "HomeMasterModel.h"
#import "HomeMasterDetailVC.h"
#import "HomeMasterModel.h"
@interface HomeMasterVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *masterArray;
@property (nonatomic,assign)int page;
@end
@implementation HomeMasterVC
-(NSMutableArray *)masterArray
{
    if (!_masterArray) {
        _masterArray = [NSMutableArray array];
    }
    return _masterArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =[NSString stringWithFormat:@"%@师傅 ",self.typemodel.name];
    NSLog(@"wid:%@",self.typemodel.wid);
    self.page = 1;
    [self acitonMasterNewData];
    [self setupTableView];
    [self setupRefresh];
}
-(void)setupRefresh
{
    [self setViewRefreshTableView:self.tableview
                 withHeaderAction:@selector(acitonMasterNewData) andFooterAction:@selector(acitonMaterMoreData)
                           target:self];
}
/**
 请求最新数据
 */
-(void)acitonMasterNewData
{
    self.page = 1;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"productId"] = self.typemodel.wid;
    param[@"currPage"] = [NSString stringWithFormat:@"%d",self.page];
    param[@"pageSize"] = @10;
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Master_List parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [weakSelf.masterArray removeAllObjects];
            weakSelf.masterArray = [HomeMasterModel mj_objectArrayWithKeyValuesArray:res.data[@"list"]];
            [weakSelf.tableview reloadData];
            [weakSelf.tableview.mj_header endRefreshing];
        }else{
            return ;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [weakSelf.tableview.mj_header endRefreshing];
        return;
    }];
}
/**
 请求更多数据
 */
-(void)acitonMaterMoreData
{
    self.page++;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"productId"] = self.typemodel.wid;
    param[@"currPage"] = [NSString stringWithFormat:@"%d",self.page];
    param[@"pageSize"] = @10;
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Master_List parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            NSMutableArray *array = [NSMutableArray array];
            array = [HomeMasterModel mj_objectArrayWithKeyValuesArray:res.data[@"list"]];
            [weakSelf.masterArray addObjectsFromArray:array];
            [weakSelf.tableview reloadData];
            [weakSelf.tableview.mj_header endRefreshing];
        }else{
            return ;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.masterArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MasterCell *cell  = [MasterCell masterCellWithTableView:tableView];
    HomeMasterModel *mastermodel = self.masterArray[indexPath.row];
    cell.mastermodel = mastermodel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HomeMasterModel *mastermodel = self.masterArray[indexPath.row];
    HomeMasterDetailVC *detailvc = [[HomeMasterDetailVC alloc]init];
    detailvc.masterModel = mastermodel;
    [self.navigationController pushViewController:detailvc animated:YES];
}
@end
