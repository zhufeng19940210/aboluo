//  SettingVC.m
//  aboluo
//  Created by zhufeng on 2018/11/3.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "SettingVC.h"
#import "SettingHeaderCell.h"
#import "SettingNormalCell.h"
#import "UserCertificateVC.h"
#import "UserInfoCenterVC.h"
#import "UserLevelVC.h"
#import "UserAmountVC.h"
@interface SettingVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *imagArray;
@property (nonatomic,strong)NSMutableArray *titleArray;
@end
@implementation SettingVC
-(NSMutableArray *)imagArray
{
    if (!_imagArray) {
        _imagArray = [NSMutableArray arrayWithObjects:@"setting_yue",@"setting_dengji",@"setting_zhengsu",@"setting_user", nil];
    }
    return _imagArray;
}
-(NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"余额",@"等级",@"证书",@"个人中心", nil];
    }
    return _titleArray;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    ///请求数据
    //[self setupData];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"会员";
    self.view.backgroundColor = RGB(240, 240, 240);
    [self setupTableView];
}
/**
 请求数据
 */
-(void)setupData
{
    [SVProgressHUD show];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:@"" parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responobject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:ShowSuccessTip];
        }else{
            [SVProgressHUD showErrorWithStatus:ShowErrorTip];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        return;
    }];
}
/**
 seutpTableview
 */
-(void)setupTableView
{
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor clearColor];
    [self.tableview registerNib:[UINib nibWithNibName:@"SettingHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SettingHeaderCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"SettingNormalCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SettingNormalCell"];
}

#pragma mark --uitableviewdelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 220;
    }else {
        return 50;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SettingHeaderCell *headercell = [tableView dequeueReusableCellWithIdentifier:@"SettingHeaderCell"];
        headercell.actionBlock = ^(SettingHeaderType type) {
            if (type == SettingHeaderTypeIcon) {
                //头像
                NSLog(@"头像");
            }else if(type == SettingHeaderTypeCode){
                //二维码
                NSLog(@"二维码");
            }else if (type == SettingHeaderTypeMine){
                //个人中心
                NSLog(@"个人中心");
            }
        };
        headercell.selectionStyle = UITableViewCellSelectionStyleNone;
        return headercell;
    }else{
        SettingNormalCell *normalcell = [tableView dequeueReusableCellWithIdentifier:@"SettingNormalCell"];
        normalcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return normalcell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        //余额
        UserAmountVC *amountvc = [[UserAmountVC alloc]init];
        [self.navigationController pushViewController:amountvc animated:YES];
    }else if(indexPath.section == 2){
        //等级
        UserLevelVC *levelvc = [[UserLevelVC alloc]init];
        [self.navigationController pushViewController:levelvc animated:YES];
    }else if (indexPath.section == 3){
        //证书
        UserCertificateVC *certificatevc = [[UserCertificateVC alloc]init];
        [self.navigationController pushViewController:certificatevc animated:YES];
    }else if (indexPath.section == 4){
        //个人中心
        UserInfoCenterVC *centervc = [[UserInfoCenterVC alloc]init];
        [self.navigationController pushViewController:centervc animated:YES];
    }
}
@end
