//  AddressListVC.m
//  aboluo
//  Created by zhufeng on 2018/11/17.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "AddressListVC.h"
#import "AddOrEditAddreddVC.h"
#import "AddreeListCell.h"
#import "AddressModel2.h"
@interface AddressListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *addreeArray;
@property (nonatomic,strong)UserModel *usermodel;
@property (nonatomic,assign)int page;
@end
@implementation AddressListVC
-(NSMutableArray *)addreeArray
{
    if (!_addreeArray) {
        _addreeArray = [NSMutableArray array];
    }
    return _addreeArray;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(RefreshMethod) name:UPDATESUCCESS object:nil];
}
-(void)RefreshMethod
{
    [self refresh];
}
///刷新界面
-(void)refresh
{
    [self setupData];
    [self.tableview reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.usermodel = [UserModel getInfo];
    self.navigationItem.title = @"管理收货地址";
    self.view.backgroundColor = RGB(240, 240, 240);
    [self setupData];
    [self seutpTableView];
}
//请求数据
-(void)setupData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = self.usermodel.aid;
    [[NetWorkTool shareInstacne]postWithURLString:Address_List_Url parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"responseObejct:%@",responseObject);
        [SVProgressHUD dismiss];
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [self.addreeArray removeAllObjects];
            self.addreeArray = [AddressModel2 mj_objectArrayWithKeyValuesArray:res.data[@"address"]];
            [self.tableview reloadData];
        }else{
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}
-(void)seutpTableView
{
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor  clearColor];
    [self.tableview registerNib:[UINib nibWithNibName:@"AddreeListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AddreeListCell"];
}
#pragma mark -- uitableviewdelgate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.addreeArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }else{
        return 5;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddreeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddreeListCell"];
    AddressModel2 *model = self.addreeArray[indexPath.section];
    cell.addressModel = model;
    //这里的block执行的命令
    cell.acitonBlock = ^(AddressOpertaionType type) {
        if (type == AddressOpertaionTypeDefault) {
            //设置成默认地址
            [self setupDefaultAddresWithModel:model];
        }else if (type == AddressOpertaionTypeDelete){
            //删除地址
            [self setupDeleteAddressWithModel:model];
        }else if (type == AddressOpertaionTypeEdit){
            //编辑地址
            [self setupEditAddressWithModel:model];
        }
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AddressModel2 *addressmodel = self.addreeArray[indexPath.section];
    //self.addressBlock(addressmodel);
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 设置成默认的地址
 @param addrssmodel 设置成默认的的地址
 */
-(void)setupDefaultAddresWithModel:(AddressModel2 *)addrssmodel
{
    NSLog(@"设置成默认地址");
    if (addrssmodel.isDefault == 1) {
        [self showHint:@"该地址已经是默认地址" yOffset:-200];
        return;
    }else{
        NSLog(@"addressmode.aid:%ld",(long)addrssmodel.aid);
        [SVProgressHUD show];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"addressId"]   = [NSString stringWithFormat:@"%ld",(long)addrssmodel.aid];
        [[NetWorkTool shareInstacne]postWithURLString:Address_Default_Url parameters:param success:^(id  _Nonnull responseObject) {
            NSLog(@"default:%@",responseObject);
            [SVProgressHUD dismiss];
            ResponeModel *res  = [ResponeModel mj_objectWithKeyValues:responseObject];
            if (res.code  == 1) {
                [SVProgressHUD showSuccessWithStatus:@"设置成功"];
                [self refresh];
            }else{
                [SVProgressHUD showErrorWithStatus:@"设置失败"];
                return ;
            }
        } failure:^(NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
            return;
        }];
    }
}
/**
 删除用户地址
 @param addressmodel 删除用户地址
 */
-(void)setupDeleteAddressWithModel:(AddressModel2 *)addressmodel
{
    NSLog(@"删除用户地址");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您确定删除该收货地址?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        ///删除功能
        [self deletAddressWithModel:addressmodel];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
/**
 删除用户资料
 @param addrssmodel 删除用户资料
 */
-(void)deletAddressWithModel:(AddressModel2 *)addrssmodel
{
    NSLog(@"addrssmodel.aid:%ld",(long)addrssmodel.aid);
    [SVProgressHUD show];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"addressId"]   = [NSString stringWithFormat:@"%ld",(long)addrssmodel.aid];
    [[NetWorkTool shareInstacne]postWithURLString:Address_Del_Url parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"删除的responseobject:%@",responseObject);
        [SVProgressHUD dismiss];
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            [self refresh];
        }else{
            [SVProgressHUD showErrorWithStatus:@"删除失败"];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        return;
    }];
}
/**
 编辑用户
 @param addressModel 编辑用户
 */
-(void)setupEditAddressWithModel:(AddressModel2 *)addressModel
{
    NSLog(@"编辑用户");
    AddOrEditAddreddVC *editvc = [[AddOrEditAddreddVC alloc]init];
    editvc.isAdd = YES;
    editvc.addressmodel = addressModel;
    [self.navigationController pushViewController:editvc animated:YES];
}
/**
 添加收货地址
 @param sender 添加收货地址
 */
-(IBAction)actionAddressageBtn:(UIButton *)sender
{
    AddOrEditAddreddVC *addressvc = [[AddOrEditAddreddVC alloc]init];
    addressvc.isAdd = NO;
    [self.navigationController pushViewController:addressvc animated:YES];
}
//移除内容
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UPDATESUCCESS object:nil];
}

@end
