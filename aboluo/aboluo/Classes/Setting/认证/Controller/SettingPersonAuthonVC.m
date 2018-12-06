//  SettingPersonAuthonVC.m
//  aboluo
//  Created by zhufeng on 2018/12/4.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "SettingPersonAuthonVC.h"
@interface SettingPersonAuthonVC ()<TZImagePickerControllerDelegate>
@property (nonatomic,strong)NSMutableArray *selectImgArray;
@property (weak, nonatomic) IBOutlet UIImageView *zhenmian_img;
@property (weak, nonatomic) IBOutlet UIImageView *fanmian_img;
@property (weak, nonatomic) IBOutlet UITextField *name_tf;
@property (weak, nonatomic) IBOutlet UITextField *card_tf;
@property (nonatomic,strong)UIImage *fanmian_img2;
@property (nonatomic,strong)UIImage *zhenmain_img2;
@property (nonatomic,assign)BOOL isFanmain;
@property (nonatomic,assign)BOOL isZhenmain;
@end
@implementation SettingPersonAuthonVC
-(NSMutableArray *)selectImgArray
{
    if (!_selectImgArray) {
        _selectImgArray = [NSMutableArray array];
    }
    return _selectImgArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人认证";
    self.zhenmian_img.userInteractionEnabled = YES;
    self.fanmian_img.userInteractionEnabled = YES;
    UITapGestureRecognizer *zhenmianTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zhenmianTap:)];
    UITapGestureRecognizer *fanmianTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fanmianTap:)];
    [self.zhenmian_img addGestureRecognizer:zhenmianTap];
    [self.fanmian_img addGestureRecognizer:fanmianTap];
}

/**
 正面图片
 @param gesture 正面图片
 */
-(void)zhenmianTap:(UITapGestureRecognizer *)gesture
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    [imagePickerVc setNaviBgColor:MainThemeColor];
    [imagePickerVc setAllowPreview:NO];
    [imagePickerVc setAllowPickingVideo:NO];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        self.isZhenmain = YES;
        self.zhenmian_img.image = photos[0];
        self.zhenmain_img2 = photos[0];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
/**
 反面图片
 @param geseture 反面图片
 */
-(void)fanmianTap:(UITapGestureRecognizer *)geseture
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    [imagePickerVc setNaviBgColor:MainThemeColor];
    [imagePickerVc setAllowPreview:NO];
    [imagePickerVc setAllowPickingVideo:NO];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        self.isFanmain = YES;
        self.fanmian_img.image = photos[0];
        self.fanmian_img2 = photos[0];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
/**
 提交认证
 @param sender 提交认证
 */
- (IBAction)actionCommitBtn:(UIButton *)sender
{
    NSString *name = self.name_tf.text;
    NSString *card = self.card_tf.text;
    if (!self.isZhenmain ) {
        [self showHint:@"请先选择正面身份证" yOffset:-200];
        return;
    }
    if (!self.isFanmain) {
        [self showHint:@"请先选择反面身份证" yOffset:-200];
        return;
    }
    if (name.length == 0 || [name isEqualToString:@""]) {
        [self showHint:@"姓名不能为空" yOffset:-200];
        return;
    }
    if (card.length ==0 || [card isEqualToString:@""]) {
        [self showHint:@"身份证号码不能为空" yOffset:-200];
        return;
    }
    if (![LCUtil isValidIDNumber:card]) {
        [self showHint:@"身份证有误" yOffset:-200];
        return;
    }
    [self.selectImgArray removeAllObjects];
    [self.selectImgArray addObject:self.zhenmain_img2];
    [self.selectImgArray addObject:self.fanmian_img2];
    [SVProgressHUD show];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = @"12";
    param[@"name"]   = name;
    param[@"cardId"] = @"888888383";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",nil];
    [manager POST:Person_Authon parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i <self.selectImgArray.count; i ++) {
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            formatter.dateFormat=@"yyyyMMddHHmmss";
            NSString *str=[formatter stringFromDate:[NSDate date]];
            NSString *fileName=[NSString stringWithFormat:@"%@.jpg",str];
            NSLog(@"selectimageurl:%@",fileName);
            UIImage *image = self.self.selectImgArray[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            NSLog(@"iMAGEdata:%@",imageData);
            [formData appendPartWithFileData:imageData name:@"files" fileName:fileName mimeType:@"image/jpg"];
        }
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
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        return;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
