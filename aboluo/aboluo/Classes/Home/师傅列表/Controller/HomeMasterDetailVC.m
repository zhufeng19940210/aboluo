//  HomeMasterDetailVC.m
//  aboluo
//  Created by zhufeng on 2018/11/25.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "HomeMasterDetailVC.h"
#import "MasterDetailHeaderCell.h"
#import "MasterDetailConetnCell.h"
#import "MasterDetailPhoneCell.h"
@interface HomeMasterDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSDictionary *resParam;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *titleArray;
@end
@implementation HomeMasterDetailVC
-(NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"",@"",@"", nil];
    }
    return _titleArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"";
    self.view.backgroundColor = RGB(240, 240, 240);
    [self actionMasterDetailNewData];
    [self setupRefresh];
    [self setupTableView];
}
-(void)setupRefresh
{
    [self setViewRefreshTableView:self.tableview
                 withHeaderAction:@selector(actionMasterDetailNewData)
                  andFooterAction:nil target:self];
}
-(void)setupTableView
{
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor clearColor];
}
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
        return 1;
    }else{
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 180;
    }else if (indexPath.section == 1){
        return 50;
    }else if(indexPath.section == 2){
        return  50;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *detailCell = nil;
    if (indexPath.section == 0) {
        MasterDetailHeaderCell *headerCell = [MasterDetailHeaderCell BaseCellWithTableView:tableView];
        detailCell = headerCell;
    }if (indexPath.section == 1) {
        MasterDetailConetnCell *contentCell = [MasterDetailConetnCell BaseCellWithTableView:tableView];
        detailCell = contentCell;
    }if (indexPath.section == 2) {
        MasterDetailPhoneCell *phoneCell = [MasterDetailPhoneCell BaseCellWithTableView:tableView];
        detailCell = phoneCell;
    }
    detailCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return detailCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/**
 请求数据
 */
-(void)actionMasterDetailNewData
{
    [SVProgressHUD showWithStatus:ShowSuccessTip];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = @"";
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Master_Deatil parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"师傅详情:%@",responseObject);
        [SVProgressHUD dismiss];
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:ShowSuccessTip];
            weakSelf.resParam = res.data[@""];
        }else{
            [SVProgressHUD showErrorWithStatus:ShowErrorTip];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        return ;
    }];
}
/**
 预约师傅
 @param sender 预约师傅
 */
- (IBAction)actionYuyueBtn:(UIButton *)sender
{
    [SVProgressHUD showWithStatus:ShowTitleTip];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@""] = @"";
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:@"" parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:@"预约成功"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:res.msg];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        return;
    }];
}
@end
