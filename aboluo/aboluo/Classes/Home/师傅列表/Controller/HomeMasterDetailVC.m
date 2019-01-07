//  HomeMasterDetailVC.m
//  aboluo
//  Created by zhufeng on 2018/11/25.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "HomeMasterDetailVC.h"
#import "MasterDetailHeaderCell.h"
#import "MasterDetailConetnCell.h"
#import "HomeMasterDetailModel.h"
@interface HomeMasterDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSDictionary *resParam;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic,strong)NSMutableArray *contentArray;
@property (nonatomic,strong)HomeMasterDetailModel *detailmodel;
@property (nonatomic,copy)NSString *head;
@end
@implementation HomeMasterDetailVC
-(NSMutableArray *)contentArray
{
    if (!_contentArray) {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}
-(NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"联系人:",@"工程师等级:",@"联系人电话:",@"诚信值:",@"工程量:", nil];
    }
    return _titleArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat:@"%@详情",self.masterModel.name];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 180;
    }else if (indexPath.section == 1){
        return 50;
    }else{
        return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *detailCell = nil;
    if (indexPath.section == 0) {
        MasterDetailHeaderCell *headerCell = [MasterDetailHeaderCell BaseCellWithTableView:tableView];
         [headerCell.icon_img sd_setImageWithURL:[NSURL URLWithString:self.head] placeholderImage:[UIImage imageNamed:Default_Img]];
        detailCell = headerCell;
    }if (indexPath.section == 1) {
        MasterDetailConetnCell *contentCell = [MasterDetailConetnCell BaseCellWithTableView:tableView];
        contentCell.title_lab.text = self.titleArray[indexPath.row];
        if (self.contentArray.count>0) {
            contentCell.content_lab.text = self.contentArray[indexPath.row];
        }
        detailCell = contentCell;
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
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSLog(@"userid:%@",self.masterModel.userId);
    param[@"userId"] = self.masterModel.userId;
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Master_Deatil parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"师傅详情:%@",responseObject);
        [SVProgressHUD dismiss];
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [weakSelf.contentArray removeAllObjects];
            NSDictionary *dict = res.data;
            NSString *name = dict[@"user"][@"commerce"][@"name"];
            NSString *level =[NSString stringWithFormat:@"%@",dict[@"user"][@"levelId"]];
            NSString *phone = dict[@"user"][@"phone"];
            NSString *score = [NSString stringWithFormat:@"%@",dict[@"user"][@"credit"]];
            NSString *nubmer2 = [NSString stringWithFormat:@"%d",dict[@"projectAmount"]];
            weakSelf.head = dict[@"user"][@"head"];
            [weakSelf.contentArray addObject:name];
            [weakSelf.contentArray addObject:level];
            [weakSelf.contentArray addObject:phone];
            [weakSelf.contentArray addObject:score];
            [weakSelf.contentArray addObject:nubmer2];
            [weakSelf.tableview reloadData];
            [weakSelf.tableview.mj_header endRefreshing];
        }else{
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [weakSelf.tableview.mj_header endRefreshing];
        return ;
    }];
}
@end
