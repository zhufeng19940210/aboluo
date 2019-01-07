//  SeverAcceptanceVC.m
//  aboluo
//  Created by zhufeng on 2018/12/11.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "SeverAcceptanceVC.h"
@interface SeverAcceptanceVC ()
@property (weak, nonatomic) IBOutlet UITextView *textview;
@end
@implementation SeverAcceptanceVC

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
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"productId"] = @"";
    param[@"style"] = self.typeStr;
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:FanDan_Alter_Url parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            weakSelf.textview.text = res.data[@"notice"][@"contents"];
        }else{
            [SVProgressHUD showErrorWithStatus:res.msg];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        return;
    }];
}
@end
