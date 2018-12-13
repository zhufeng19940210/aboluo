//  StoreDetailVC.m
//  aboluo
//  Created by zhufeng on 2018/11/16.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "StoreDetailVC.h"
#import "StoreCell.h"
#import "StoreProductDetailVC.h"
#import "StoreDetailModel.h"
#import "StoreProductModel.h"
@interface StoreDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *storeArray;
@property (nonatomic,assign)int page;
@end
@implementation StoreDetailVC
-(NSMutableArray *)storeArray
{
    if (!_storeArray) {
        _storeArray = [NSMutableArray array];
    }
    return _storeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self acitonNewData];
    [self setupTableView];
    [self setupRefresh];
}

-(void)setupRefresh
{
    [self setViewRefreshTableView:self.tableview
                 withHeaderAction:@selector(acitonNewData)
                  andFooterAction:@selector(acitonMoreData) target:self];
}
/**
 请求最新的数据
 */
-(void)acitonNewData
{
    self.page = 1;
    [SVProgressHUD showWithStatus:ShowTitleTip];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSLog(@"self.typeStr:%@",self.typeStr);
    param[@"categoryId"]  = self.typeStr;
    param[@"currPage"] = [NSString stringWithFormat:@"%d",self.page];
    param[@"pageSize"]  = @10;
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Company_Category parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:ShowSuccessTip];
            [weakSelf.storeArray removeAllObjects];
            weakSelf.storeArray = [StoreProductModel mj_objectArrayWithKeyValuesArray:res.data[@"itemList"]];
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
/**
  请求更多的数据
 */
-(void)acitonMoreData
{
    self.page++;
    [SVProgressHUD showWithStatus:ShowTitleTip];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"categoryId"]  = self.typeStr;
    param[@"currPage"] = [NSString stringWithFormat:@"%d",self.page];
    param[@"pageSize"]  = @10;
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Company_Category parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:ShowSuccessTip];
            NSMutableArray *array = [NSMutableArray array];
            array = [StoreDetailModel mj_objectArrayWithKeyValuesArray:res.data[@"itemList"]];
            [weakSelf.storeArray addObjectsFromArray:array];
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
/**
  设置tableview
 */
-(void)setupTableView
{
    self.tableview.delegate = self;
    self.tableview.dataSource  = self;
    self.tableview.backgroundColor = [UIColor clearColor];
    //注册cell
    [self.tableview registerNib:[UINib nibWithNibName:@"StoreCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"StoreCell"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.storeArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreCell *cell = [StoreCell stroeCellWithTableView:tableView];
    StoreProductModel *productmodel = self.storeArray[indexPath.row];
    cell.productmodel = productmodel;
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    StoreProductModel *model = self.storeArray[indexPath.row];
    StoreProductDetailVC *productdetailvc = [[StoreProductDetailVC alloc]init];
    productdetailvc.orderId = model.pid;
    [self.navigationController pushViewController:productdetailvc animated:YES];
}
@end
