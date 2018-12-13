//  ServerBillingruleVC.m
//  aboluo
//  Created by zhufeng on 2018/11/16.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "ServerBillingruleVC.h"
@interface ServerBillingruleVC ()
@property (weak, nonatomic) IBOutlet UITextView *textview;
@end
@implementation ServerBillingruleVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.textview.layer.cornerRadius = 8.0f;
    self.textview.layer.masksToBounds = YES;
    self.textview.layer.borderWidth = 1.0;
    self.textview.layer.borderColor = MainThemeColor.CGColor;
    [self setupData];
}
-(void)setupData
{
    [SVProgressHUD showWithStatus:ShowTitleTip];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"productId"] = self.typeStr;
    param[@"style"] = @"1";
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:FanDan_Alter_Url parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [SVProgressHUD showSuccessWithStatus:ShowSuccessTip];
            weakSelf.textview.text = res.data[@"notice"][@"contents"];
        }else{
            [SVProgressHUD showErrorWithStatus:res.msg];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        return;
    }];
}
@end

