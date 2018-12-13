//  ServerBillinghallVC.m
//  aboluo
//  Created by zhufeng on 2018/12/5.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "ServerBillinghallVC.h"
#import "ServerBillingHeaderCell.h"
#import "ServerBillingIntroductionCell.h"
#import "ServerBillingPictureCell.h"
#import "ServerBillingTypeCell.h"
#import "ServerBillingOrderTypeCell.h"
#import "ServerBillingAcceptanceCell.h"
#import "ServerBillingInsuranceCell.h"
#import "ServerBillingTotalCell.h"
#import "ServerConditionVC.h"
#import <MOFSPickerManager.h>
#import "EngineerLevelPage.h"
#import "CompanyLevelPage.h"
#import "InsurancePage.h"
@interface ServerBillinghallVC ()<UITableViewDelegate,UITableViewDataSource,ServerBillingInsuranceCellDelegate,ServerBillingOrderTypeCellDelegate,ServerBillingTypeCellDelegate,ServerBillingHeaderCellDelegate,ServerBillingPictureCellDelegate,TZImagePickerControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)ServerBillingHeaderCell *headercell;
@property (nonatomic,strong)ServerBillingIntroductionCell *introductcell;
@property (nonatomic,strong)ServerBillingPictureCell *picturecell;
@property (nonatomic,strong)ServerBillingTypeCell *typecell;
@property (nonatomic,strong)ServerBillingOrderTypeCell *orderTypecell;
@property (nonatomic,strong)ServerBillingAcceptanceCell *accptancecell;
@property (nonatomic,strong)ServerBillingInsuranceCell *insuracnecell;
@property (nonatomic,strong)ServerBillingTotalCell *totalcell;
@property (nonatomic,assign)int pingtai; //是
@property (nonatomic,copy)NSString *productId; ///工种id
@property (nonatomic,copy)NSString *dayPrice; ///每天的保险
@property (nonatomic,copy)NSString *engineerId;
@property (nonatomic,copy)NSString *compnyId;
@property (nonatomic,copy)NSString *insuranceId;
@property (nonatomic,strong)NSMutableArray *photoeArray;
@end
@implementation ServerBillinghallVC
-(NSMutableArray *)photoeArray
{
    if (!_photoeArray) {
        _photoeArray = [NSMutableArray array];
    }
    return _photoeArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发单详情";
    self.pingtai = 0;
    self.productId = @"";
    self.dayPrice = @"";
    self.engineerId = @"";
    self.compnyId = @"";
    self.insuranceId = @"";
    //[self setRightButtonText:@"发布" withColor:[UIColor whiteColor]];
    self.view.backgroundColor = RGB(240, 240, 240);
    [self setupData];
    [self setupTableView];
}
/**
 发布按钮
 @param button 发布按钮
 */
- (void)onRightBtnAction:(UIButton *)button
{
    if (![self isPushOrder]) {
        return;
    }
    [SVProgressHUD showWithStatus:ShowTitleTip];
    UserModel *usermodel = [UserModel getInfo];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"projectId"] = @"0";
    param[@"name"] = self.headercell.project_name_tf.text;
    param[@"contents"] = self.introductcell.intraductaion_view.text;
    param[@"cost"] = self.headercell.cost_price_tf.text;
    param[@"total"] = @5000;
    param[@"address"] = @"江西南昌";
    param[@"startTime"] = self.headercell.statr_time_tf.text;
    param[@"overTime"]  = self.headercell.end_time_tf.text;
    param[@"checkWay"] = [NSString stringWithFormat:@"%d",self.pingtai];
    param[@"productId"] = self.productId;
    param[@"engineerId"] = self.engineerId;
    param[@"companyLevelId"]= self.compnyId;
    param[@"state"] = @"-1";
    param[@"senderId"] = usermodel.aid;
    param[@"insuranceId"] = self.insuranceId;
    NSLog(@"pram:%@",param);
    WEAKSELF
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",nil];
    [manager POST:FaDan_Project_Send parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i <self.photoeArray.count; i ++) {
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            formatter.dateFormat=@"yyyyMMddHHmmss";
            NSString *str=[formatter stringFromDate:[NSDate date]];
            NSString *fileName=[NSString stringWithFormat:@"%@.jpg",str];
            NSLog(@"selectimageurl:%@",fileName);
            UIImage *image = self.self.photoeArray[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);;
            NSLog(@"iMAGEdata:%@",imageData);
            [formData appendPartWithFileData:imageData name:@"files" fileName:fileName mimeType:@"image/jpg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        [SVProgressHUD dismiss];
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code ==1) {
            [[NSUserDefaults standardUserDefaults]synchronize];
            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:res.msg];
            return;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        return;
    }];
}
//判断是否通过
-(BOOL)isPushOrder
{
    if ([self.headercell.project_name_tf.text isEqualToString:@""]) {
        [self showHint:@"项目名称不能为空" yOffset:-200];
        return  NO;
    }
    if ([self.headercell.statr_time_tf.text isEqualToString:@""]) {
        [self showHint:@"开始时间不能为空" yOffset:-200];
        return  NO;
    }
    if ([self.headercell.end_time_tf.text isEqualToString:@""]) {
        [self showHint:@"结束时间不能为空" yOffset:-200];
        return  NO;
    }
    if ([self.headercell.cost_price_tf.text isEqualToString:@""]) {
        [self showHint:@"施工费用不能为空" yOffset:-200];
        return  NO;
    }
    if ([self.introductcell.intraductaion_view.text isEqualToString:@""]) {
        [self showHint:@"项目介绍不能为空" yOffset:-200];
        return  NO;
    }
    if (self.photoeArray.count == 0) {
        [self showHint:@"项目图片不能为空" yOffset:-200];
        return  NO;
    }
    if ([self.orderTypecell.master_tf.text isEqualToString:@""] && [self.orderTypecell.company_tf.text isEqualToString:@""]) {
        [self showHint:@"接单类型不能为空" yOffset:-200];
        return NO;
    }
    if ([self.insuracnecell.insurance_tf.text isEqualToString:@""]) {
        [self showHint:@"保险类型不能为空" yOffset:-200];
        return NO;
    }
    return YES;
}
-(void)setupData
{
    
}
-(void)setupTableView
{
    self.tableview.delegate = self;
    self.tableview.dataSource  = self;
    self.tableview.backgroundColor = [UIColor clearColor];
    [self.tableview registerNib:[UINib nibWithNibName:@"ServerBillingHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ServerBillingHeaderCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"ServerBillingIntroductionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ServerBillingIntroductionCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"ServerBillingPictureCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ServerBillingPictureCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"ServerBillingTypeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ServerBillingTypeCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"ServerBillingOrderTypeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ServerBillingOrderTypeCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"ServerBillingAcceptanceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ServerBillingAcceptanceCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"ServerBillingInsuranceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ServerBillingInsuranceCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"ServerBillingTotalCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ServerBillingTotalCell"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  8;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 200;
    }else if(indexPath.section == 1){
        return 150;
    }else if(indexPath.section == 2){
        return 60+IPHONE_WIDTH/5;
    }else if(indexPath.section == 3) {
        return 50;
    }else if(indexPath.section == 4){
        return 120;
    }else if (indexPath.section == 5){
        return 150;
    }else if (indexPath.section == 6){
        return 50;
    }else if (indexPath.section == 7){
        return 60;
    }else{
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section !=8) {
        return 10;
    }else{
        return 30;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        self.headercell = [tableView dequeueReusableCellWithIdentifier:@"ServerBillingHeaderCell"];
        self.headercell.delegate = self;
        self.headercell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.headercell;
    }else if (indexPath.section == 1){
       self.introductcell = [tableView dequeueReusableCellWithIdentifier:@"ServerBillingIntroductionCell"];
        self.introductcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  self.introductcell;
    }else if(indexPath.section == 2){
        self.picturecell = [tableView dequeueReusableCellWithIdentifier:@"ServerBillingPictureCell"];
        self.picturecell.delegate = self;
        self.picturecell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.picturecell;
    }else if (indexPath.section == 3){
        self.typecell = [tableView dequeueReusableCellWithIdentifier:@"ServerBillingTypeCell"];
        self.typecell.deelgate = self;
        self.typecell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.typecell;
    }else if (indexPath.section == 4){
        self.orderTypecell = [tableView dequeueReusableCellWithIdentifier:@"ServerBillingOrderTypeCell"];
        self.orderTypecell.delegate = self;
        self.orderTypecell.selecttypeblock = ^(int tag) {
            NSLog(@"选择的tag:%d",tag);
        };
        self.orderTypecell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.orderTypecell;
    }else if (indexPath.section == 5){
        self.accptancecell = [tableView dequeueReusableCellWithIdentifier:@"ServerBillingAcceptanceCell"];
        WEAKSELF
        self.accptancecell.accptanceblock = ^(int tag) {
            NSLog(@"tag:%d",tag);
            weakSelf.pingtai = tag;
            [weakSelf calateTotalPricewithPiingtai:weakSelf.pingtai];
        };
        self.accptancecell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.accptancecell;
    }else if (indexPath.section == 6){
        self.insuracnecell = [tableView dequeueReusableCellWithIdentifier:@"ServerBillingInsuranceCell"];
        self.insuracnecell.delegate = self;
        self.insuracnecell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.insuracnecell;
    }else if(indexPath.section == 7){
        self.totalcell = [tableView dequeueReusableCellWithIdentifier:@"ServerBillingTotalCell"];
        self.totalcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.totalcell;
    }else{
        return nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark 计算价格
-(void)calateTotalPrice
{
    [self calateTotalPricewithPiingtai:self.pingtai];
}
-(BOOL)myVaildTiaoian
{
    NSLog(@"计算价格");
    BOOL isPush = NO;
    if (![self.headercell.statr_time_tf.text isEqualToString:@""]
        && ![self.headercell.end_time_tf.text isEqualToString:@""]
        && ![self.headercell.cost_price_tf.text isEqualToString:@""]
        && ![self.dayPrice isEqualToString:@""]) {
        if ([LCUtil CalculatedifferenceWithStarTime:self.headercell.statr_time_tf.text WithEndTime:self.headercell.end_time_tf.text] <0) {
            [self showHint:@"选择的时间有误"  yOffset:-200];
            isPush = NO;
        }else{
            isPush = YES;
        }
    }else{
        NSLog(@"条件不满足请先选择条件才行");
        isPush = NO;
    }
    return isPush;
}
#pragma mark 选择时间
-(void)pushSelectTimeMethodWithTag:(int)tag
{
    if (tag == 0) {
        //开始时间
        WEAKSELF
        [[MOFSPickerManager shareManger]showDatePickerWithTag:1 commitBlock:^(NSDate * _Nonnull date) {
            //用于格式化NSDate对象
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //设置格式：zzz表示时区
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *currentDateString = [dateFormatter stringFromDate:date];
            NSLog(@"date:%@",currentDateString);
            weakSelf.headercell.statr_time_tf.text = [NSString stringWithFormat:@"%@",currentDateString];
        } cancelBlock:^{
            
        }];
    }else{
        //结束时间
        WEAKSELF
        [[MOFSPickerManager shareManger]showDatePickerWithTag:1 commitBlock:^(NSDate * _Nonnull date) {
            //用于格式化NSDate对象
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //设置格式：zzz表示时区
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *currentDateString = [dateFormatter stringFromDate:date];
            NSLog(@"date:%@",currentDateString);
            weakSelf.headercell.end_time_tf.text = [NSString stringWithFormat:@"%@",currentDateString];
        } cancelBlock:^{
            
        }];
    }
}
-(void)calateTotalPricewithPiingtai:(int)pingtai
{
   BOOL isPush =  [self myVaildTiaoian];
    if (isPush == YES) {
        CGFloat totalPrice = 0.0;
        int day = [LCUtil CalculatedifferenceWithStarTime:self.headercell.statr_time_tf.text WithEndTime:self.headercell.end_time_tf.text];
        CGFloat insurece = [self.dayPrice floatValue] * day;
        NSLog(@"self.dayPrice:%@ day:%d",self.dayPrice,day);
        NSLog(@"insurece:%f",insurece);
        if (pingtai == 1) {
            //平台验收
            CGFloat pingtai  = [self.headercell.cost_price_tf.text floatValue] * 0.01 + [self.headercell.cost_price_tf.text floatValue] + insurece;
            totalPrice = insurece + pingtai;
        }else{
            //自主验收
            totalPrice =  [self.headercell.cost_price_tf.text floatValue] + insurece;
        }
        self.totalcell.total_lab.text = [NSString stringWithFormat:@"￥%2.f元",totalPrice];
    }else{
        
    }
}
#pragma mark 保险跳转
-(void)pushToInsuranceMethod
{
    //1.这里先胖
    //4表示保险等级
    InsurancePage *insurancepagevc = [[InsurancePage alloc]init];
    WEAKSELF
    [insurancepagevc setInsuracnepageblock:^(InsurancesModel *model) {
        NSLog(@"保险:%@",model.coverage);
        weakSelf.insuranceId = model.iid;
        weakSelf.dayPrice = model.premium;
        weakSelf.insuracnecell.insurance_tf.text = model.coverage;
        [weakSelf calateTotalPricewithPiingtai:weakSelf.pingtai];
    }];
    [self.navigationController pushViewController:insurancepagevc animated:YES];
}
#pragma mark 选择工种
-(void)pushSelectTypeMethod
{
    ServerConditionVC *conditionvc = [[ServerConditionVC alloc]init];
    WEAKSELF
    [conditionvc setConditionblock:^(GongZhongModel *model) {
        NSLog(@"工种:%@",model.name);
        weakSelf.productId = model.gid;
        weakSelf.typecell.gongzhong_lab.text = model.name;
    }];
    [self.navigationController pushViewController:conditionvc animated:YES];
}
#pragma mark -- 选择师傅等级,企业等级
-(void)pushSelectTypeWithTag:(int)tag
{
    if (tag == 0) {
        EngineerLevelPage *engieervc = [[EngineerLevelPage alloc]init];
        WEAKSELF
        [engieervc setEngineerblock:^(EngineerModel *model) {
            NSLog(@"师傅等级:%@",model.name);
            weakSelf.engineerId = model.eid;
            weakSelf.compnyId   = @"";
            weakSelf.orderTypecell.master_tf.text = model.name;
        }];
        [self.navigationController pushViewController:engieervc animated:YES];
    }else{
        CompanyLevelPage *compnayvc = [[CompanyLevelPage alloc]init];
        WEAKSELF
        [compnayvc setCommpayblcok:^(CompanyModel *model) {
            NSLog(@"企业等级:%@",model.name);
            weakSelf.compnyId = model.cid;
            weakSelf.engineerId = @"";
            weakSelf.orderTypecell.company_tf.text = model.name;
        }];
        [self.navigationController pushViewController:compnayvc animated:YES];
    }
}
#pragma mark --跳转到图片
-(void)BCYPhotoPushSelectWithType
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:3 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    [imagePickerVc setNaviBgColor:MainThemeColor];
    [imagePickerVc setAllowPreview:NO];
    [imagePickerVc setAllowPickingVideo:NO];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        //上传单张图片的东西
        [self.photoeArray removeAllObjects];
        [self.photoeArray addObjectsFromArray:photos];
        self.picturecell.selectArray = self.photoeArray;
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
/**
 发布订单
 @param sender 发布订单
 */
- (IBAction)actionPushBtn:(UIButton *)sender
{
    if (![self isPushOrder]) {
        return;
    }
    [SVProgressHUD showWithStatus:ShowTitleTip];
    UserModel *usermodel = [UserModel getInfo];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"projectId"] = @"0";
    param[@"name"] = self.headercell.project_name_tf.text;
    param[@"contents"] = self.introductcell.intraductaion_view.text;
    param[@"cost"] = self.headercell.cost_price_tf.text;
    param[@"total"] = @5000;
    param[@"address"] = @"江西南昌";
    param[@"startTime"] = self.headercell.statr_time_tf.text;
    param[@"overTime"]  = self.headercell.end_time_tf.text;
    param[@"checkWay"] = [NSString stringWithFormat:@"%d",self.pingtai];
    param[@"productId"] = self.productId;
    param[@"engineerId"] = self.engineerId;
    param[@"companyLevelId"]= self.compnyId;
    param[@"state"] = @"-1";
    param[@"senderId"] = usermodel.aid;
    param[@"insuranceId"] = self.insuranceId;
    NSLog(@"pram:%@",param);
    WEAKSELF
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",nil];
    [manager POST:FaDan_Project_Send parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i <self.photoeArray.count; i ++) {
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            formatter.dateFormat=@"yyyyMMddHHmmss";
            NSString *str=[formatter stringFromDate:[NSDate date]];
            NSString *fileName=[NSString stringWithFormat:@"%@.jpg",str];
            NSLog(@"selectimageurl:%@",fileName);
            UIImage *image = self.self.photoeArray[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);;
            NSLog(@"iMAGEdata:%@",imageData);
            [formData appendPartWithFileData:imageData name:@"files" fileName:fileName mimeType:@"image/jpg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        [SVProgressHUD dismiss];
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code ==1) {
            [[NSUserDefaults standardUserDefaults]synchronize];
            [SVProgressHUD showSuccessWithStatus:@"发单成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:res.msg];
            return;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        return;
    }];
}
@end

