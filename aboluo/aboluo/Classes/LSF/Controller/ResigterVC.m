//  ResigterVC.m
//  aboluo
//  Created by zhufeng on 2018/11/3.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "ResigterVC.h"
@interface ResigterVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoe_tf;
@property (weak, nonatomic) IBOutlet UITextField *code_tf;
@property (weak, nonatomic) IBOutlet UITextField *pwd_tf;
@end
@implementation ResigterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
}
/**
 注册的方法
 @param sender 注册的方法
 */
- (IBAction)actionResigsterBtn:(UIButton *)sender
{
    NSString *phone = self.phoe_tf.text;
    NSString *code  = self.code_tf.text;
    NSString *pwd   = self.pwd_tf.text;
    if ([phone isEqualToString:@""] || phone.length == 0) {
        [SVProgressHUD showInfoWithStatus:@""];
        return;
    }
    if ([code isEqualToString:@""] || code.length == 0) {
        
    }
    if ([pwd isEqualToString:@""] || pwd.length == 0) {
        
    }
    //todo执行登录的操作了
    
}
@end
