//  HomeAddressVC.m
//  aboluo
//  Created by zhufeng on 2018/11/15.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "HomeAddressVC.h"
@interface HomeAddressVC ()
@end
@implementation HomeAddressVC
- (void)viewDidLoad {
    [super viewDidLoad];

}

/**
  测试数据了
 @param sender 测试数据
 */
- (IBAction)actionSelectBtn:(id)sender
{
    NSString *selecstr = @"龙华新区";
    self.addreessblock(selecstr);
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
