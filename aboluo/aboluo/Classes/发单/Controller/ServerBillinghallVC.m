//  ServerBillinghallVC.m
//  aboluo
//  Created by zhufeng on 2018/11/16.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "ServerBillinghallVC.h"
@interface ServerBillinghallVC ()
@property (nonatomic,strong)NSMutableArray *imgArray;
@end
@implementation ServerBillinghallVC
-(NSMutableArray *)imgArray
{
    if (!_imgArray) {
        _imgArray = [NSMutableArray array];
    }
    return _imgArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布订单";
    [self setRightButtonText:@"发布" withColor:[UIColor whiteColor]];
}
/**
 发布的按钮
 @param button 发布按钮
 */
- (void)onRightBtnAction:(UIButton *)button
{
    NSLog(@"发布");
    [SVProgressHUD showWithStatus:@"正在发布"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"senderId"]    =  @"";
    param[@"title"]       =  @"";
    param[@"startTime"]   =  @"";
    param[@"overTime"]    =  @"";
    param[@"projectPay"]  =  @"";
    param[@"contents"]    =  @"";
    param[@"productId"]   =  @"";
    param[@"engineerId"]  =  @"";
    param[@"sellerId"]    =  @"";
    param[@"checkWay"]    =  @"";
    WEAKSELF
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",nil];
    [manager POST:@"http://47.93.238.67:9999/htshop/borrowAuthentication/modifybankAuthen" parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i <self.imgArray.count; i ++) {
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            formatter.dateFormat=@"yyyyMMddHHmmss";
            NSString *str=[formatter stringFromDate:[NSDate date]];
            NSString *fileName=[NSString stringWithFormat:@"%@.jpg",str];
            NSLog(@"selectimageurl:%@",fileName);
            UIImage *image = self.self.imgArray[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            NSLog(@"iMAGEdata:%@",imageData);
            [formData appendPartWithFileData:imageData name:@"bankimg" fileName:fileName mimeType:@"image/jpg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"上传失败"];
            return;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        return;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
