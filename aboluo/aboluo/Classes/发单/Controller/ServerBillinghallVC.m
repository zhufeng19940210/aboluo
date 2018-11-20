//  ServerBillinghallVC.m
//  aboluo
//  Created by zhufeng on 2018/11/16.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "ServerBillinghallVC.h"
@interface ServerBillinghallVC ()
@end
@implementation ServerBillinghallVC
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
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
