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
#import "SettingLogoutCell.h"
#import "SettingPersonAuthonVC.h"
#import "SettingCompanyAuthonVC.h"
#import "LoginVC.h"
#import "AppDelegate.h"
#import "OpenshopVC.h"
#import "PersonalinformationPage.h"
@interface SettingVC ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *personimagArray;
@property (nonatomic,strong)NSMutableArray *persontitleArray;
@property (nonatomic,strong)NSMutableArray *companyimagArray;
@property (nonatomic,strong)NSMutableArray *companytitleArray;
@property (nonatomic,strong)UserModel *usermodel;
@end
@implementation SettingVC
-(NSMutableArray *)personimagArray
{
    if (!_personimagArray) {
        _personimagArray = [NSMutableArray arrayWithObjects:@"setting_yue",@"setting_dengji",@"setting_zhengsu",@"setting_user",@"setting_authon", nil];
    }return _personimagArray;
}

-(NSMutableArray *)persontitleArray
{
    if (!_persontitleArray) {
        _persontitleArray = [NSMutableArray arrayWithObjects:@"余额",@"等级",@"证书",@"个人中心",@"去认证", nil];
    }
    return _persontitleArray;
}
-(NSMutableArray *)companyimagArray
{
    if (!_companyimagArray ) {
        _companyimagArray = [NSMutableArray arrayWithObjects:@"setting_yue",@"setting_dengji",@"setting_qiye",@"seting_kaidian",@"setting_authon", nil];
    }
    return _companyimagArray;
}
-(NSMutableArray *)companytitleArray
{
    if (!_companytitleArray) {
        _companytitleArray = [NSMutableArray arrayWithObjects:@"余额",@"等级",@"企业中心",@"申请开店",@"去认证", nil];
    }
    return _companytitleArray;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.usermodel = [UserModel getInfo];
    [self setupData];
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
    [self.tableview registerNib:[UINib nibWithNibName:@"SettingLogoutCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SettingLogoutCell"];
}
#pragma mark --uitableviewdelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.persontitleArray.count+1;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 220;
        }else{
            return 60;
        }
    }else{
        return 50;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            SettingHeaderCell *headercell = [tableView dequeueReusableCellWithIdentifier:@"SettingHeaderCell"];
            if ([self.usermodel.roleId isEqualToString:@"0"]) {
                //个人
                headercell.setting_bg.image = [UIImage imageNamed:@"setting_bg.png"];
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
            }else{
                //企业
                headercell.setting_bg.image = [UIImage imageNamed:@"setting_bg_company.png"];
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
            }
            headercell.selectionStyle = UITableViewCellSelectionStyleNone;
            return headercell;
            
        }else{
            SettingNormalCell *normalcell = [tableView dequeueReusableCellWithIdentifier:@"SettingNormalCell"];
            if ([self.usermodel.roleId isEqualToString:@"0"]) {
                //个人
                normalcell.img_icon.image =[UIImage imageNamed:self.personimagArray[indexPath.row-1]];
                normalcell.title_lab.text = self.persontitleArray[indexPath.row-1];
            }else{
                //企业
                normalcell.img_icon.image =[UIImage imageNamed:self.companyimagArray[indexPath.row-1]] ;
                normalcell.title_lab.text = self.companytitleArray[indexPath.row-1];
            }
            normalcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return normalcell;
        }
    }else{
        SettingLogoutCell *logoutcell = [tableView dequeueReusableCellWithIdentifier:@"SettingLogoutCell"];
        logoutcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return logoutcell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if ([self.usermodel.roleId isEqualToString:@"0"]) {
            //个人
            if (indexPath.row == 1) {
                //余额
                UserAmountVC *amountvc = [[UserAmountVC alloc]init];
                [self.navigationController pushViewController:amountvc animated:YES];
            }else if(indexPath.row == 2){
                //等级
                UserLevelVC *levelvc = [[UserLevelVC alloc]init];
                [self.navigationController pushViewController:levelvc animated:YES];
            }else if (indexPath.row == 3){
                //证书
                UserCertificateVC *certificatevc = [[UserCertificateVC alloc]init];
                [self.navigationController pushViewController:certificatevc animated:YES];
            }else if (indexPath.row == 4){
                //个人中心
                UserInfoCenterVC *centervc = [[UserInfoCenterVC alloc]init];
                [self.navigationController pushViewController:centervc animated:YES];
            }else if(indexPath.row == 5){
                //去认证
                SettingPersonAuthonVC *personauthonvc = [[SettingPersonAuthonVC alloc]init];
                [self.navigationController pushViewController:personauthonvc animated:YES];
            }
        }else{
            //企业
            if (indexPath.row == 1) {
                //余额
                UserAmountVC *amountvc = [[UserAmountVC alloc]init];
                [self.navigationController pushViewController:amountvc animated:YES];
            }else if(indexPath.row == 2){
                //等级
                UserLevelVC *levelvc = [[UserLevelVC alloc]init];
                [self.navigationController pushViewController:levelvc animated:YES];
            }else if (indexPath.row == 3){
                //企业中心
                UserCertificateVC *certificatevc = [[UserCertificateVC alloc]init];
                [self.navigationController pushViewController:certificatevc animated:YES];
            }else if (indexPath.row == 4){
                //申请开店
                OpenshopVC *openshopvc = [[OpenshopVC alloc]init];
                [self.navigationController pushViewController:openshopvc animated:YES];
            }else if(indexPath.row == 5){
                //去认证
                SettingCompanyAuthonVC *companyvc =[[SettingCompanyAuthonVC alloc]init];
                [self.navigationController pushViewController:companyvc animated:YES];
            }
        }
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您确定退出登录吗?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self logoutMethod];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
/**
 退出登录
 */
-(void)logoutMethod
{
    //情况数据
    [UserModel logout];
    LoginVC *loginVC = [[LoginVC alloc]init];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
    app.window.backgroundColor = [UIColor whiteColor];
    app.window.rootViewController = nav;
    [app.window makeKeyAndVisible];
    [SVProgressHUD showSuccessWithStatus:@"退出成功"];
}
/**
 修改头像
 */
-(void)changeIconMethod
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    [imagePickerVc setAllowPreview:NO];
    [imagePickerVc setAllowPickingVideo:NO];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        //上传单张图片的东西
        [self uploadpath:photos[0]];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
/**
 上传单张图片
 @param selectImage 上传单张图片
 */
-(void)uploadpath:(UIImage *)selectImage{
    [SVProgressHUD show];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = self.usermodel.aid;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",nil];
    [manager POST:User_Update_Head parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        formatter.dateFormat=@"yyyyMMddHHmmss";
        NSString *str=[formatter stringFromDate:[NSDate date]];
        NSString *fileName=[NSString stringWithFormat:@"%@.jpg",str];
        NSLog(@"selectimageurl:%@",fileName);
        NSData *imageData = UIImageJPEGRepresentation(selectImage, 0.5);
        NSLog(@"iMAGEdata:%@",imageData);
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"success:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            NSString *avtorpath = res.data[@"photo"];
            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
            UserModel *model = [UserModel getInfo];
            model.head = avtorpath;
            [UserModel save:model];
        }else{
            [SVProgressHUD showErrorWithStatus:@"上传失败"];
            return;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showInfoWithStatus:@"服务器失败"];
        return;
    }];
}

@end
