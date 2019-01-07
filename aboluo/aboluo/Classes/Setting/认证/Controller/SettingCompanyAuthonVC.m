//  SettingCompanyAuthonVC.m
//  aboluo
//  Created by zhufeng on 2018/12/4.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "SettingCompanyAuthonVC.h"
@interface SettingCompanyAuthonVC ()<TZImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *company_img;
@property (weak, nonatomic) IBOutlet UITextField *name_tf;
@property (weak, nonatomic) IBOutlet UITextField *content_tf;
@property (nonatomic,strong)UIImage *company_img2;
@property (nonatomic,assign)BOOL isCompany;
@property (nonatomic,strong)UserModel *userModel;
@end
@implementation SettingCompanyAuthonVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"企业认证";
    self.userModel = [UserModel getInfo];
    self.company_img.userInteractionEnabled = YES;
    UITapGestureRecognizer *companyTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(companyTap:)];
    [self.company_img addGestureRecognizer:companyTap];
}
/**
  选择营业执照
 @param gestrue 选择营业执照
 */
-(void)companyTap:(UITapGestureRecognizer *)gestrue
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    [imagePickerVc setNaviBgColor:MainThemeColor];
    [imagePickerVc setAllowPreview:NO];
    [imagePickerVc setAllowPickingVideo:NO];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        self.isCompany = YES;
        self.company_img.image = photos[0];
        self.company_img2 = photos[0];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
/**
 认证
 @param sender 忍者
 */
- (IBAction)acitonAuthonBtn:(UIButton *)sender
{
    NSString *commpanyStr = self.name_tf.text;
    NSString *contnetxStr = self.content_tf.text;
    if (!self.isCompany) {
        [self showHint:@"营业执照不能为空" yOffset:-200];
        return;
    }
    if (commpanyStr.length == 0 || [commpanyStr isEqualToString:@""]) {
        [self showHint:@"公司名称不能为空" yOffset:-200];
        return;
    }
    if (contnetxStr.length == 0 || [contnetxStr isEqualToString:@""]) {
        [self showHint:@"所属行业不能为空" yOffset:-200];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = self.userModel;
    param[@"name"]   = commpanyStr;
    param[@"industryId"] = @"1";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",nil];
    [manager POST:Person_Authon parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            formatter.dateFormat=@"yyyyMMddHHmmss";
            NSString *str=[formatter stringFromDate:[NSDate date]];
            NSString *fileName=[NSString stringWithFormat:@"%@.jpg",str];
            NSLog(@"selectimageurl:%@",fileName);
            NSData *imageData = UIImageJPEGRepresentation(self.company_img2, 0.5);
            NSLog(@"iMAGEdata:%@",imageData);
            [formData appendPartWithFileData:imageData name:@"files" fileName:fileName mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code ==1) {
            [[NSUserDefaults standardUserDefaults]synchronize];
            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"上传失败"];
            return;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
        [SVProgressHUD dismiss];
        return;
    }];
}
@end
