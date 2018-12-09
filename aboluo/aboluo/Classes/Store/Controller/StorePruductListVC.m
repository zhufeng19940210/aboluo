//  StorePruductListVC.m
//  aboluo
//  Created by zhufeng on 2018/12/8.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "StorePruductListVC.h"
#import "StoreCell.h"
#import "StoreDetailModel.h"
#import "StoreProductDetailVC.h"
@interface StorePruductListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *categoryArray;
@property (nonatomic,assign)int page;
@end
@implementation StorePruductListVC
-(NSMutableArray *)categoryArray
{
    if (!_categoryArray) {
        _categoryArray = [NSMutableArray array];
    }
    return _categoryArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.typeModel.name;
    self.page = 1;
    [self actionNewData];
    [self setupReresh];
    [self setupTableView];
}
-(void)setupReresh
{
    [self setViewRefreshTableView:self.tableview
                 withHeaderAction:@selector(actionNewData)
                  andFooterAction:@selector(actionNoreData)
                           target:self];
}
/**
加载最新的数据
 */
-(void)actionNewData
{
    self.page = 1;
    [SVProgressHUD showWithStatus:ShowTitleTip];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"categoryId"] = self.typeModel.pid;
    param[@"currPage"] = [NSString stringWithFormat:@"%d",self.page];
    param[@"pageSize"] = @"10";
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Company_Category parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code ==1) {
            [SVProgressHUD showSuccessWithStatus:ShowSuccessTip];
            [weakSelf.categoryArray removeAllObjects];
            weakSelf.categoryArray = [StoreDetailModel mj_objectArrayWithKeyValuesArray:res.data[@""]];
        }else{
            [SVProgressHUD showErrorWithStatus:res.msg];
            return ;
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
/**
 加载更多的数据
 */
-(void)actionNoreData
{
    self.page++;
    [SVProgressHUD showWithStatus:ShowTitleTip];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"categoryId"] = self.typeModel.pid;
    param[@"currPage"] = [NSString stringWithFormat:@"%d",self.page];
    param[@"pageSize"] = @"10";
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Company_Category parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code ==1) {
            [SVProgressHUD showSuccessWithStatus:ShowSuccessTip];
            NSMutableArray *arry = [NSMutableArray array];
            arry = [StoreDetailModel mj_objectArrayWithKeyValuesArray:res.data[@""]];
            [weakSelf.categoryArray addObjectsFromArray:arry];
        }else{
            [SVProgressHUD showErrorWithStatus:res.msg];
            return ;
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
    self.tableview.backgroundColor =[UIColor whiteColor];
    //注册cell
    [self.tableview registerNib:[UINib nibWithNibName:@"StoreCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"StoreCell"];
}
#pragma mark -- uitableviewdelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categoryArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreCell *cell = [StoreCell stroeCellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    StoreDetailModel *storedetail  = self.categoryArray[indexPath.row];
    StoreProductDetailVC *productdetailvc  = [[StoreProductDetailVC alloc]init];
    productdetailvc.detailModel = storedetail;
    [self.navigationController pushViewController:productdetailvc animated:YES];
}
@end
