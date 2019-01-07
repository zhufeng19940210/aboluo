//  HomeProjectVC.m
//  aboluo
//  Created by zhufeng on 2018/11/15.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "HomeProjectVC.h"
#import "ProjectCell.h"
#import "HomeProjectDetailModel.h"
#import "HomeProjectDetailVC.h"
@interface HomeProjectVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *projectArray;
@property (nonatomic,assign)int page;
@end
@implementation HomeProjectVC
-(NSMutableArray *)projectArray
{
    if (!_projectArray) {
        _projectArray = [NSMutableArray array];
    }
    return _projectArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat:@"%@项目",self.xiangmumodel.name];
    NSLog(@"xiangmuid:%@",self.xiangmumodel.wid);
    self.page = 1;
    [self acitonProjectNewData];
    [self setupTableView];
    [self setupRefresh];
}
-(void)setupRefresh
{
    [self setViewRefreshTableView:self.tableview
                 withHeaderAction:@selector(acitonProjectNewData) andFooterAction:@selector(acitonProjectMoreData)
                           target:self];
}
/**
   请求最新数据
 */
-(void)acitonProjectNewData
{
    self.page = 1;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"productId"] = self.xiangmumodel.wid;
    param[@"currPage"] = [NSString stringWithFormat:@"%d",self.page];
    param[@"pageSize"] = @10;
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Project_List parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [weakSelf.projectArray removeAllObjects];
            weakSelf.projectArray = [HomeProjectDetailModel mj_objectArrayWithKeyValuesArray:res.data[@"projects"]];
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
-(void)acitonProjectMoreData
{
    self.page++;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"productId"] = self.xiangmumodel.wid;
    param[@"currPage"] = [NSString stringWithFormat:@"%d",self.page];
    param[@"pageSize"] = @10;
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Project_List parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            NSMutableArray *array = [NSMutableArray array];
            array = [HomeProjectDetailModel mj_objectArrayWithKeyValuesArray:res.data[@"projects"]];
            [weakSelf.projectArray addObjectsFromArray:array];
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
    return self.projectArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectCell *cell  = [ProjectCell projectcellWithTableView:tableView];
    HomeProjectDetailModel *productmodel = self.projectArray [indexPath.row];
    cell.detailModel = productmodel;
    cell.projectblock = ^(HomeProjectDetailModel *detailmodel) {
        
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     HomeProjectDetailModel *productmodel = self.projectArray [indexPath.row];
    HomeProjectDetailVC *detailvc = [[HomeProjectDetailVC alloc]init];
    detailvc.detailModel = productmodel;
    [self.navigationController pushViewController:detailvc animated:YES];
}

/**
 抢单
 @param model 抢单的东西
 */
-(void)recviceWithModel:(HomeProjectDetailModel *)model
{
    UserModel *usermodel = [UserModel getInfo];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"projectId"] = model.productId;
    param[@"userId"]    = usermodel.aid;
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Project_Receive parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:@"抢单成功👍"];
        }else{
            [SVProgressHUD showErrorWithStatus:res.msg];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        return;
    }];
}
@end
