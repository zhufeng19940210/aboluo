//  HomeProjectDetailVC.m
//  aboluo
//  Created by zhufeng on 2018/11/25.
//  Copyright © 2018 zhufeng. All rights reserved
#import "HomeProjectDetailVC.h"
#import "ProjectDetailHeaderCell.h"
#import "ProjectDetailContentCell.h"
@interface HomeProjectDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableDictionary *resParam;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic,strong)NSMutableArray *contentArray;
@property (nonatomic,strong)NSMutableArray *masterArray;
@property (nonatomic,copy)NSString *name;
@end
@implementation HomeProjectDetailVC
-(NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"开始时间:",@"结束时间:",@"总费用:",@"联系人:",@"联系电话:", nil];
    }
    return _titleArray;
}
-(NSMutableArray *)contentArray
{
    if (!_contentArray) {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}
-(NSMutableArray *)masterArray
{
    if (!_masterArray) {
        _masterArray = [NSMutableArray array];
    }
    return _masterArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"项目详情";
    self.view.backgroundColor = RGB(240, 240, 240);
    [self actionProjectDetailNewData];
    [self setupRefreh];
    [self setupTableView];
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
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return self.titleArray.count;
    }else{
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 180;
    }else{
        return 50;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *projectCell = nil;
    if (indexPath.section == 0) {
        ProjectDetailHeaderCell *headerCell = [ProjectDetailHeaderCell BaseCellWithTableView:tableView];
        headerCell.content_lab.text = self.name;
        headerCell.adscrollview.placeholderImage =[UIImage imageNamed:Default_Img2];
        headerCell.adscrollview.imageURLStringsGroup = self.masterArray;
        projectCell = headerCell;
    }else if(indexPath.section == 1){
        ProjectDetailContentCell *contnetCell = [ProjectDetailContentCell BaseCellWithTableView:tableView];
        contnetCell.title_lab.text = self.titleArray[indexPath.row];
        if (self.contentArray.count>0) {
            contnetCell.content_lab.text = self.contentArray[indexPath.row];
        }
        projectCell = contnetCell;
    }
    projectCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return projectCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/**
 刷新数据
 */
-(void)setupRefreh
{
    [self setViewRefreshTableView:self.tableview
                 withHeaderAction:@selector(actionProjectDetailNewData) andFooterAction:nil
                           target:self];
}
/**
 请求数据
 */
-(void)actionProjectDetailNewData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"projectId"] = self.detailModel.projectId;
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Project_Detail parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"项目详情responseobject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [weakSelf.contentArray removeAllObjects];
            [weakSelf.masterArray removeAllObjects];
            NSDictionary *dict = res.data[@"project"];
            weakSelf.name = dict[@"name"];
            NSString *img  = dict[@"img"];
            NSString *cost = [NSString stringWithFormat:@"%d",dict[@"cost"]];
            NSString *startTime  = dict[@"startTime"];
            NSString *overTime   = dict[@"overTime"];
            NSString *contact    = dict[@"contact"];
            NSString *phone      = dict[@"phone"];
            [weakSelf.contentArray addObject:startTime];
            [weakSelf.contentArray addObject:overTime];
            [weakSelf.contentArray addObject:cost];
            [weakSelf.contentArray addObject:contact];
            [weakSelf.contentArray addObject:phone];
            [weakSelf.tableview reloadData];
            [weakSelf.masterArray addObject:img];
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

@end
