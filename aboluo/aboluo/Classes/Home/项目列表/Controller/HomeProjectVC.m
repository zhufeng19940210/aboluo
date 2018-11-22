//  HomeProjectVC.m
//  aboluo
//  Created by zhufeng on 2018/11/15.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "HomeProjectVC.h"
#import "ProjectCell.h"
#import "HomeProjectDetailModel.h"
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
    self.navigationItem.title = [NSString stringWithFormat:@"%@",self.typemodel.name];
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
    [SVProgressHUD showWithStatus:ShowTitleTip];
    self.page = 1;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Project_List parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:ShowSuccessTip];
            [weakSelf.projectArray removeAllObjects];
            weakSelf.projectArray = [HomeProjectDetailModel mj_objectArrayWithKeyValuesArray:res.data[@""]];
            [weakSelf.tableview reloadData];
            [weakSelf.tableview.mj_header endRefreshing];
        }else{
            [SVProgressHUD showErrorWithStatus:ShowErrorTip];
            return ;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
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
    [SVProgressHUD showWithStatus:ShowTitleTip];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"page"] =[NSString stringWithFormat:@"%d",self.page];
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Project_List parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:ShowSuccessTip];
            NSMutableArray *array = [NSMutableArray array];
            array = [HomeProjectDetailModel mj_objectArrayWithKeyValuesArray:res.data[@""]];
            [weakSelf.projectArray addObjectsFromArray:array];
            [weakSelf.tableview reloadData];
            [weakSelf.tableview.mj_header endRefreshing];
        }else{
            [SVProgressHUD showErrorWithStatus:ShowErrorTip];
            return ;
        }
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
