//  HomeProjectDetailVC.m
//  aboluo
//  Created by zhufeng on 2018/11/25.
//  Copyright © 2018 zhufeng. All rights reserved
#import "HomeProjectDetailVC.h"
#import "ProjectDetailHeaderCell.h"
#import "ProjectDetailContentCell.h"
#import "ProjectDetailNumberCell.h"
#import "ProjectDetailMasterCell.h"
@interface HomeProjectDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableDictionary *resParam;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic,strong)NSMutableArray *contentArray;
@property (nonatomic,strong)NSMutableArray *masterArray;
@end
@implementation HomeProjectDetailVC
-(NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
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
   // [self setupTableView];
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
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return self.titleArray.count;
    }else if(section == 2){
        return 2;
    }else{
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *projectCell = nil;
    if (indexPath.section == 0) {
        ProjectDetailHeaderCell *headerCell = [ProjectDetailHeaderCell BaseCellWithTableView:tableView];
        projectCell = headerCell;
    }else if(indexPath.section == 1){
        ProjectDetailContentCell *contnetCell = [ProjectDetailContentCell BaseCellWithTableView:tableView];
        projectCell = contnetCell;
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            ProjectDetailNumberCell *numberCell = [ProjectDetailNumberCell BaseCellWithTableView:tableView];
            projectCell = numberCell;
        }else{
            ProjectDetailMasterCell *masterCell = [ProjectDetailMasterCell BaseCellWithTableView:tableView];
            projectCell = masterCell;
        }
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
    [SVProgressHUD showWithStatus:ShowTitleTip];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"projectId"] = self.detailModel.projectId;
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Project_Detail parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"项目详情responseobject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:ShowSuccessTip];
            weakSelf.resParam = res.data[@"data"];
        }else{
            [SVProgressHUD showErrorWithStatus:ShowErrorTip];
            return ;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        return;
    }];
}

@end
